package com.yy.wechat.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.model.DTO.request.OrderRequest;
import com.yy.wechat.model.VO.*;
import com.yy.wechat.model.entity.*;
import com.yy.wechat.model.message.OrderMessage;
import com.yy.wechat.config.RabbitConfig;
import com.yy.wechat.exception.BusinessException;
import com.yy.wechat.mapper.OrderItemMapper;
import com.yy.wechat.service.*;
import com.yy.wechat.mapper.OrderMapper;
import com.yy.wechat.utils.RequestContext;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final ProductService productService;
    private final RabbitTemplate rabbitTemplate;
    private final CartService cartService;
    private final MyCouponService myCouponService;
    private final CouponService couponService;
    private final OrderItemService orderItemService;
    private final UserService userService;

    /**
     * 创建订单主方法
     *
     * @param orderRequest 包含购物车商品信息的请求对象
     * @param userId       用户ID
     * @return 生成的订单ID
     */
    @Transactional
    public String createOrder(OrderRequest orderRequest, Long userId) {
        // 1. 使用雪花算法生成全局唯一订单ID
        long orderId = IdUtil.getSnowflakeNextId();

        if (orderMapper.selectOne(
                Wrappers.<Order>lambdaQuery()
                        .eq(Order::getStatus, 0)
                        .and(wq -> wq
                                .eq(Order::getTableId, orderRequest.tableId())
                                .or()
                                .eq(Order::getUserId, userId))) != null) {
            throw new BusinessException("存在待支付订单");
        }

        CartVO cartVO = cartService.getCart(orderRequest.tableId());
        if (cartVO == null || cartVO.items().isEmpty()) {
            throw new BusinessException("购物车为空");
        }
        // 2. 遍历购物车项，构建订单明细并计算总金额
        List<OrderItem> orderItems = new ArrayList<>();
        int totalAmount = 0;

        for (CartItemVO item : cartVO.items()) {
            if (item.quantity() <= 0) {
                throw new BusinessException("商品数量必须大于0");
            }

            // 查询商品实时价格和库存信息
            Product product = productService.getById(item.productId());
            if (product == null) {
                throw new BusinessException("商品不存在: " + item.productId());
            }

            // 检查库存是否充足
            if (product.getStock() < item.quantity()) {
                throw new BusinessException("商品库存不足: " + item.productId());
            }

            // 减库存、加销量
            product.setStock(product.getStock() - item.quantity());
            product.setSoldCount(product.getSoldCount() + item.quantity());
            productService.updateById(product);


            int unitPrice = product.getPriceCents();
            int itemTotal = unitPrice * item.quantity();

            // 构建订单项对象
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setProductId(item.productId());
            orderItem.setQuantity(item.quantity());
            orderItem.setUnitPrice(unitPrice);
            // 计算小计金额
            orderItem.setTotalPrice(itemTotal);

            orderItems.add(orderItem);
            totalAmount += itemTotal;
        }

        // 3. 创建主订单对象并持久化
        Order order = new Order();
        order.setId(orderId);
        order.setUserId(userId);
        order.setTableId(orderRequest.tableId());
        order.setEatNumber(orderRequest.eatNumber());
        order.setPayType(orderRequest.payType());
        if (orderRequest.remark() != null) {
            order.setRemark(orderRequest.remark());
        }
        if (orderRequest.myCouponId() != null) {
            Integer couponId = myCouponService.useCoupon(orderRequest.myCouponId());
            Coupon coupon = couponService.getById(couponId);
            if (coupon == null) {
                throw new BusinessException("优惠券不存在");
            }
            if (coupon.getCcondition() * 100 > totalAmount) {
                throw new BusinessException("订单金额小于优惠券使用条件");
            }
            if (coupon.getCvalue() * 100 >= totalAmount) {
                throw new BusinessException("优惠券使用金额大于订单金额");
            }
            if (!coupon.getStatus().equals("available")) {
                throw new BusinessException("优惠券已失效");
            }
            totalAmount -= coupon.getCvalue() * 100;
            order.setCouponId(orderRequest.myCouponId());
        }
        order.setTotalAmount(totalAmount);

        order.setStatus(0); // 初始状态为"未支付"

        // 插入主订单记录
        orderMapper.insert(order);

        // 批量插入订单明细
        orderItemMapper.batchInsert(orderItems);

        // 4. 发送订单超时消息到RabbitMQ延迟队列
        sendOrderTimeoutMessage(orderId);

        // 5. 清空购物车
        cartService.deleteCart(orderRequest.tableId());

        return String.valueOf(orderId);
    }

    /**
     * 发送订单超时检查消息到RabbitMQ
     *
     * @param orderId 订单ID
     */
    private void sendOrderTimeoutMessage(long orderId) {
        OrderMessage message = new OrderMessage(orderId, System.currentTimeMillis());
        rabbitTemplate.convertAndSend(
                RabbitConfig.ORDER_EXCHANGE,
                RabbitConfig.ORDER_DELAY_ROUTING_KEY,
                message,
                msg -> {
                    // 设置10分钟延迟（单位：毫秒）
//                    msg.getMessageProperties().setDelay(10 * 60 * 1000);
                    msg.getMessageProperties().setDelay(60 * 1000);
                    return msg;
                }
        );
    }

    /**
     * 处理订单支付
     *
     * @param orderId 订单ID
     */
    @Transactional
    public void processPayment(long orderId) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 0) { // 状态0表示"未支付"
            throw new BusinessException("订单当前状态不可支付");
        }
        if (order.getPayType() == 0) {
            if (order.getTotalAmount() > userService.getById(RequestContext.getCurrentUserId()).getBalance()) {
                throw new BusinessException("余额不足");
            }
            userService.update(Wrappers.<User>lambdaUpdate()
                    .eq(User::getId, RequestContext.getCurrentUserId())
                    .setSql("balance = balance - " + order.getTotalAmount()));
        }
        // 更新订单状态为已支付（状态1）
        orderMapper.updateStatus(orderId, 1);
    }

    /**
     * 完成订单处理
     *
     * @param orderId 订单ID
     */
    public void completeOrder(long orderId) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 1) { // 状态1表示"进行中"
            throw new BusinessException("只有进行中的订单可标记待评论");
        }
        // 更新订单状态为待评价（状态2）
        orderMapper.updateStatus(orderId, 2);
    }

    /**
     * 评论订单
     *
     * @param orderId 订单ID
     */
    public void commentOrder(long orderId) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 2) { // 状态2表示"待评论"
            throw new BusinessException("只有待评论的订单可标记完成");
        }
        // 更新订单状态为已完成（状态3）
        orderMapper.updateStatus(orderId, 3);
    }

    /**
     * 取消订单
     *
     * @param orderId 订单ID
     * @param reason  取消原因
     */
    public void cancelOrder(long orderId, String reason) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 0) { // 除非"未支付"状态，都不可取消
            throw new BusinessException("该订单不可取消");
        }

        // 处理库存释放和销量恢复逻辑
        orderItemService.revertStockAndSales(orderId);

        // 恢复优惠券状态
        if (order.getCouponId() != null) {
            myCouponService.revertCoupon(order.getCouponId());
        }

        // 更新订单状态为已取消（状态4）
        order.setStatus(4);
        updateById(order);
    }

    /**
     * 获取订单列表
     */
    @Override
    public List<OrderDetailVO> listOrders(Integer status, Long currentUserId) {
        // 1. 查询订单列表
        List<Order> orders = orderMapper.selectList(
                Wrappers.<Order>lambdaQuery()
                        .eq(Order::getUserId, currentUserId)
                        .eq(status != null, Order::getStatus, status)
                        .orderByDesc(Order::getCreatedAt)
        );

        if (orders.isEmpty()) {
            return Collections.emptyList();
        }

        // 2. 批量加载相关数据（优化性能）
        List<Long> orderIds = orders.stream().map(Order::getId).collect(Collectors.toList());
        Map<Long, List<OrderItem>> orderItemsMap = orderItemService.listByOrderIds(orderIds);

        // 获取所有相关的产品ID
        Set<Long> productIds = orderItemsMap.values().stream()
                .flatMap(List::stream)
                .map(OrderItem::getProductId)
                .collect(Collectors.toSet());

        Map<Long, Product> productsMap = productService.getProductsMapByIds(productIds);

        // 3. 批量加载优惠券数据
        Set<Integer> couponIds = orders.stream()
                .map(Order::getCouponId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Integer, Coupon> couponsMap = couponIds.isEmpty()
                ? Collections.emptyMap()
                : couponService.listByIds(couponIds).stream()
                .collect(Collectors.toMap(Coupon::getId, Function.identity()));

        // 4. 流式转换
        return orders.stream().map(order -> {
            List<OrderItemDetailVO> itemVOs = mapOrderItemsToDetailVO(
                    orderItemsMap.getOrDefault(order.getId(), Collections.emptyList()),
                    productsMap
            );

            Coupon coupon = couponsMap.get(order.getCouponId());
            Integer couponValue = coupon != null ? coupon.getCvalue() : 0;

            return OrderDetailVO.builder()
                    .orderId(String.valueOf(order.getId()))
                    .tableId(order.getTableId())
                    .totalAmount(order.getTotalAmount())
                    .couponValue(couponValue)
                    .items(itemVOs)
                    .build();
        }).collect(Collectors.toList());
    }

    /**
     * 订单项转换成订单详情项
     *
     * @param items       订单项列表
     * @param productsMap 产品映射
     * @return 订单详情项列表
     */
    private List<OrderItemDetailVO> mapOrderItemsToDetailVO(
            List<OrderItem> items,
            Map<Long, Product> productsMap) {

        return items.stream().map(item -> {
            Product product = productsMap.get(item.getProductId());

            return OrderItemDetailVO.builder()
                    .id(item.getId())
                    .name(product != null ? product.getName() : "")
                    .imageUrl(product != null ? product.getImageUrl() : "")
                    .quantity(item.getQuantity())
                    .priceCents(item.getUnitPrice())
                    .totalPrice(item.getUnitPrice() * item.getQuantity())
                    .build();
        }).collect(Collectors.toList());
    }
}

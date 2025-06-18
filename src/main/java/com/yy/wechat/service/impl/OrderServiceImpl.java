package com.yy.wechat.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.model.message.OrderMessage;
import com.yy.wechat.config.RabbitConfig;
import com.yy.wechat.exception.BusinessException;
import com.yy.wechat.mapper.OrderItemMapper;
import com.yy.wechat.model.DTO.request.CartItemRequest;
import com.yy.wechat.model.DTO.request.CartRequest;
import com.yy.wechat.model.entity.Order;
import com.yy.wechat.model.entity.OrderItem;
import com.yy.wechat.model.entity.Product;
import com.yy.wechat.service.OrderService;
import com.yy.wechat.mapper.OrderMapper;
import com.yy.wechat.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@Service
@RequiredArgsConstructor
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final ProductService productService;
    private final RabbitTemplate rabbitTemplate;

    /**
     * 创建订单主方法
     * 
     * @param cartRequest 包含购物车商品信息的请求对象
     * @param userId      用户ID
     * @return 生成的订单ID
     */
    @Transactional
    public Long createOrder(CartRequest cartRequest, Long userId) {
        // 1. 使用雪花算法生成全局唯一订单ID
        long orderId = IdUtil.getSnowflakeNextId();

        // 2. 遍历购物车项，构建订单明细并计算总金额
        List<OrderItem> orderItems = new ArrayList<>();
        int totalAmount = 0;

        for (CartItemRequest item : cartRequest.items()) {
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

        // 如果用户ID不为空则使用传入的用户ID，否则使用测试用ID
        // 测试用默认用户ID
        order.setUserId(Objects.requireNonNullElse(userId, 7L));

        order.setTotalAmount(totalAmount);
        order.setStatus(0); // 初始状态为"未支付"

        // 插入主订单记录
        orderMapper.insert(order);
        
        // 批量插入订单明细
        orderItemMapper.batchInsert(orderItems);

        // 4. 发送订单超时消息到RabbitMQ延迟队列
        sendOrderTimeoutMessage(orderId);

        return orderId;
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
                    msg.getMessageProperties().setDelay(10 * 60 * 1000);
                    return msg;
                }
        );
    }

    /**
     * 处理订单支付
     * 
     * @param orderId 订单ID
     */
    public void processPayment(long orderId) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 0) { // 状态0表示"未支付"
            throw new BusinessException("订单当前状态不可支付");
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
            throw new BusinessException("只有进行中的订单可标记完成");
        }
        // 更新订单状态为已完成（状态2）
        orderMapper.updateStatus(orderId, 2);
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
        if (order.getStatus() == 2) { // 状态2表示"已完成"，不能取消
            throw new BusinessException("已完成的订单不可取消");
        }
        
        // 更新订单状态为已取消（状态3）
        order.setStatus(3);
        // 设置取消原因（目前注释掉，可根据需要启用）
//        order.setCancelReason(reason);
        updateById(order);
    }
}




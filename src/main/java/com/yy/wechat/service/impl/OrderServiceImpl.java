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


@Service
@RequiredArgsConstructor
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final ProductService productService;
    private final RabbitTemplate rabbitTemplate;

    @Transactional
    public Long createOrder(CartRequest cartRequest, Long userId) {
        // 1. 生成订单ID（使用雪花算法）
        long orderId = IdUtil.getSnowflakeNextId();

        // 2. 构建订单项并计算总金额
        List<OrderItem> orderItems = new ArrayList<>();
        int totalAmount = 0;

        for (CartItemRequest item : cartRequest.items()) {
            if (item.quantity() <= 0) {
                throw new BusinessException("商品数量必须大于0");
            }

            // 查询商品实时价格
            Product product = productService.getById(item.productId());
            if (product == null) {
                throw new BusinessException("商品不存在: " + item.productId());
            }
            int unitPrice = product.getPriceCents();
            int itemTotal = unitPrice * item.quantity();

            // 构建订单项
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setProductId(item.productId());
            orderItem.setQuantity(item.quantity());
            orderItem.setUnitPrice(unitPrice);

            orderItems.add(orderItem);
            totalAmount += itemTotal;
        }

        // 3. 创建主订单
        Order order = new Order();
        order.setId(orderId);


        //测试用TODO
        if (userId != null) {
            order.setUserId(userId);
        }


        order.setUserId(7L);
        order.setTotalAmount(totalAmount);
        order.setStatus(0); // 0=未支付

        orderMapper.insert(order);
        orderItemMapper.batchInsert(orderItems); // 需要实现批量插入

        // 4. 发送超时检查消息到RabbitMQ
        sendOrderTimeoutMessage(orderId);

        return orderId;
    }

    private void sendOrderTimeoutMessage(long orderId) {
        OrderMessage message = new OrderMessage(orderId, System.currentTimeMillis());
        rabbitTemplate.convertAndSend(
                RabbitConfig.ORDER_EXCHANGE,
                RabbitConfig.ORDER_DELAY_ROUTING_KEY,
                message,
                msg -> {
                    // 设置10分钟延迟
                    msg.getMessageProperties().setDelay(10 * 60 * 1000);
                    return msg;
                }
        );
    }

    public void processPayment(long orderId) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 0) {// 必须为"未支付"
            throw new BusinessException("订单当前状态不可支付");
        }
        // 更新订单状态为已支付
        orderMapper.updateStatus(orderId, 1);
    }

    public void completeOrder(long orderId) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 1) { // 必须为"进行中"
            throw new BusinessException("只有进行中的订单可标记完成");
        }
        // 更新订单状态为已完成
        orderMapper.updateStatus(orderId, 2);
    }

    public void cancelOrder(long orderId, String reason) {
        Order order = getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (order.getStatus() != 0 && order.getStatus() != 1) { // 不能为“已完成”
            throw new BusinessException("订单当前状态不可取消");
        }
        // 更新订单状态为已取消
        order.setStatus(3);
//        order.setCancelReason(reason);
        updateById(order);
    }
}




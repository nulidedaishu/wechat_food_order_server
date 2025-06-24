package com.yy.wechat.listener;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.yy.wechat.config.RabbitConfig;
import com.yy.wechat.model.message.OrderMessage;
import com.yy.wechat.model.entity.Order;
import com.yy.wechat.service.OrderService;
import com.yy.wechat.websocket.WebSocketSessionManager;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.HashMap;
import java.util.Map;


/**
 * 订单超时消费者类
 * 用于监听延迟队列消息，处理未支付订单的自动取消逻辑
 */
@Component
@RequiredArgsConstructor
public class OrderTimeoutConsumer {
    /**
     * 注入订单服务接口实例
     * 用于调用订单相关业务方法
     */
    private final OrderService orderService;
    private final ObjectMapper objectMapper;

    /**
     * 监听订单延迟队列
     * 当订单到达设置的延迟时间后触发此方法
     *
     * @param message 消息体包含订单ID和创建时间戳
     */
    @RabbitListener(queues = RabbitConfig.ORDER_DELAY_QUEUE)
    public void handleOrderTimeout(OrderMessage message) throws Exception {
        // 如果接收到的消息为空，则直接返回
        if (message == null) {
            return;
        }

        // 获取订单ID并查询订单信息
        Long orderId = message.getOrderId();
        Order order = orderService.getById(orderId);

        // 只有当订单存在且处于"未支付"状态（0）时才进行后续操作
        if (order != null && order.getStatus() == 0) {
            // 调用订单服务方法，取消订单
            // 设置取消原因为"超时未支付"
            orderService.cancelOrder(message.getOrderId(), "超时未支付");

            // 构建要发送给前端的通知内容
            Map<String, Object> payload = new HashMap<>();
            payload.put("type", "ORDER_TIMEOUT");         // 消息类型：订单超时
            payload.put("orderId", orderId);              // 订单ID
            payload.put("reason", "超时未支付，订单已取消"); // 取消原因

            // 将payload转换为JSON字符串
            String text = objectMapper.writeValueAsString(payload);

            // 获取用户ID并查找对应的WebSocket连接
            String userId = order.getUserId().toString();
            WebSocketSession session = WebSocketSessionManager.get(userId);

            // 如果找到有效的WebSocket连接，则发送消息
            if (session != null && session.isOpen()) {
                session.sendMessage(new TextMessage(text));
            }
        }
    }
}


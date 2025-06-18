package com.yy.wechat.listener;

import com.yy.wechat.config.RabbitConfig;
import com.yy.wechat.model.message.OrderMessage;
import com.yy.wechat.model.entity.Order;
import com.yy.wechat.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;


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

    /**
     * 监听订单延迟队列
     * 当订单到达设置的延迟时间后触发此方法
     *
     * @param message 消息体包含订单ID和创建时间戳
     */
    @RabbitListener(queues = RabbitConfig.ORDER_DELAY_QUEUE)
    public void handleOrderTimeout(OrderMessage message) {
        if (message == null) {
            return;
        }
        // 查询订单当前状态
        Order order = orderService.getById(message.getOrderId());

        // 如果订单存在且仍处于未支付状态（0=未支付）
        if (order != null && order.getStatus() == 0) {
            // 调用订单服务的取消订单方法
            // 原因设置为"超时未支付"
            orderService.cancelOrder(message.getOrderId(), "超时未支付");
        }
    }
}



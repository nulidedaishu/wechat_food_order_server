package com.yy.wechat.listener;

import com.yy.wechat.config.RabbitConfig;
import com.yy.wechat.model.message.OrderMessage;
import com.yy.wechat.model.entity.Order;
import com.yy.wechat.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;


@Component
@RequiredArgsConstructor
public class OrderTimeoutConsumer {
    private final OrderService orderService;

    @RabbitListener(queues = RabbitConfig.ORDER_DELAY_QUEUE)
    public void handleOrderTimeout(OrderMessage message) {
        // 查询订单当前状态
        Order order = orderService.getById(message.getOrderId());

        if (order != null && order.getStatus() == 0) { // 0=未支付
            orderService.cancelOrder(message.getOrderId(), "超时未支付");
        }
    }
}



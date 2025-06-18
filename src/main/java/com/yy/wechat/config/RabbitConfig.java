package com.yy.wechat.config;

import org.springframework.amqp.core.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

/**
 * RabbitMQ配置类，用于声明延迟消息相关的交换机、队列和绑定关系。
 * 需要RabbitMQ服务器安装rabbitmq_delayed_message_exchange插件以支持延迟消息功能。
 */
@Configuration
public class RabbitConfig {

    /**
     * 交换机名称：用于订单相关的延迟消息交换
     */
    public static final String ORDER_EXCHANGE = "order.exchange";

    /**
     * 延迟队列名称：存储需要延迟处理的订单消息
     */
    public static final String ORDER_DELAY_QUEUE = "order.delay.queue";

    /**
     * 路由键名称：用于绑定订单创建与延迟队列的路由规则
     */
    public static final String ORDER_DELAY_ROUTING_KEY = "order.create.delay";


    /**
     * 声明一个自定义交换机（CustomExchange），作为延迟消息交换机
     *
     * @return CustomExchange 实例
     */
    @Bean
    public CustomExchange orderDelayExchange() {
        // 设置交换机参数，指定延迟消息类型为"direct"
        Map<String, Object> args = new HashMap<>();
        args.put("x-delayed-type", "direct");

        return new CustomExchange(
                ORDER_EXCHANGE,          // 交换机名称
                "x-delayed-message",     // 交换机类型，使用延迟消息插件
                true,                    // 是否持久化
                false,                   // 不自动删除
                args                     // 参数配置
        );
    }

    /**
     * 声明一个延迟消息队列
     *
     * @return Queue 实例
     */
    @Bean
    public Queue orderDelayQueue() {
        return new Queue(ORDER_DELAY_QUEUE, true); // 持久化队列
    }

    /**
     * 将延迟消息队列绑定到延迟消息交换机
     *
     * @return Binding 实例
     */
    @Bean
    public Binding orderDelayBinding() {
        return BindingBuilder.bind(orderDelayQueue())      // 绑定队列
                .to(orderDelayExchange())                  // 到达交换机
                .with(ORDER_DELAY_ROUTING_KEY)             // 使用指定路由键
                .noargs();                                 // 无额外参数
    }
}

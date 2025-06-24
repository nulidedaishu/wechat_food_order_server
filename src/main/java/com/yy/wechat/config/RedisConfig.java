package com.yy.wechat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * Redis配置类，用于定义和初始化与Redis相关的Bean对象。
 */
@Configuration
public class RedisConfig {

    /**
     * 定义一个RedisTemplate Bean，用于操作Redis数据库。
     *
     * @param connectionFactory Redis连接工厂，负责创建到Redis服务器的连接。
     * @return 配置好的RedisTemplate实例。
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        // 创建RedisTemplate实例
        RedisTemplate<String, Object> template = new RedisTemplate<>();

        // 设置Redis连接工厂
        template.setConnectionFactory(connectionFactory);

        // 设置键（Key）的序列化方式为字符串形式
        template.setKeySerializer(new StringRedisSerializer());

        // 设置值（Value）的序列化方式为字符串形式
        template.setValueSerializer(new StringRedisSerializer());

        // 返回配置完成的RedisTemplate实例
        return template;
    }
}
package com.yy.wechat.config;

import com.yy.wechat.websocket.OrderWebSocketHandler; // 处理 WebSocket 连接的处理器
import com.yy.wechat.websocket.TokenHandshakeInterceptor; // 自定义拦截器，用于在握手前校验 token
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.*; // Spring WebSocket 配置工具类

/**
 * WebSocketConfig 是一个配置类，用于注册 WebSocket 处理器和拦截器。
 * 它启用了 WebSocket 功能，并实现了 WebSocketConfigurer 接口来注册 WebSocket 相关的组件。
 */
@Configuration
@EnableWebSocket // 启用 Spring 的 WebSocket 支持
public class WebSocketConfig implements WebSocketConfigurer {

    private final TokenHandshakeInterceptor tokenInterceptor;

    /**
     * 构造函数注入 TokenHandshakeInterceptor 拦截器。
     * @param tokenInterceptor 用于在 WebSocket 握手之前进行 token 校验的拦截器
     */
    @Autowired
    public WebSocketConfig(TokenHandshakeInterceptor tokenInterceptor) {
        this.tokenInterceptor = tokenInterceptor;
    }

    /**
     * registerWebSocketHandlers 方法用于注册 WebSocket 处理器。
     * 在这里将 OrderWebSocketHandler 注册到 "/ws-order" 路径，并添加 token 拦截器。
     *
     * @param registry WebSocketHandlerRegistry 对象，用于注册 WebSocket 处理器
     */
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new OrderWebSocketHandler(), "/ws-order") // 注册 WebSocket 处理器，路径为 /ws-order
                .addInterceptors(tokenInterceptor) // 添加自定义拦截器，用于校验 token
                .setAllowedOriginPatterns("*"); // 允许所有来源跨域访问 WebSocket
    }
}

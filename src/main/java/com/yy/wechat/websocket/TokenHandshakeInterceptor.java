package com.yy.wechat.websocket;

import com.yy.wechat.exception.UnauthorizedException;
import org.jetbrains.annotations.NotNull;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * WebSocket 握手拦截器，用于在建立连接前校验 token。
 * 主要功能是从请求中提取 token，验证其有效性，并将用户信息存储到连接属性中。
 */
@Component
public class TokenHandshakeInterceptor implements HandshakeInterceptor {

    private final RedisTemplate<String, Object> redisTemplate;

    /**
     * 构造函数，注入 RedisTemplate 用于操作 Redis 数据库。
     *
     * @param redisTemplate Spring 提供的 Redis 操作模板类
     */
    public TokenHandshakeInterceptor(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    /**
     * 在 WebSocket 握手之前执行的方法。
     * 用于校验客户端传来的 token 是否合法，并将用户 ID 存入 attributes 中供后续使用。
     *
     * @param request    表示客户端发来的 HTTP 请求
     * @param response   表示即将发送给客户端的 HTTP 响应
     * @param wsHandler  表示即将使用的 WebSocket 处理器
     * @param attributes 表示握手时传递的属性，可用于在后续处理器中获取相关信息
     * @return 如果返回 true，则继续握手；如果返回 false，则中断握手过程
     */
    @Override
    public boolean beforeHandshake(@NotNull ServerHttpRequest request,
                                   @NotNull ServerHttpResponse response,
                                   @NotNull WebSocketHandler wsHandler,
                                   @NotNull Map<String, Object> attributes) {

        // 判断请求是否为 ServletServerHttpRequest 类型（HTTP 协议）
        if (!(request instanceof ServletServerHttpRequest)) {
            return false; // 非 HTTP 请求则终止握手
        }

        // 转换为 HttpServletRequest 以便获取更多 HTTP 请求信息
        HttpServletRequest servletReq = ((ServletServerHttpRequest) request).getServletRequest();

        // 从 URL 查询参数中获取 token，例如：wss://.../ws-order?token=xxx
        String token = servletReq.getParameter("token");

        // 如果 token 不存在，抛出未授权异常
        if (token == null) {
            throw new UnauthorizedException("缺少 token");
        }

        // 构造 Redis 的 key，格式为 "wx_token:token值"
        String redisKey = "wx_token:" + token;

        // 从 Redis 中根据 key 获取对应的 userId 字符串
        String userIdStr = (String) redisTemplate.opsForValue().get(redisKey);

        // 如果 userIdStr 为空，说明 token 已过期或无效，抛出未授权异常
        if (userIdStr == null) {
            throw new UnauthorizedException("Token 已过期");
        }

        // 将用户 ID 存入 attributes 中，后续可以通过 WebSocketSession 获取
        attributes.put("userId", userIdStr);

        // 打印日志，记录提取到的用户 ID
        System.out.println("[WS] >>> extracted userId=" + attributes.get("userId"));

        return true; // 返回 true 表示握手继续进行
    }

    /**
     * 在 WebSocket 握手完成后执行的方法。
     * 此处不做任何处理，保持空实现。
     *
     * @param req    握手完成后的 HTTP 请求对象
     * @param resp   握手完成后的 HTTP 响应对象
     * @param handler 当前使用的 WebSocket 处理器
     * @param ex     握手中可能发生的异常（如果有的话）
     */
    @Override
    public void afterHandshake(@NotNull ServerHttpRequest req,
                               @NotNull ServerHttpResponse resp,
                               @NotNull WebSocketHandler handler,
                               Exception ex) {
        // no-op，无需操作
    }
}

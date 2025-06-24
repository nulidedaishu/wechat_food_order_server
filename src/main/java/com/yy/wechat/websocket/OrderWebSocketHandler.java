package com.yy.wechat.websocket;

import org.jetbrains.annotations.NotNull;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Map;

/**
 * 订单相关的 WebSocket 处理器，用于管理客户端连接并维护用户与 WebSocketSession 的映射关系。
 */
public class OrderWebSocketHandler extends TextWebSocketHandler {

    /**
     * 在建立 WebSocket 连接之后执行。
     * 从 session 的 attributes 中获取 userId，并将该用户与 session 绑定到 WebSocketSessionManager 中。
     * 如果 userId 为 null，则关闭连接，并返回相应的状态码和原因。
     *
     * @param session 当前的 WebSocketSession
     * @throws Exception 如果处理过程中出现异常
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 握手完成后，尝试从 session 的 attributes 中获取 userId
        Map<String, Object> attrs = session.getAttributes();
        String userId = (String) attrs.get("userId");

        if (userId != null) {
            // 若 userId 存在，将用户与当前 session 关联起来
            WebSocketSessionManager.put(userId, session);
        } else {
            // 若 userId 不存在，拒绝连接，并说明原因
            session.close(CloseStatus.NOT_ACCEPTABLE.withReason("没有 userId"));
        }
    }

    /**
     * 在 WebSocket 连接关闭后执行。
     * 从 WebSocketSessionManager 中移除该用户的 session。
     *
     * @param session 当前的 WebSocketSession
     * @param status  连接关闭的状态
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, @NotNull CloseStatus status) {
        // 从 session 的 attributes 中再次获取 userId
        String userId = (String) session.getAttributes().get("userId");

        if (userId != null) {
            // 若 userId 存在，从管理器中移除对应的 session
            WebSocketSessionManager.remove(userId);
        }
    }

    /**
     * 处理来自客户端的文本消息。
     * 目前不需要处理任何客户端发送的消息，因此留空。
     *
     * @param session 当前的 WebSocketSession
     * @param message 客户端发送的文本消息
     */
    @Override
    protected void handleTextMessage(@NotNull WebSocketSession session, @NotNull TextMessage message) {
        // 可以不处理任何客户端发来的文本消息
    }
}

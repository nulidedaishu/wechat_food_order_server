package com.yy.wechat.websocket;

import org.springframework.web.socket.WebSocketSession;

import java.util.concurrent.ConcurrentHashMap;

/**
 * WebSocketSession 管理器
 * 用于管理用户的 WebSocket 会话，实现基于用户 ID 的消息推送能力。
 * 通过 ConcurrentHashMap 线程安全地存储和检索 WebSocketSession 对象。
 */
public class WebSocketSessionManager {
    /**
     * 存储用户与 WebSocketSession 的映射关系
     * key: 用户唯一标识 (userId)
     * value: 对应的 WebSocketSession 实例
     */
    private static final ConcurrentHashMap<String, WebSocketSession> SESSIONS = new ConcurrentHashMap<>();

    /**
     * 将用户 ID 与 WebSocketSession 进行绑定
     *
     * @param userId  用户唯一标识
     * @param session 要绑定的 WebSocketSession
     */
    public static void put(String userId, WebSocketSession session) {
        SESSIONS.put(userId, session);
    }

    /**
     * 获取指定用户 ID 绑定的 WebSocketSession
     *
     * @param userId 用户唯一标识
     * @return 对应的 WebSocketSession，如果不存在则返回 null
     */
    public static WebSocketSession get(String userId) {
        return SESSIONS.get(userId);
    }

    /**
     * 移除指定用户 ID 与其绑定的 WebSocketSession
     *
     * @param userId 用户唯一标识
     */
    public static void remove(String userId) {
        SESSIONS.remove(userId);
    }
}

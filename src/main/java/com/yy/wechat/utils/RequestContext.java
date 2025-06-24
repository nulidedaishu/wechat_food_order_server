package com.yy.wechat.utils;

public class RequestContext {
    private static final ThreadLocal<String> CURRENT_TOKEN = new ThreadLocal<>();
    private static final ThreadLocal<Long> CURRENT_USER_ID = new ThreadLocal<>();

    public static void setCurrentToken(String token) {
        CURRENT_TOKEN.set(token);
    }

    public static String getCurrentToken() {
        return CURRENT_TOKEN.get();
    }

    public static void setCurrentUserId(Long userId) {
        CURRENT_USER_ID.set(userId);
    }

    public static Long getCurrentUserId() {
        return CURRENT_USER_ID.get();
    }

    public static void clear() {
        CURRENT_TOKEN.remove();
        CURRENT_USER_ID.remove();
    }
}

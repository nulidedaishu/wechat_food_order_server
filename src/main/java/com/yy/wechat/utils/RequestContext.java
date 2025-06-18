package com.yy.wechat.utils;

public class RequestContext {
    private static final ThreadLocal<String> CURRENT_OPENID = new ThreadLocal<>();
    private static final ThreadLocal<Long> CURRENT_USER_ID = new ThreadLocal<>();

    public static void setCurrentOpenid(String openid) {
        CURRENT_OPENID.set(openid);
    }

    public static String getCurrentOpenid() {
        return CURRENT_OPENID.get();
    }

    public static void setCurrentUserId(Long userId) {
        CURRENT_USER_ID.set(userId);
    }

    public static Long getCurrentUserId() {
        return CURRENT_USER_ID.get();
    }

    public static void clear() {
        CURRENT_OPENID.remove();
        CURRENT_USER_ID.remove();
    }
}

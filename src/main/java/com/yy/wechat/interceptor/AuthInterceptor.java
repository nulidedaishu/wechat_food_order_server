package com.yy.wechat.interceptor;

import com.yy.wechat.exception.UnauthorizedException;
import com.yy.wechat.utils.RequestContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.concurrent.TimeUnit;

@Component
@RequiredArgsConstructor
public class AuthInterceptor implements HandlerInterceptor {
    @Value("${wx.token-expire-days}")
    private int tokenExpireDays;
    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             @NotNull HttpServletResponse response,
                             @NotNull Object handler) {
        // 从Header获取Token
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new UnauthorizedException("无效的授权凭证");
        }

        String token = authHeader.substring(7);
        String redisKey = "wx_token:" + token;
        String userId = (String) redisTemplate.opsForValue().get(redisKey);

        if (userId == null) {
            throw new UnauthorizedException("登录状态已过期");
        }
        Long userIdStr = Long.parseLong(userId);
        // 更新Redis中Token的过期时间
        redisTemplate.expire(redisKey, tokenExpireDays, TimeUnit.DAYS);
        // 存储到请求上下文
        RequestContext.setCurrentUserId(userIdStr);
        return true;
    }

    @Override
    public void afterCompletion(@NotNull HttpServletRequest request,
                                @NotNull HttpServletResponse response,
                                @NotNull Object handler,
                                Exception ex) {
        // 清理线程本地变量
        RequestContext.clear();
    }
}

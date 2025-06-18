package com.yy.wechat.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yy.wechat.exception.BusinessException;
import com.yy.wechat.model.entity.User;
import com.yy.wechat.model.DTO.request.WxSessionRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class WxAuthService {
    private final RestTemplate restTemplate;
    private final UserService userService;
    private final RedisTemplate<String, String> redisTemplate;

    @Value("${wx.appid}")
    private String appid;
    @Value("${wx.secret}")
    private String secret;
    @Value("${wx.token-expire-days}")
    private int tokenExpireDays;

    @Transactional
    public String login(String code) {
        // 1. 换取 openid & session_key
        WxSessionRequest session = exchangeCodeForSession(code);
        if (session.errcode() != null && session.errcode() != 0) {
            throw new BusinessException("微信登录失败: " + session.errmsg());
        }
        String openid = session.openid();
        // 2. 在 user 表建或更新用户
        User user = findOrCreateUser(openid);

        // 3. 生成 Token 并存到 Redis
        String token = UUID.randomUUID().toString().replace("-", "");
        writeTokenToRedis(token, user.getId());

        // 4. 返回 token
        return token;
    }

    protected User findOrCreateUser(String openid) {
        new User();
        User user = userService.getOne(
                new QueryWrapper<User>().lambda()
                        .select(User::getId, User::getOpenid)
                        .eq(User::getOpenid, openid)
        );
        if (user == null) {
            user = new User();
            user.setOpenid(openid);
            userService.save(user);
        }
        return user;
    }

    private void writeTokenToRedis(String token, Long userId) {
        String redisKey = "wx_token:" + token;
        redisTemplate.opsForValue().set(redisKey, String.valueOf(userId), tokenExpireDays, TimeUnit.DAYS);
    }

    private WxSessionRequest exchangeCodeForSession(String code) {
        String url = String.format(
                "https://api.weixin.qq.com/sns/jscode2session" +
                        "?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code",
                appid, secret, code);
        return restTemplate.getForObject(url, WxSessionRequest.class);
    }


    public void logout(String tokenHeader) {
        if (tokenHeader != null && tokenHeader.startsWith("Bearer ")) {
            String token = tokenHeader.substring(7);
            redisTemplate.delete("wx_token:" + token);
        }
    }
}
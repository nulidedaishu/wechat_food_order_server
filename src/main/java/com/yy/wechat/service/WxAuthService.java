package com.yy.wechat.service;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
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

/**
 * 微信认证服务类，处理与微信登录、Token管理相关的业务逻辑。
 */
@Service
@RequiredArgsConstructor
public class WxAuthService {
    /**
     * RestTemplate 用于发起 HTTP 请求，调用微信接口获取 session 信息。
     */
    private final RestTemplate restTemplate;

    /**
     * UserService 用于操作用户数据，包括创建和查询用户。
     */
    private final UserService userService;

    /**
     * RedisTemplate 用于将生成的 Token 存入 Redis，并设置过期时间。
     */
    private final RedisTemplate<String, String> redisTemplate;

    /**
     * 从配置文件中注入微信小程序的 AppID。
     */
    @Value("${wx.appid}")
    private String appid;

    /**
     * 从配置文件中注入微信小程序的 Secret。
     */
    @Value("${WX_SECRET}")
    private String secret;

    /**
     * 从配置文件中注入 Token 的过期天数。
     */
    @Value("${wx.token-expire-days}")
    private int tokenExpireDays;

    /**
     * 用户登录方法，根据微信授权码进行登录流程。
     *
     * @param code 微信授权码
     * @return 返回生成的 Token
     */
    @Transactional
    public String login(String code) {
        // 1. 使用微信授权码换取 openid 和 session_key
        WxSessionRequest session = exchangeCodeForSession(code);

        // 检查微信返回的错误码
        if (session.errcode() != null && session.errcode() != 0) {
            throw new BusinessException("微信登录失败: " + session.errmsg());
        }

        // 获取用户的 openid
        String openid = session.openid();

        // 2. 查询或创建用户记录
        User user = findOrCreateUser(openid);

        // 3. 生成唯一的 Token 并将其写入 Redis 缓存
        String token = UUID.randomUUID().toString().replace("-", "");
        writeTokenToRedis(token, user.getId());

        // 4. 返回生成的 Token 给前端
        return token;
    }

    /**
     * 根据 openid 查询用户是否存在，若不存在则创建新用户。
     *
     * @param openid 微信用户的唯一标识
     * @return 返回用户对象
     */
    protected User findOrCreateUser(String openid) {
        // 查询用户是否已存在
        User user = userService.getOne(Wrappers.<User>lambdaQuery()
                .select(User::getId, User::getOpenid)
                .eq(User::getOpenid, openid));

        // 如果用户不存在，则创建新用户并保存到数据库
        if (user == null) {
            user = new User();
            user.setOpenid(openid);
            userService.save(user);
        }

        // 返回用户对象
        return user;
    }

    /**
     * 将生成的 Token 写入 Redis 缓存，并关联用户 ID。
     *
     * @param token  生成的 Token
     * @param userId 用户 ID
     */
    private void writeTokenToRedis(String token, Long userId) {
        // Redis 中的键格式为 wx_token:<token>
        String redisKey = "wx_token:" + token;

        // 将 Token 和对应的用户 ID 存入 Redis，并设置过期时间
        redisTemplate.opsForValue().set(redisKey, String.valueOf(userId), tokenExpireDays, TimeUnit.DAYS);
    }

    /**
     * 调用微信接口，使用授权码换取 openid 和 session_key。
     *
     * @param code 微信授权码
     * @return 返回封装好的 WxSessionRequest 对象
     */
    private WxSessionRequest exchangeCodeForSession(String code) {
        // 构建请求 URL
        String url = String.format(
                "https://api.weixin.qq.com/sns/jscode2session" +
                        "?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code",
                appid, secret, code);

        // 发起 GET 请求并返回结果
        return restTemplate.getForObject(url, WxSessionRequest.class);
    }

    /**
     * 用户注销方法，清除 Redis 中的 Token。
     *
     * @param tokenHeader 带有 Bearer 前缀的 Token
     */
    public void logout(String tokenHeader) {
        // 判断 Token 是否有效
        if (tokenHeader != null && tokenHeader.startsWith("Bearer ")) {
            // 提取 Token
            String token = tokenHeader.substring(7);

            // 删除 Redis 中对应的 Key
            redisTemplate.delete("wx_token:" + token);
        }
    }
}
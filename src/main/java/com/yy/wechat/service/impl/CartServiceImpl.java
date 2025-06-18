package com.yy.wechat.service.impl;

import com.yy.wechat.model.VO.CartItemVO;
import com.yy.wechat.model.VO.CartVO;
import com.yy.wechat.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {
    private static final String KEY_PREFIX = "cart:";
    @Value("${wx.cart-expire-days}")
    private int cartExpireDays;
    private final StringRedisTemplate redis;

    @Override
    public CartVO addOrUpdateItem(Long userId, Long productId, Integer qty) {
        String key = KEY_PREFIX + userId;
        HashOperations<String, String, String> ops = redis.opsForHash();

        String pidStr = productId.toString();

        // 原子增量：正数加，负数减
        long updated = ops.increment(key, pidStr, qty);

        if (updated <= 0) {
            // 数量为 0 或以下，删除该商品
            ops.delete(key, pidStr);
        }
        redis.expire(key, cartExpireDays, TimeUnit.DAYS);
        return buildCartResponse(key, userId, ops);
    }

    @Override
    public CartVO getCart(Long userId) {
        String key = KEY_PREFIX + userId;
        HashOperations<String, String, String> hashOps = redis.opsForHash();
        redis.expire(key, cartExpireDays, TimeUnit.DAYS);
        return buildCartResponse(key, userId, hashOps);
    }

    private CartVO buildCartResponse(String key, Long userId, HashOperations<String, String, String> ops) {
        Map<String, String> entries = ops.entries(key);
        List<CartItemVO> items = entries.entrySet().stream()
                .map(e -> new CartItemVO(Long.valueOf(e.getKey()), Integer.valueOf(e.getValue())))
                .collect(Collectors.toList());
        return new CartVO(userId, items);
    }

    @Override
    public CartVO deleteCart(Long userId) {
        String key = KEY_PREFIX + userId;
        redis.delete(key);
        return new CartVO(userId, List.of());
    }
}

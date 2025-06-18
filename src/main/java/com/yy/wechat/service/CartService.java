package com.yy.wechat.service;


import com.yy.wechat.model.VO.CartVO;


public interface CartService {
    /**
     * 获取用户的购物车。
     */
    CartVO getCart(Long userId);

    /**
     * 对该商品增量更新数量。
     * 返回最新的购物车列表。
     */
    CartVO addOrUpdateItem(Long userId, Long productId, Integer qty);

    /**
     * 清空购物车。
     */
    CartVO deleteCart(Long userId);
}

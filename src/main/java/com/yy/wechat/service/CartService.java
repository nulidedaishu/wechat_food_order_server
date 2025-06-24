package com.yy.wechat.service;


import com.yy.wechat.model.VO.CartVO;


public interface CartService {
    /**
     * 获取桌子的购物车。
     */
    CartVO getCart(Integer tableId);

    /**
     * 对该商品增量更新数量。
     * 返回最新的购物车列表。
     */
    CartVO addOrUpdateItem(Long productId, Integer qty, Integer tableId);

    /**
     * 清空购物车。
     */
    CartVO deleteCart(Integer tableId);
}

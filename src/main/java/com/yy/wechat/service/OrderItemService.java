package com.yy.wechat.service;

import com.yy.wechat.model.entity.OrderItem;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * 订单详情服务接口：提供对订单明细表的操作方法
 */
public interface OrderItemService extends IService<OrderItem> {

    /**
     * 根据订单ID回滚库存和销量（当订单被取消或删除时调用）
     *
     * @param orderId 订单ID
     */
    void revertStockAndSales(long orderId);

    /**
     * 根据订单ID集合查询对应的订单明细，并按订单ID分组返回
     *
     * @param orderIds 订单ID列表
     * @return 返回一个Map，键为订单ID，值为该订单对应的所有订单明细列表
     */
    Map<Long, List<OrderItem>> listByOrderIds(List<Long> orderIds);
}

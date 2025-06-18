package com.yy.wechat.service;

import com.yy.wechat.model.DTO.request.CartRequest;
import com.yy.wechat.model.entity.Order;
import com.baomidou.mybatisplus.extension.service.IService;


public interface OrderService extends IService<Order> {
    /**
     * 创建订单
     *
     * @param cartRequest
     * @param userId
     * @return
     */
    Long createOrder(CartRequest cartRequest, Long userId);

    /**
     * 处理支付
     *
     * @param orderId
     */
    void processPayment(long orderId);

    /**
     * 完成订单
     *
     * @param orderId
     */
    void completeOrder(long orderId);

    /**
     * 取消订单
     *
     * @param orderId
     */
    void cancelOrder(long orderId, String reason);

}

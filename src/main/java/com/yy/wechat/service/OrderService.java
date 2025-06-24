package com.yy.wechat.service;

import com.yy.wechat.model.DTO.request.OrderRequest;
import com.yy.wechat.model.VO.OrderDetailVO;
import com.yy.wechat.model.entity.Order;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.constraints.NotNull;

import java.util.List;

/**
 * 订单服务接口，定义了与订单相关的业务操作方法。
 */
public interface OrderService extends IService<Order> {
    /**
     * 创建一个新的订单。
     *
     * @param orderRequest 包含创建订单所需数据的请求对象
     * @param userId       下单用户的唯一标识符
     * @return 返回创建成功的订单编号（字符串形式）
     */
    String createOrder(OrderRequest orderRequest, Long userId);

    /**
     * 处理订单支付逻辑。
     *
     * @param orderId 需要支付的订单的唯一标识符
     */
    void processPayment(long orderId);

    /**
     * 完成指定的订单，通常意味着订单流程正常结束。
     *
     * @param orderId 要完成的订单的唯一标识符
     */
    void completeOrder(long orderId);

    /**
     * 对指定的订单进行评价。
     *
     * @param orderId 要评价的订单的唯一标识符
     */
    void commentOrder(long orderId);

    /**
     * 取消指定的订单，并记录取消原因。
     *
     * @param orderId 订单的唯一标识符
     * @param reason  取消订单的原因描述
     */
    void cancelOrder(long orderId, String reason);

    /**
     * 根据订单状态和用户ID查询订单列表。
     *
     * @param status        要查询的订单状态，不能为空
     * @param currentUserId 当前用户的唯一标识符
     * @return 返回符合条件的订单详情视图对象列表
     */
    List<OrderDetailVO> listOrders(@NotNull Integer status, Long currentUserId);
}

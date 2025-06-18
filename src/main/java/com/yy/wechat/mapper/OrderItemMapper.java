package com.yy.wechat.mapper;

import com.yy.wechat.model.entity.OrderItem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;

import java.util.List;

public interface OrderItemMapper extends BaseMapper<OrderItem> {

    @Insert("<script>" +
            "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES " +
            "<foreach collection='list' item='item' separator=','>" +
            "(#{item.orderId}, #{item.productId}, #{item.quantity}, #{item.unitPrice})" +
            "</foreach>" +
            "</script>")
    int batchInsert(List<OrderItem> orderItems);
}





package com.yy.wechat.model.VO;

import lombok.Builder;

import java.util.List;

@Builder
public record OrderDetailVO(String orderId,
                            Integer tableId,
                            Integer totalAmount,
                            Integer couponValue,
                            List<OrderItemDetailVO> items) {
}

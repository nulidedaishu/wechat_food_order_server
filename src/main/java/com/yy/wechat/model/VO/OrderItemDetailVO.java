package com.yy.wechat.model.VO;

import lombok.Builder;

@Builder
public record OrderItemDetailVO(Long id, String name, Integer priceCents, Integer quantity, Integer totalPrice, String imageUrl) {
}

package com.yy.wechat.model.VO;

public record CartItemDetailVO(Long id,String name, Integer priceCents, Integer quantity, Integer totalPriceCents,String imageUrl) {
}

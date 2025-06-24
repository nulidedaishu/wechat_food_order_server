package com.yy.wechat.model.VO;

public record ProductItemVO(Long id, String sku, String name,String description,Integer stock, Integer priceCents, String imageUrl, Integer soldCount) {
}

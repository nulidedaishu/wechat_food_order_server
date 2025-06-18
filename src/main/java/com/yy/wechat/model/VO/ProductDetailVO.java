package com.yy.wechat.model.VO;


public record ProductDetailVO(Long id, String sku, String name, String description, Integer priceCents, String imageUrl,
                              Integer stock, Integer soldCount) {
}

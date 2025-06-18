package com.yy.wechat.model.DTO.request;


import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record CartItemRequest(
        @Min(value = 1, message = "商品ID必须为正数")
        @NotNull(message = "商品ID不能为空")
        Long productId,
        @NotNull(message = "商品数量不能为空")
        Integer quantity) {
}
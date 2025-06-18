package com.yy.wechat.model.DTO.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;

import java.util.List;

public record CartRequest(
        @NotEmpty(message = "购物车不能为空")
        @Valid
        List<CartItemRequest> items) {
}

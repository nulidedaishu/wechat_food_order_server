package com.yy.wechat.model.DTO.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record MyCouponRequest(
        @Min(value = 1, message = "优惠券ID不能小于1")
        @NotNull(message = "优惠券ID不能为空")
        Integer couponId) {
}

package com.yy.wechat.model.DTO.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record BalanceRequest(
        @NotNull
        @Min(value = 1, message = "金额不能小于1")
        Integer amount) {
}

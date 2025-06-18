package com.yy.wechat.model.DTO.request;

import jakarta.validation.constraints.NotBlank;

public record LoginRequest(
        @NotBlank(message = "code不能为空")
        String code) {
}

package com.yy.wechat.model.DTO.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record CommentRequest(
        @NotBlank(message = "订单ID不能为空")
        @Min(value = 1, message = "订单ID不能小于1")
        String orderId,
        @NotBlank(message = "评论内容不能为空")
        String comment,
        @NotNull
        @Min(value = 1, message = "评分不能小于1")
        @Max(value = 5, message = "评分不能大于5")
        Integer score
) {
}

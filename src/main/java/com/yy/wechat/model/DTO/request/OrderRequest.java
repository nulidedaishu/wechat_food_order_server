package com.yy.wechat.model.DTO.request;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;

public record OrderRequest (
        @NotNull(message = "桌号不能为空")
        Integer tableId,
        @NotNull(message = "支付方式不能为空")
        Integer payType,
        @NotNull(message = "用餐人数不能为空")
        Integer eatNumber,
        @Nullable
        String remark,
        @Nullable
        Integer myCouponId){
}

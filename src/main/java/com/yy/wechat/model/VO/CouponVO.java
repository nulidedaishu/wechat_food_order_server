package com.yy.wechat.model.VO;

import lombok.Builder;

import java.time.LocalDate;

@Builder
public record CouponVO (Integer id, String name, Integer value, Integer condition, LocalDate startTime, LocalDate endTime, String status){
}

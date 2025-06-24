package com.yy.wechat.model.VO;

import java.time.LocalDate;

public record MyCouponVO(Integer id, String name, Integer value, Integer condition,Integer status, LocalDate startTime, LocalDate endTime) {
}

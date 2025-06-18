package com.yy.wechat.controller;

import cn.hutool.core.bean.BeanUtil;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.VO.CouponVO;
import com.yy.wechat.model.entity.Coupon;
import com.yy.wechat.service.CouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/coupon")
@RequiredArgsConstructor
public class CouponController {

    private final CouponService couponService;

    @GetMapping("/list")
    public ApiResponse<List<CouponVO>> listCoupons() {
        List<Coupon> coupons = couponService.list();
        List<CouponVO> CouponVOs = coupons.stream().map(coupon -> CouponVO.builder()
                .id(coupon.getId())
                .name(coupon.getCname())
                .value(coupon.getCvalue())
                .condition(coupon.getCcondition())
                .startTime(coupon.getStarttime())
                .endTime(coupon.getEndtime())
                .status(coupon.getStatus())
                .build()).toList();
        return ApiResponse.success(CouponVOs);
    }
}

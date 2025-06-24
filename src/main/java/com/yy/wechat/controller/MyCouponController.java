package com.yy.wechat.controller;

import com.yy.wechat.model.DTO.request.MyCouponRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.VO.MyCouponVO;
import com.yy.wechat.model.entity.MyCoupon;
import com.yy.wechat.service.MyCouponService;
import com.yy.wechat.utils.RequestContext;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/myCoupons")
@RequiredArgsConstructor
public class MyCouponController {
    private final MyCouponService myCouponService;

    @PostMapping
    public ApiResponse<Void> addCoupon(@Valid @RequestBody MyCouponRequest myCouponRequest) {
        MyCoupon myCoupon = new MyCoupon();
        myCoupon.setUserId(RequestContext.getCurrentUserId());
        myCoupon.setCouponId(myCouponRequest.couponId());
        myCouponService.save(myCoupon);
        return ApiResponse.success();
    }

    @GetMapping("/listUse")
    public ApiResponse<List<MyCouponVO>> getUseCoupons() {
        return ApiResponse.success(myCouponService.listMyCouponUse());
    }

    @GetMapping("/listAll")
    public ApiResponse<List<MyCouponVO>> getAllCoupons() {
        return ApiResponse.success(myCouponService.listMyCouponAll());
    }
}
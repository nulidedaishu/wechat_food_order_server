package com.yy.wechat.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.model.entity.Coupon;
import com.yy.wechat.service.CouponService;
import com.yy.wechat.mapper.CouponMapper;
import org.springframework.stereotype.Service;

@Service
public class CouponServiceImpl extends ServiceImpl<CouponMapper, Coupon>
    implements CouponService{

}





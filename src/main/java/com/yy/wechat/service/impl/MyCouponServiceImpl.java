package com.yy.wechat.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.exception.BusinessException;
import com.yy.wechat.model.VO.MyCouponVO;
import com.yy.wechat.model.entity.Coupon;
import com.yy.wechat.model.entity.MyCoupon;
import com.yy.wechat.service.CouponService;
import com.yy.wechat.service.MyCouponService;
import com.yy.wechat.mapper.MyCouponMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class MyCouponServiceImpl extends ServiceImpl<MyCouponMapper, MyCoupon> implements MyCouponService {
    private final MyCouponMapper myCouponMapper;
    private final CouponService couponService;

    @Override
    public List<MyCouponVO> listMyCouponUse() {
        List<MyCoupon> myCoupons = myCouponMapper.selectList(
                new LambdaQueryWrapper<MyCoupon>()
                        .eq(MyCoupon::getStatus, 0)
        );
        return listMyCoupon(myCoupons);
    }


    @Override
    public List<MyCouponVO> listMyCouponAll() {
        List<MyCoupon> myCoupons = myCouponMapper.selectList(Wrappers.<MyCoupon>lambdaQuery().orderByAsc(MyCoupon::getStatus));
        return listMyCoupon(myCoupons);
    }

    private List<MyCouponVO> listMyCoupon(List<MyCoupon> myCoupons) {
        return myCoupons.stream()
                .map(myCoupon -> {
                    Coupon coupon = couponService.getById(myCoupon.getCouponId());
                    return new MyCouponVO(
                            myCoupon.getId(),
                            coupon.getCname(),
                            coupon.getCvalue(),
                            coupon.getCcondition(),
                            myCoupon.getStatus(),
                            coupon.getStarttime(),
                            coupon.getEndtime()
                    );
                })
                .collect(Collectors.toList());
    }

    @Override
    public Integer useCoupon(Integer myCouponId) {
        if (myCouponId == null) {
            throw new BusinessException("优惠券ID不能为空");
        }
        MyCoupon myCoupon = myCouponMapper.selectById(myCouponId);
        if (myCoupon == null) {
            throw new BusinessException("优惠券不存在");
        }
        if (myCoupon.getStatus() != 0) {
            throw new BusinessException("该优惠券已使用或过期");
        }
        myCoupon.setStatus(1);
        myCouponMapper.updateById(myCoupon);
        return myCoupon.getCouponId();
    }

    @Override
    public void revertCoupon(Integer myCouponId) {
        MyCoupon myCoupon = getById(myCouponId);
        if (myCoupon != null && myCoupon.getStatus() == 1) {
            myCoupon.setStatus(0);
            updateById(myCoupon);
        }
    }
}





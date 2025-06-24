package com.yy.wechat.service;

import com.yy.wechat.model.VO.MyCouponVO;
import com.yy.wechat.model.entity.MyCoupon;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 优惠券业务接口
 * 提供用户优惠券相关的业务功能，包括查询、使用和回滚操作
 */
public interface MyCouponService extends IService<MyCoupon> {

    /**
     * 查询可用的优惠券列表
     * @return 返回当前用户可用的优惠券视图对象列表
     */
    List<MyCouponVO> listMyCouponUse();

    /**
     * 查询所有优惠券列表（包含已使用和未使用的）
     * @return 返回当前用户所有的优惠券视图对象列表
     */
    List<MyCouponVO> listMyCouponAll();

    /**
     * 使用优惠券
     * @param myCouponId 用户优惠券ID
     * @return 返回受影响的记录数
     */
    Integer useCoupon(Integer myCouponId);

    /**
     * 回滚优惠券状态（将已使用的优惠券标记为未使用）
     * @param myCouponId 用户优惠券ID
     */
    void revertCoupon(Integer myCouponId);
}

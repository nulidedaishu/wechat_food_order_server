package com.yy.wechat.service;

import com.yy.wechat.model.VO.CartDetailVO;
import com.yy.wechat.model.VO.CartVO;
import com.yy.wechat.model.entity.Product;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yy.wechat.model.VO.CategoryWithProductsVO;

import java.util.List;
import java.util.Map;
import java.util.Set;


public interface ProductService extends IService<Product> {

    /**
     * 获取所有商品分类及分类下的商品
     */
    List<CategoryWithProductsVO> listProducts(String keyWord);

    /**
     * 获取购物车里商品的详情
     */
    CartDetailVO getCartDetails(CartVO cart);

    /**
     * 根据商品id获取商品信息
     */
    Map<Long, Product> getProductsMapByIds(Set<Long> productIds);
}

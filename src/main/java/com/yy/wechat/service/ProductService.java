package com.yy.wechat.service;

import com.yy.wechat.model.entity.Product;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yy.wechat.model.VO.CategoryWithProductsVO;

import java.util.List;


public interface ProductService extends IService<Product> {

    /**
     * 获取所有商品分类及分类下的商品
     */
    List<CategoryWithProductsVO> listProducts();
}

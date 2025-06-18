package com.yy.wechat.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.mapper.CategorieMapper;
import com.yy.wechat.model.entity.Categorie;
import com.yy.wechat.model.entity.Product;
import com.yy.wechat.model.VO.CategoryWithProductsVO;
import com.yy.wechat.model.VO.ProductItemVO;
import com.yy.wechat.service.ProductService;
import com.yy.wechat.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {

    private final ProductMapper productMapper;
    private final CategorieMapper categorieMapper;

    public List<CategoryWithProductsVO> listProducts() {
        List<Categorie> categories = categorieMapper.selectList(
                new QueryWrapper<Categorie>()
                        .orderByAsc("sort_order")
        );
        List<Product> products = productMapper.selectList(null);

        Map<Long, List<Product>> productMap = products.stream()
                .collect(Collectors.groupingBy(Product::getCategoryId));

        List<CategoryWithProductsVO> result = categories.stream()
                .map(categorie -> {
                    List<ProductItemVO> voList = Optional.ofNullable(productMap.get(categorie.getId()))
                            .orElse(Collections.emptyList())
                            .stream()
                            .map(this::toVO)
                            .collect(Collectors.toList());
                    return new CategoryWithProductsVO(categorie.getId(), categorie.getName(), voList);
                })
                .collect(Collectors.toList());

        List<ProductItemVO> newArrivals = Optional.ofNullable(productMapper.selectList(
                        new QueryWrapper<Product>()
                                .orderByDesc("created_at")
                                .last("limit 5")
                ))
                .orElse(Collections.emptyList())
                .stream()
                .map(this::toVO)
                .collect(Collectors.toList());
        CategoryWithProductsVO newVO = new CategoryWithProductsVO(0L, "新品", newArrivals);

        List<ProductItemVO> hotSales = Optional.ofNullable(productMapper.selectList(
                        new QueryWrapper<Product>()
                                .orderByDesc("sold_count")
                                .last("limit 5")
                ))
                .orElse(Collections.emptyList())
                .stream()
                .map(this::toVO)
                .collect(Collectors.toList());
        CategoryWithProductsVO hotDTO = new CategoryWithProductsVO(-1L, "热销", hotSales);

        result.add(0, hotDTO);
        result.add(0, newVO);

        return result;
    }

    private ProductItemVO toVO(Product product) {
        return new ProductItemVO(product.getId(), product.getSku(), product.getName(), product.getPriceCents(), product.getImageUrl(), product.getSoldCount());
    }
}





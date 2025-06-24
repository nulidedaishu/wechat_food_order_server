package com.yy.wechat.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.mapper.CategorieMapper;
import com.yy.wechat.model.VO.*;
import com.yy.wechat.model.entity.Categorie;
import com.yy.wechat.model.entity.Product;
import com.yy.wechat.service.ProductService;
import com.yy.wechat.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {

    private final ProductMapper productMapper;
    private final CategorieMapper categorieMapper;

    @Override
    public List<CategoryWithProductsVO> listProducts(String keyWord) {
        List<Categorie> categories;
        List<Product> products;

        // 1. 处理分类关键词查询
        if (keyWord != null && keyWord.startsWith("分类：")) {
            String categoryName = keyWord.substring(3);

            if ("热销".equals(categoryName)) {
                // 热销虚拟分类
                products = getProductsByCondition("sold_count", 10);
                return Collections.singletonList(
                        buildVirtualCategory("热销", -1L, products)
                );
            } else if ("新品".equals(categoryName)) {
                // 新品虚拟分类
                products = getProductsByCondition("created_at", 5);
                return Collections.singletonList(
                        buildVirtualCategory("新品", -2L, products)
                );
            } else {
                // 普通分类查询
                Categorie category = categorieMapper.selectOne(
                        new QueryWrapper<Categorie>().eq("name", categoryName)
                );
                if (category == null) {
                    throw new IllegalArgumentException("不存在该分类: " + categoryName);
                }
                categories = Collections.singletonList(category);
                products = productMapper.selectList(
                        new QueryWrapper<Product>().eq("category_id", category.getId())
                );
            }
        }
        // 2. 处理普通关键词搜索
        else {
            // 获取所有有效分类
            categories = categorieMapper.selectList(
                    new QueryWrapper<Categorie>().orderByAsc("sort_order")
            );
            // 关键词商品搜索
            products = productMapper.selectList(
                    new QueryWrapper<Product>()
                            .like(keyWord != null && !keyWord.isEmpty(), "name", keyWord)
            );
        }

        // 按分类ID分组商品
        Map<Long, List<Product>> productMap = products.stream()
                .collect(Collectors.groupingBy(Product::getCategoryId));

        // 构建分类结果，过滤掉没有商品的分类
        return categories.stream()
                .map(category -> {
                    List<ProductItemVO> voList = Optional.ofNullable(productMap.get(category.getId()))
                            .orElse(Collections.emptyList())
                            .stream()
                            .map(this::toVO)
                            .collect(Collectors.toList());
                    if (!voList.isEmpty()) {
                        return new CategoryWithProductsVO(
                                category.getId(),
                                category.getName(),
                                voList
                        );
                    }
                    return null;
                })
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    /**
     * 根据条件获取商品列表
     */
    private List<Product> getProductsByCondition(String orderByField, int limit) {
        QueryWrapper<Product> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc(orderByField); // 统一使用DESC排序
        queryWrapper.last("LIMIT " + limit);
        return productMapper.selectList(queryWrapper);
    }

    /**
     * 构建虚拟分类（热销/新品）
     */
    private CategoryWithProductsVO buildVirtualCategory(String name, Long id, List<Product> products) {
        List<ProductItemVO> voList = products.stream()
                .map(this::toVO)
                .collect(Collectors.toList());
        return new CategoryWithProductsVO(id, name, voList);
    }

    /**
     * 实体转VO对象
     */
    private ProductItemVO toVO(Product product) {
        return new ProductItemVO(
                product.getId(),
                product.getSku(),
                product.getName(),
                product.getDescription(),
                product.getStock(),
                product.getPriceCents(),
                product.getImageUrl(),
                product.getSoldCount()
        );
    }

    @Override
    public CartDetailVO getCartDetails(CartVO cart) {
        // 初始化总数量和总金额
        AtomicInteger totalQuantity = new AtomicInteger();
        AtomicInteger totalAmountCents = new AtomicInteger();
        // 存储所有商品的详细信息
        List<CartItemDetailVO> cartItemDetailList = new ArrayList<>();
        // 遍历购物车中的商品
        cart.items().forEach((itemVO) -> {
            // 获取商品信息
            Product product = productMapper.selectById(itemVO.productId());
            if (product == null) {
                throw new IllegalArgumentException("商品不存在: " + itemVO.productId());
            }
            if (product.getStock() < itemVO.quantity()) {
                throw new IllegalArgumentException("库存不足: " + product.getName());
            }
            // 计算总价（单品总价 = 商品价格 * 数量）
            int totalPriceCents = product.getPriceCents() * itemVO.quantity();

            totalQuantity.addAndGet(itemVO.quantity());
            totalAmountCents.addAndGet(totalPriceCents);

            // 将当前商品的详细信息添加到 cartItemDetailList
            cartItemDetailList.add(new CartItemDetailVO(
                    product.getId(),
                    product.getName(),
                    product.getPriceCents(),
                    itemVO.quantity(),
                    totalPriceCents,
                    product.getImageUrl()
            ));
        });
        // 构建 CartDetailVO，包含总数量、总金额和商品详细信息
        return new CartDetailVO(
                cart.tableId(),
                totalQuantity.get(),
                totalAmountCents.get(),
                cartItemDetailList
        );
    }

    public Map<Long, Product> getProductsMapByIds(Set<Long> productIds) {
        if (productIds == null || productIds.isEmpty()) {
            return Collections.emptyMap();
        }

        return productMapper.selectBatchIds(productIds).stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));
    }
}
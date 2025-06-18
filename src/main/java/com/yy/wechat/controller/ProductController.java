package com.yy.wechat.controller;

import com.yy.wechat.model.entity.Product;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.VO.CategoryWithProductsVO;
import com.yy.wechat.model.VO.ProductDetailVO;
import com.yy.wechat.service.ProductService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/list")
    public ApiResponse<List<CategoryWithProductsVO>> listProducts() {
        return ApiResponse.success(productService.listProducts());
    }

    @GetMapping("/{id}")
    public ApiResponse<ProductDetailVO> getProductById(@PathVariable @NotNull Long id) {
        Product product = productService.getById(id);
        if (product != null) {
            return ApiResponse.success(new ProductDetailVO(
                    product.getId(),
                    product.getSku(),
                    product.getName(),
                    product.getDescription(),
                    product.getPriceCents(),
                    product.getImageUrl(),
                    product.getStock(),
                    product.getSoldCount()
            ));
        }
        return ApiResponse.error(400, "商品不存在");
    }
}

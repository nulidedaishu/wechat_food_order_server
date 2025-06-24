package com.yy.wechat.controller;

import com.yy.wechat.model.DTO.request.CartItemRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.VO.CartDetailVO;
import com.yy.wechat.model.VO.CartVO;
import com.yy.wechat.service.CartService;
import com.yy.wechat.service.ProductService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;
    private final ProductService productService;

    @PostMapping
    public ApiResponse<CartVO> addOrUpdateItem(
            @Valid @RequestBody CartItemRequest req) {
        if (req.quantity() == 0) {
            throw new IllegalArgumentException("商品数量不能为0");
        }
        return ApiResponse.success(cartService.addOrUpdateItem(req.productId(), req.quantity(), req.tableId()));
    }

    @GetMapping
    public ApiResponse<CartVO> getCart(@NotNull Integer tableId) {
        return ApiResponse.success(cartService.getCart(tableId));
    }

    @GetMapping("/details")
    public ApiResponse<CartDetailVO> getCartDetails(@NotNull Integer tableId) {
        return ApiResponse.success(productService.getCartDetails(cartService.getCart(tableId)));
    }

    @DeleteMapping
    public ApiResponse<CartVO> deleteItem(@NotNull Integer tableId) {
        return ApiResponse.success(cartService.deleteCart(tableId));
    }
}

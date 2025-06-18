package com.yy.wechat.controller;

import com.yy.wechat.model.DTO.request.CartItemRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.VO.CartVO;
import com.yy.wechat.service.CartService;
import com.yy.wechat.utils.RequestContext;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @PostMapping
    public ApiResponse<CartVO> addOrUpdateItem(
            @Valid @RequestBody CartItemRequest req) {
        if (req.quantity() == 0){
            throw new IllegalArgumentException("商品数量不能为0");
        }
        return ApiResponse.success(cartService.addOrUpdateItem(RequestContext.getCurrentUserId(), req.productId(), req.quantity()));
    }

    @GetMapping
    public ApiResponse<CartVO> getCart() {
        return ApiResponse.success(cartService.getCart(RequestContext.getCurrentUserId()));
    }

    @DeleteMapping
    public ApiResponse<CartVO> deleteItem() {
        return ApiResponse.success(cartService.deleteCart(RequestContext.getCurrentUserId()));
    }
}

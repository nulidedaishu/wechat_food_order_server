package com.yy.wechat.controller;

import com.yy.wechat.model.DTO.request.CartRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.service.OrderService;
import com.yy.wechat.utils.RequestContext;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

    @PostMapping
    public ApiResponse<Long> createOrder(@RequestBody @Valid CartRequest cartRequest) {
        return ApiResponse.success(orderService.createOrder(cartRequest, RequestContext.getCurrentUserId()));
    }

    @PostMapping("/{orderId}/pay")
    public ApiResponse<Void> payOrder(@PathVariable @NotNull Long orderId) {
        orderService.processPayment(orderId);
        return ApiResponse.success();
    }

    @PostMapping("/{orderId}/complete")
    public ApiResponse<Void> completeOrder(@PathVariable @NotNull Long orderId) {
        orderService.completeOrder(orderId);
        return ApiResponse.success();
    }

    @PostMapping("/{orderId}/cancel")
    public ApiResponse<Void> cancelOrder(@PathVariable @NotNull Long orderId) {
        orderService.cancelOrder(orderId,null);
        return ApiResponse.success();
    }
}

package com.yy.wechat.controller;

import com.yy.wechat.model.DTO.request.OrderRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.VO.OrderDetailVO;
import com.yy.wechat.service.OrderService;
import com.yy.wechat.utils.RequestContext;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

    @GetMapping("/list")
    public ApiResponse<List<OrderDetailVO>> getOrders(@NotNull Integer status) {
        return ApiResponse.success(orderService.listOrders(status, RequestContext.getCurrentUserId()));
    }

    @PostMapping
    public ApiResponse<String> createOrder(@RequestBody @Valid OrderRequest orderRequest) {
        return ApiResponse.success(orderService.createOrder(orderRequest, RequestContext.getCurrentUserId()));
    }

    @PostMapping("/{orderId}/pay")
    public ApiResponse<Void> payOrder(@PathVariable @NotNull String orderId) {
        orderService.processPayment(Long.parseLong(orderId));
        return ApiResponse.success();
    }

    @PostMapping("/{orderId}/complete")
    public ApiResponse<Void> completeOrder(@PathVariable @NotNull String orderId) {
        orderService.completeOrder(Long.parseLong(orderId));
        return ApiResponse.success();
    }

    @PostMapping("/{orderId}/cancel")
    public ApiResponse<Void> cancelOrder(@PathVariable @NotNull String orderId) {
        orderService.cancelOrder(Long.parseLong(orderId), null);
        return ApiResponse.success();
    }
}

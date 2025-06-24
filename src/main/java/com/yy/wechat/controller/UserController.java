package com.yy.wechat.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.yy.wechat.exception.ServiceException;
import com.yy.wechat.model.DTO.request.BalanceRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.entity.User;
import com.yy.wechat.service.UserService;
import com.yy.wechat.utils.RequestContext;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@Validated
public class UserController {
    private final UserService userService;

    @GetMapping("/getBalance")
    public ApiResponse<Integer> getBalance() {
        User user = userService.getById(RequestContext.getCurrentUserId());
        if (user == null) {
            throw new ServiceException("用户不存在");
        }
        return ApiResponse.success(user.getBalance());
    }

    @PostMapping("/setBalance")
    @Transactional
    public ApiResponse<Integer> setBalance(@RequestBody @Valid BalanceRequest balanceRequest) {
        userService.update(Wrappers.<User>lambdaUpdate()
                .eq(User::getId, RequestContext.getCurrentUserId())
                .setSql("balance = balance + " + balanceRequest.amount() * 100));

        return ApiResponse.success(userService.getById(RequestContext.getCurrentUserId()).getBalance());
    }
}

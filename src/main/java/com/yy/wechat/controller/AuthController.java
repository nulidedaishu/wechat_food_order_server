package com.yy.wechat.controller;

import com.yy.wechat.model.DTO.request.LoginRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {
    private final WxAuthService wxAuthService;

    @PostMapping("/login")
    public ApiResponse<Map<String, String>> login(@RequestBody @Valid LoginRequest request) {
        String code = request.code();
        String token = wxAuthService.login(code);
        return ApiResponse.success(Collections.singletonMap("token", token));
    }

    @PostMapping("/logout")
    public ApiResponse<?> logout(HttpServletRequest request) {
        wxAuthService.logout(request.getHeader("Authorization"));
        return ApiResponse.success();
    }
}

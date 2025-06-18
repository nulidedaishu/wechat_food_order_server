package com.yy.wechat.model.DTO.request;

public record WxSessionRequest(String openid, String session_key, String unionid, Integer errcode, String errmsg) {
}

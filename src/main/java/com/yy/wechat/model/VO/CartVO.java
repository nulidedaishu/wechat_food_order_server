package com.yy.wechat.model.VO;

import java.util.List;

public record CartVO(Long userId, List<CartItemVO> items) {
}

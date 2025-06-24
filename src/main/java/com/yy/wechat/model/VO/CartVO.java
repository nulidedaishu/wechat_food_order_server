package com.yy.wechat.model.VO;

import java.util.List;

public record CartVO(Integer tableId, List<CartItemVO> items) {
}

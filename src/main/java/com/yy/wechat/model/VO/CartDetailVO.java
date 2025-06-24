package com.yy.wechat.model.VO;

import java.util.List;

public record CartDetailVO(Integer tableId,
                           Integer totalQuantity,
                           Integer totalAmountCents,
                           List<CartItemDetailVO> items) {
}

package com.yy.wechat.model.VO;

import java.util.List;

public record CategoryWithProductsVO(Long id, String name, List<ProductItemVO> products) {
}

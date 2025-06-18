package com.yy.wechat.utils;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.yy.wechat.model.VO.PageResultVO;

import java.util.Collections;

public class PaginationConverter {
    public static <T> PageResultVO<T> fromIPage(IPage<T> page) {
        return PageResultVO.<T>builder()
                .currentPage((int) page.getCurrent())
                .pageSize((int) page.getSize())
                .total(page.getTotal())
                .totalPages((int) page.getPages())
                .records(page.getRecords())
                .build();
    }

    public static <T> PageResultVO<T> empty() {
        return PageResultVO.<T>builder()
                .currentPage(1)
                .pageSize(10)
                .total(0L)
                .totalPages(0)
                .records(Collections.emptyList())
                .build();
    }
}

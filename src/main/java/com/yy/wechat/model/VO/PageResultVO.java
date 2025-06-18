package com.yy.wechat.model.VO;

import lombok.Builder;
import java.util.List;

/**
 * @param currentPage 当前页码（从1开始）
 * @param pageSize    每页条数
 * @param total       总记录数
 * @param totalPages  总页数
 * @param records     当前页数据列表
 */
@Builder
public record PageResultVO<T>(Integer currentPage, Integer pageSize, Long total, Integer totalPages, List<T> records) {
}
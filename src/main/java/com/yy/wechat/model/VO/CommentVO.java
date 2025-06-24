package com.yy.wechat.model.VO;

import java.time.LocalDateTime;

public record CommentVO (Long id, String orderId, String comment, Integer score, LocalDateTime createAt){
}

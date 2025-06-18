package com.yy.wechat.model.message;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

// 消息体
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderMessage implements Serializable {
    private long orderId;
    private long createTimestamp;
}
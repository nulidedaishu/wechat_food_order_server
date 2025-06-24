package com.yy.wechat.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.yy.wechat.model.DTO.request.CommentRequest;
import com.yy.wechat.model.DTO.response.ApiResponse;
import com.yy.wechat.model.entity.Comment;
import com.yy.wechat.model.VO.CommentVO;
import com.yy.wechat.service.CommentService;
import com.yy.wechat.service.OrderService;
import com.yy.wechat.utils.RequestContext;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/comments")
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;
    private final OrderService orderService;

    @PostMapping
    public ApiResponse<Void> createComment(@RequestBody @Valid CommentRequest commentRequest) {
        Comment comment = Comment.builder()
                .userId(RequestContext.getCurrentUserId())
                .orderId(Long.valueOf(commentRequest.orderId()))
                .tableId(orderService.getById(Long.valueOf(commentRequest.orderId())).getTableId())
                .score(commentRequest.score())
                .comment(commentRequest.comment())
                .build();
        commentService.save(comment);
        orderService.commentOrder(Long.parseLong(commentRequest.orderId()));
        return ApiResponse.success();
    }

    @GetMapping("/list")
    public ApiResponse<List<CommentVO>> listComments() {
        List<Comment> comments = commentService.list(Wrappers.<Comment>lambdaQuery()
                .eq(Comment::getUserId, RequestContext.getCurrentUserId())
                .orderByDesc(Comment::getCreateAt));
        return ApiResponse.success(comments.stream().map(comment -> new CommentVO(
                comment.getId(),
                String.valueOf(comment.getOrderId()),
                comment.getComment(),
                comment.getScore(),
                comment.getCreateAt()
        )).toList());
    }

    @GetMapping("/{orderId}")
    public ApiResponse<CommentVO> getCommentById(@PathVariable @NotBlank String orderId) {
        Comment comment = commentService.getOne(Wrappers.<Comment>lambdaQuery().eq(Comment::getOrderId, Long.parseLong(orderId)));
        if (comment == null) {
            return ApiResponse.success(new CommentVO(null, null, null, null, null));
        }
        return ApiResponse.success(new CommentVO(
                comment.getId(),
                String.valueOf(comment.getOrderId()),
                comment.getComment(),
                comment.getScore(),
                comment.getCreateAt()));
    }

    @PutMapping
    public ApiResponse<Void> updateComment(@RequestBody @Valid CommentRequest commentRequest) {
        Comment comment = commentService.getOne(Wrappers.<Comment>lambdaQuery().eq(Comment::getOrderId, Long.parseLong(commentRequest.orderId())));
        if (comment == null) {
            comment = Comment.builder()
                    .userId(RequestContext.getCurrentUserId())
                    .orderId(Long.valueOf(commentRequest.orderId()))
                    .tableId(orderService.getById(Long.valueOf(commentRequest.orderId())).getTableId())
                    .comment(commentRequest.comment())
                    .score(commentRequest.score())
                    .build();
            commentService.save(comment);
        }
        comment.setComment(commentRequest.comment());
        comment.setScore(commentRequest.score());
        commentService.updateById(comment);
        return ApiResponse.success();
    }

    @DeleteMapping("/{id}")
    public ApiResponse<Void> deleteComment(@PathVariable @NotBlank String id) {
        commentService.removeById(Long.parseLong(id));
        return ApiResponse.success();
    }
}

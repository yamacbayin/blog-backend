package com.yamacbayin.blogbackend.exception;

import com.yamacbayin.blogbackend.entity.Comment;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class CommentException extends RuntimeException {

    private final Comment comment;

    public CommentException(String message, Comment comment) {
        super(message);
        this.comment = comment;
    }

    public CommentException(String errorMessage, int id) {
        super((errorMessage));
        this.comment = new Comment();
        this.comment.setCommentId(id);
    }

    public Comment getComment() {
        return comment;
    }
}
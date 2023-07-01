package com.yamacbayin.blogbackend.exception;

import com.yamacbayin.blogbackend.entity.Post;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class PostException extends RuntimeException {

    private final Post post;

    public PostException(String message, Post post) {
        super(message);
        this.post = post;
    }

    public PostException(String errorMessage, int id) {
        super((errorMessage));
        this.post = new Post();
        this.post.setPostId(id);
    }

    public Post getPost() {
        return post;
    }
}
package com.yamacbayin.blogbackend.exception;

import com.yamacbayin.blogbackend.entity.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class UserException extends RuntimeException {

    private final User user;

    public UserException(String message, User user) {
        super(message);
        this.user = user;
    }

    public UserException(String errorMessage, int id) {
        super((errorMessage));
        this.user = new User();
        this.user.setUserId(id);
    }

    public User getUser() {
        return user;
    }
}

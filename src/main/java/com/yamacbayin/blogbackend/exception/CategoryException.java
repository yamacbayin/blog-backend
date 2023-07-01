package com.yamacbayin.blogbackend.exception;

import com.yamacbayin.blogbackend.entity.Category;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class CategoryException extends RuntimeException {

    private final Category category;

    public CategoryException(String message, Category category) {
        super(message);
        this.category = category;
    }

    public CategoryException(String errorMessage, int id) {
        super((errorMessage));
        this.category = new Category();
        this.category.setCategoryId(id);
    }

    public Category getCategory() {
        return category;
    }
}

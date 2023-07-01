package com.yamacbayin.blogbackend.service;


import com.yamacbayin.blogbackend.dto.CategoryDto;
import com.yamacbayin.blogbackend.entity.Category;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface ICategoryService {

    ResponseEntity<Category> save(Category category);

    ResponseEntity<Category> update(Category category);

    ResponseEntity<Category> findById(int id);

    List<CategoryDto> findAll();

    ResponseEntity<Category> deleteById(int id);

}

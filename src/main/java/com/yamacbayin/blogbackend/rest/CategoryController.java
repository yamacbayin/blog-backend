package com.yamacbayin.blogbackend.rest;

import com.yamacbayin.blogbackend.dto.CategoryDto;
import com.yamacbayin.blogbackend.entity.Category;
import com.yamacbayin.blogbackend.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/categories")
public class CategoryController {

    private final ICategoryService categoryService;

    @Autowired
    public CategoryController(ICategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping
    public List<CategoryDto> findAll() {
        return categoryService.findAll();
    }

    @PostMapping
    public ResponseEntity<Category> addCategory(@RequestBody Category category) {
        category.setCategoryId(0);
        return categoryService.save(category);
    }

    @GetMapping("/id={categoryId}")
    public ResponseEntity<Category> findCategoryById(@PathVariable int categoryId) {
        return categoryService.findById(categoryId);
    }

    @PutMapping()
    public ResponseEntity<Category> updateCategory(@RequestBody Category category){
        return categoryService.update(category);
    }

    @DeleteMapping("/id={categoryId}")
    public ResponseEntity<Category> deleteCategory(@PathVariable int categoryId) {
        return categoryService.deleteById(categoryId);
    }
}

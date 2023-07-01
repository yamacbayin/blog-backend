package com.yamacbayin.blogbackend.service;

import com.yamacbayin.blogbackend.dto.CategoryDto;
import com.yamacbayin.blogbackend.entity.Category;
import com.yamacbayin.blogbackend.exception.CategoryException;
import com.yamacbayin.blogbackend.repository.CategoryRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryService implements ICategoryService{

    private final CategoryRepository categoryRepository;

    @Autowired
    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Transactional
    @Override
    public ResponseEntity<Category> save(Category category) {
        try {
            Category savedCategory = categoryRepository.save(category);
            return ResponseEntity.ok(savedCategory);
        } catch (DataIntegrityViolationException ex) {
            throw new CategoryException("Error saving category: " + ex.getMessage(), category);
        } catch (Exception ex) {
            throw new CategoryException("An error occurred while saving the category.", category);
        }
    }
    @Transactional
    @Override
    public ResponseEntity<Category> update(Category category) {
        try {
            categoryRepository.findById(category.getCategoryId())
                    .orElseThrow(() ->
                            new CategoryException("Category not found. Id " + category.getCategoryId() + " is not valid.",
                                    category.getCategoryId()));
            return save(category);
        } catch (CategoryException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (DataIntegrityViolationException ex) {
            throw new CategoryException("Error updating category: " + ex.getMessage(), category);
        } catch (Exception ex) {
            throw new CategoryException("An error occurred while updating the category.", category);
        }
    }

    @Override
    public ResponseEntity<Category> findById(int id) {
        try {
            Category existingCategory = categoryRepository.findById(id)
                    .orElseThrow(() ->
                            new CategoryException("Category not found. Id " + id + " is not valid.", id));
            return ResponseEntity.ok(existingCategory);
        } catch (CategoryException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new CategoryException("An error occurred while retrieving the category.", id);
        }
    }

    @Override
    public List<CategoryDto> findAll() {
        return categoryRepository.findAllWithPostCount();
    }
    @Transactional
    @Override
    public ResponseEntity<Category> deleteById(int id) {
        try {
            Category existingCategory = categoryRepository.findById(id)
                    .orElseThrow(() ->
                            new CategoryException("Cannot delete category. Id " + id + " is not valid.", id));
            categoryRepository.deleteById(id);
            return new ResponseEntity<>(existingCategory, HttpStatus.OK);
        } catch (CategoryException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new CategoryException("An error occurred while deleting the category.", id);
        }
    }
}

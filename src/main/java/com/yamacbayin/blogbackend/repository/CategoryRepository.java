package com.yamacbayin.blogbackend.repository;

import com.yamacbayin.blogbackend.dto.CategoryDto;
import com.yamacbayin.blogbackend.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Integer> {

    String ALL_WITH_POSTCOUNT =
            """
                    SELECT
                    	category_id AS cid,
                    	name,
                    	creation_date AS creationDate,
                    	(SELECT COUNT(*)
                    		FROM posts
                    		WHERE categories.category_id = posts.category_id)
                    		AS postCount
                    FROM categories;
                    """;

    @Query(value = ALL_WITH_POSTCOUNT, nativeQuery = true)
    List<CategoryDto> findAllWithPostCount();
}

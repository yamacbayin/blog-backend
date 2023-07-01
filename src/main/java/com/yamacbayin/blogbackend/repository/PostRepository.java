package com.yamacbayin.blogbackend.repository;

import com.yamacbayin.blogbackend.dto.PostDto;
import com.yamacbayin.blogbackend.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Integer> {

    String ALL_WITH_USERNAME_CATEGORYNAME_COMMENTCOUNT =
            """
                    SELECT
                    	post_id AS pid,
                    	user_id AS uid,
                    	category_id as cid,
                    	title,
                    	content,
                    	view_count AS viewCount,
                    	creation_date AS creationDate,
                    	is_published AS isPublished,
                    	(SELECT username
                    		FROM users
                    		WHERE posts.user_id = users.user_id)
                    		AS username,
                    	(SELECT categories.name
                    		FROM categories
                    		WHERE posts.category_id = categories.category_id)
                    		AS categoryName,
                    	(SELECT COUNT(*)
                    		FROM comments
                    		WHERE posts.post_id = comments.post_id)
                    		AS commentCount
                    FROM posts;
                    """;
    @Query(value = ALL_WITH_USERNAME_CATEGORYNAME_COMMENTCOUNT, nativeQuery = true)
    List<PostDto> findAllWithUsernameCategoryNameCommentCount();
}

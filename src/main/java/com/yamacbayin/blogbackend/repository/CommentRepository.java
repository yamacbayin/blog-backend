package com.yamacbayin.blogbackend.repository;

import com.yamacbayin.blogbackend.dto.CommentDto;
import com.yamacbayin.blogbackend.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    String ALL_WITH_USERNAME_POSTTITLE =
            """
                    SELECT
                    	comment_id AS cid,
                    	post_id AS pid,
                    	user_id AS uid,
                    	comment,
                    	creation_date AS creationDate,
                    	is_confirmed AS isConfirmed,
                    	(SELECT username
                    		FROM users
                    		WHERE comments.user_id = users.user_id)
                    		AS username,
                    	(SELECT title
                    		FROM posts
                    		WHERE comments.post_id = posts.post_id)
                    		AS postTitle
                    FROM comments;       
                    """;

    @Query(value = ALL_WITH_USERNAME_POSTTITLE, nativeQuery = true)
    List<CommentDto> findAllWithUsernamePostTitle();

}

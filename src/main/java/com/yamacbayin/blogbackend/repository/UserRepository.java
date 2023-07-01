package com.yamacbayin.blogbackend.repository;

import com.yamacbayin.blogbackend.dto.UserDto;
import com.yamacbayin.blogbackend.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer> {

    String ALL_WITH_POSTCOUNT_COMMENTCOUNT =
            """
                    SELECT
                    	user_id AS id,
                    	username,
                    	email,
                    	creation_date as creationDate,
                    	is_active as isActive,
                    	(SELECT COUNT(*) FROM posts
                    	WHERE posts.user_id = users.user_id)
                    	AS postCount,
                    	(SELECT COUNT(*) FROM comments
                    	WHERE comments.user_id = users.user_id)
                    	AS commentCount
                    FROM USERS;
                    """;

    @Query(value = ALL_WITH_POSTCOUNT_COMMENTCOUNT, nativeQuery = true)
    List<UserDto> findAllWithPostAndCommentCount();

}

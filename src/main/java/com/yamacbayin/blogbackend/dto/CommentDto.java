package com.yamacbayin.blogbackend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public interface CommentDto {
    //all comment fields
    @JsonProperty("comment_id")
    Integer getCid();

    @JsonProperty("post_id")
    Integer getPid();

    @JsonProperty("user_id")
    Integer getUid();

    String getComment();

    Date getCreationDate();

    Boolean getIsConfirmed();

    //username - post title
    String getUsername();

    String getPostTitle();

}

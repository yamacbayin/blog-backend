package com.yamacbayin.blogbackend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public interface PostDto {

    //all post info
    @JsonProperty("post_id")
    Integer getPid();

    @JsonProperty("user_id")
    Integer getUid();

    @JsonProperty("category_id")
    Integer getCid();

    String getTitle();

    String getContent();

    Integer getViewCount();

    Date getCreationDate();

    Boolean getIsPublished();

    //author username
    String getUsername();

    //category name
    String getCategoryName();

    //comment count
    Integer getCommentCount();

}

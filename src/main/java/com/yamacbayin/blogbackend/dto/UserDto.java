package com.yamacbayin.blogbackend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public interface UserDto {
    @JsonProperty("user_id")
    Integer getId();

    String getUsername();

    String getEmail();

    Date getCreationDate();

    Boolean getIsActive();

    Integer getPostCount();

    Integer getCommentCount();
}

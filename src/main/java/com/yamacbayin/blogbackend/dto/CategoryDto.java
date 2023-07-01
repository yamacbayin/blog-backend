package com.yamacbayin.blogbackend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;

public interface CategoryDto {
    //all category fields
    @JsonProperty("category_id")
    Integer getCid();

    String getName();

    Date getCreationDate();

    //total posts
    Integer getPostCount();
}

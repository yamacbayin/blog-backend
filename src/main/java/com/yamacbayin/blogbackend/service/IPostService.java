package com.yamacbayin.blogbackend.service;


import com.yamacbayin.blogbackend.dto.PostDto;
import com.yamacbayin.blogbackend.entity.Post;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface IPostService {


    ResponseEntity<Post> save(Post post);

    ResponseEntity<Post> update(Post post);

    ResponseEntity<Post> findById(int id);

    List<PostDto> findAll();

    ResponseEntity<Post> deleteById(int id);

}

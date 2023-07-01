package com.yamacbayin.blogbackend.service;


import com.yamacbayin.blogbackend.dto.CommentDto;
import com.yamacbayin.blogbackend.entity.Comment;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface ICommentService {

    ResponseEntity<Comment> save(Comment comment);

    ResponseEntity<Comment> update(Comment comment);

    ResponseEntity<Comment> findById(int id);

    List<CommentDto> findAll();

    ResponseEntity<Comment> deleteById(int id);

}

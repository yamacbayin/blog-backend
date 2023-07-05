package com.yamacbayin.blogbackend.rest;

import com.yamacbayin.blogbackend.dto.CommentDto;
import com.yamacbayin.blogbackend.entity.Comment;
import com.yamacbayin.blogbackend.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comments")
@CrossOrigin(origins = "*")
public class CommentController {

    private final ICommentService commentService;

    @Autowired
    public CommentController(ICommentService commentService) {
        this.commentService = commentService;
    }

    @GetMapping
    public List<CommentDto> findAll() {
        return commentService.findAll();
    }

    @PostMapping
    public ResponseEntity<Comment> addComment(@RequestBody Comment comment) {
        comment.setCommentId(0);
        return commentService.save(comment);
    }

    @GetMapping("/id={commentId}")
    public ResponseEntity<Comment> findCommentById(@PathVariable int commentId) {
        return commentService.findById(commentId);
    }

    @PutMapping()
    public ResponseEntity<Comment> updateComment(@RequestBody Comment comment){
        return commentService.update(comment);
    }

    @DeleteMapping("/id={commentId}")
    public ResponseEntity<Comment> deleteComment(@PathVariable int commentId) {
        return commentService.deleteById(commentId);
    }
}

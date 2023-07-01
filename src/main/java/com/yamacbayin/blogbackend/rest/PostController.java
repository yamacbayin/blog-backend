package com.yamacbayin.blogbackend.rest;


import com.yamacbayin.blogbackend.dto.PostDto;
import com.yamacbayin.blogbackend.entity.Post;
import com.yamacbayin.blogbackend.service.IPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/posts")
public class PostController {

    private final IPostService postService;
    @Autowired
    public PostController(IPostService postService) {
        this.postService = postService;
    }

    @GetMapping
    public List<PostDto> findAll() {
        return postService.findAll();
    }

    @PostMapping
    public ResponseEntity<Post> addPost(@RequestBody Post post) {
        post.setPostId(0);
        return postService.save(post);
    }


    @GetMapping("/id={postId}")
    public ResponseEntity<Post> findPostById(@PathVariable int postId) {
        return postService.findById(postId);
    }

    @PutMapping()
    public ResponseEntity<Post> updatePost(@RequestBody Post post){
        return postService.update(post);
    }

    @DeleteMapping("/id={postId}")
    public ResponseEntity<Post> deletePost(@PathVariable int postId) {
        return postService.deleteById(postId);
    }

}

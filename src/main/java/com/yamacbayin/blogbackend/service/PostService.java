package com.yamacbayin.blogbackend.service;

import com.yamacbayin.blogbackend.dto.PostDto;
import com.yamacbayin.blogbackend.entity.Post;
import com.yamacbayin.blogbackend.exception.PostException;
import com.yamacbayin.blogbackend.repository.PostRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostService implements IPostService{

    private final PostRepository postRepository;

    @Autowired
    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }
    @Transactional
    @Override
    public ResponseEntity<Post> save(Post post) {
        try {
            Post savedPost = postRepository.save(post);
            return ResponseEntity.ok(savedPost);
        } catch (DataIntegrityViolationException ex) {
            throw new PostException("Error saving post: " + ex.getMessage(), post);
        } catch (Exception ex) {
            throw new PostException("An error occurred while saving the post.", post);
        }
    }

    @Transactional
    @Override
    public ResponseEntity<Post> update(Post post) {
        try {
            postRepository.findById(post.getPostId())
                    .orElseThrow(() ->
                            new PostException("Post not found. Id " + post.getPostId() + " is not valid.",
                                    post.getUserId()));
            return save(post);
        } catch (PostException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (DataIntegrityViolationException ex) {
            throw new PostException("Error updating post: " + ex.getMessage(), post);
        } catch (Exception ex) {
            throw new PostException("An error occurred while updating the post.", post);
        }
    }

    @Override
    public ResponseEntity<Post> findById(int id) {
        try {
            Post existingPost = postRepository.findById(id)
                    .orElseThrow(() ->
                            new PostException("Post not found. Id " + id + " is not valid.", id));
            return ResponseEntity.ok(existingPost);
        } catch (PostException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new PostException("An error occurred while retrieving the post.", id);
        }
    }

    @Override
    public List<PostDto> findAll() {
        return postRepository.findAllWithUsernameCategoryNameCommentCount();
    }
    @Transactional
    @Override
    public ResponseEntity<Post> deleteById(int id) {
        try {
            Post existingPost = postRepository.findById(id)
                    .orElseThrow(() ->
                            new PostException("Cannot delete post. Id " + id + " is not valid.", id));
            postRepository.deleteById(id);
            return new ResponseEntity<>(existingPost, HttpStatus.OK);
        } catch (PostException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new PostException("An error occurred while deleting the post.", id);
        }
    }
}

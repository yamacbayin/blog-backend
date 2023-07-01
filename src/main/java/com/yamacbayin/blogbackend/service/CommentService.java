package com.yamacbayin.blogbackend.service;

import com.yamacbayin.blogbackend.dto.CommentDto;
import com.yamacbayin.blogbackend.entity.Comment;
import com.yamacbayin.blogbackend.exception.CommentException;
import com.yamacbayin.blogbackend.repository.CommentRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService implements ICommentService{

    private final CommentRepository commentRepository;

    @Autowired
    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @Transactional
    @Override
    public ResponseEntity<Comment> save(Comment comment) {
        try {
            Comment savedComment = commentRepository.save(comment);
            return ResponseEntity.ok(savedComment);
        } catch (DataIntegrityViolationException ex) {
            throw new CommentException("Error saving comment: " + ex.getMessage(), comment);
        } catch (Exception ex) {
            throw new CommentException("An error occurred while saving the comment.", comment);
        }
    }
    @Transactional
    @Override
    public ResponseEntity<Comment> update(Comment comment) {
        try {
            commentRepository.findById(comment.getCommentId())
                    .orElseThrow(() ->
                            new CommentException("Comment not found. Id " + comment.getCommentId() + " is not valid.",
                                    comment.getCommentId()));
            return save(comment);
        } catch (CommentException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (DataIntegrityViolationException ex) {
            throw new CommentException("Error updating comment: " + ex.getMessage(), comment);
        } catch (Exception ex) {
            throw new CommentException("An error occurred while updating the comment.", comment);
        }
    }

    @Override
    public ResponseEntity<Comment> findById(int id) {
        try {
            Comment existingComment = commentRepository.findById(id)
                    .orElseThrow(() ->
                            new CommentException("Comment not found. Id " + id + " is not valid.", id));
            return ResponseEntity.ok(existingComment);
        } catch (CommentException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new CommentException("An error occurred while retrieving the comment.", id);
        }
    }

    @Override
    public List<CommentDto> findAll() {
        return commentRepository.findAllWithUsernamePostTitle();
    }
    @Transactional
    @Override
    public ResponseEntity<Comment> deleteById(int id) {
        try {
            Comment existingComment = commentRepository.findById(id)
                    .orElseThrow(() ->
                            new CommentException("Cannot delete comment. Id " + id + " is not valid.", id));
            commentRepository.deleteById(id);
            return new ResponseEntity<>(existingComment, HttpStatus.OK);
        } catch (CommentException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new CommentException("An error occurred while deleting the comment.", id);
        }
    }
}

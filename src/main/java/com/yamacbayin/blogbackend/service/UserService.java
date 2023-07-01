package com.yamacbayin.blogbackend.service;

import com.yamacbayin.blogbackend.dto.UserDto;
import com.yamacbayin.blogbackend.entity.User;
import com.yamacbayin.blogbackend.exception.UserException;
import com.yamacbayin.blogbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements IUserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public List<UserDto> findAll() {
        return userRepository.findAllWithPostAndCommentCount();
    }

    @Transactional
    @Override
    public ResponseEntity<User> save(User user) {
        try {
            User savedUser = userRepository.save(user);
            return ResponseEntity.ok(savedUser);
        } catch (DataIntegrityViolationException ex) {
            throw new UserException("Error saving user: " + ex.getMessage(), user);
        } catch (Exception ex) {
            throw new UserException("An error occurred while saving the user.", user);
        }
    }

    @Transactional
    @Override
    public ResponseEntity<User> update(User user) {
        try {
            userRepository.findById(user.getUserId())
                    .orElseThrow(() ->
                            new UserException("User not found. Id " + user.getUserId() + " is not valid.",
                                    user.getUserId()));
            return save(user);
        } catch (UserException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (DataIntegrityViolationException ex) {
            throw new UserException("Error updating user: " + ex.getMessage(), user);
        } catch (Exception ex) {
            throw new UserException("An error occurred while updating the user.", user);
        }
    }

    @Override
    public ResponseEntity<User> findById(int id) {
        try {
            User existingUser = userRepository.findById(id)
                    .orElseThrow(() ->
                            new UserException("User not found. Id " + id + " is not valid.", id));
            return ResponseEntity.ok(existingUser);
        } catch (UserException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new UserException("An error occurred while retrieving the user.", id);
        }
    }

    @Transactional
    @Override
    public ResponseEntity<User> deleteById(int id) {
        try {
            User existingUser = userRepository.findById(id)
                    .orElseThrow(() ->
                            new UserException("Cannot delete user. Id " + id + " is not valid.", id));
            userRepository.deleteById(id);
            return new ResponseEntity<>(existingUser, HttpStatus.OK);
        } catch (UserException ex) {
            throw ex; // Re-throw the exception as it is
        } catch (Exception ex) {
            throw new UserException("An error occurred while deleting the user.", id);
        }
    }
}

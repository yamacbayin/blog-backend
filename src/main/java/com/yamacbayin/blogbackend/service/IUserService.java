package com.yamacbayin.blogbackend.service;


import com.yamacbayin.blogbackend.dto.UserDto;
import com.yamacbayin.blogbackend.entity.User;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface IUserService {

    ResponseEntity<User> save(User user);

    ResponseEntity<User> update(User user);

    ResponseEntity<User> findById(int id);

    List<UserDto> findAll();

    ResponseEntity<User> deleteById(int id);

}

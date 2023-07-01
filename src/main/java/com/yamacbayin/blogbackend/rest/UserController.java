package com.yamacbayin.blogbackend.rest;

import com.yamacbayin.blogbackend.dto.UserDto;
import com.yamacbayin.blogbackend.entity.User;
import com.yamacbayin.blogbackend.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private final IUserService userService;

    @Autowired
    public UserController(IUserService userService) {
        this.userService = userService;
    }

    @PostMapping()
    public ResponseEntity<User> addUser(@RequestBody User user) {
        //just in case they pass an id in JSON
        //set id to 0 to force a save of new item instead of update
        user.setUserId(0);
        return userService.save(user);
    }

    @GetMapping()
    public List<UserDto> allUsers() {
        return userService.findAll();
    }

    @GetMapping("/id={userId}")
    public ResponseEntity<User> findUserById(@PathVariable int userId) {
        return userService.findById(userId);
    }

    @PutMapping()
    public ResponseEntity<User> updateUser(@RequestBody User user){
        return userService.update(user);
    }

     @DeleteMapping("/id={userId}")
    public ResponseEntity<User> deleteUser(@PathVariable int userId) {
        return userService.deleteById(userId);
    }

}

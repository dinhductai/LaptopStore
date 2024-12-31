
package com.example.ProjectLaptopStore.Controller;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Service.UserService;
import com.example.ProjectLaptopStore.Util.JwtTokenUtil;
import com.nimbusds.jose.JOSEException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.List;

@RestController
@RequiredArgsConstructor
//phân quyền

public class AuthenticationController {
    private static final Logger log = LoggerFactory.getLogger(AuthenticationController.class);
    @Autowired
    UserService userService;

    //    @GetMapping(value = "/admin/users")
//    public List<User_RegisterDTO> listUserLogin() {
//        var authen = SecurityContextHolder.getContext().getAuthentication();
//        log.info("user name: {}", authen.getName());
//        log.info("Role: {}", authen.getAuthorities());
//        List<User_RegisterDTO> users = userService.getAllUsers();
//        return users;
//    }
    @GetMapping(value = "/admin/users")
    public Page<User_DTO> getAllUsers(@RequestParam(name = "pageNo")int pageNo, @RequestParam(name = "pageSize")int pageSize){
        Page<User_DTO> rs = userService.searchUser(pageNo,pageSize);
        return rs;
    }

    // Dang ki
    @PostMapping(value = "/register")
    public ResponseEntity<?> createUser(@RequestBody User_RegisterDTO user) {
        userService.createUser(user);
        return ResponseEntity.ok("User created");
    }

    @DeleteMapping(value = "/user-delete/{phoneNumber}")
    public ResponseEntity<?> deleteUser(@PathVariable String phoneNumber) {
        userService.deleteUser(phoneNumber);
        return ResponseEntity.ok("User deleted");
    }

    // Dang nhap
    @PostMapping(value = "/login")
    public User_AuthenticationResponseDTO login(@RequestBody User_LoginDTO user) {
        return userService.Authenticate(user.getPhoneNumber(), user.getPassword());
    }





}
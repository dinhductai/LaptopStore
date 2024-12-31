package com.example.ProjectLaptopStore.Config;

import com.example.ProjectLaptopStore.Entity.AdminEntity;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.Enum.User_Enum;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Repository.AdminRepository;
import com.example.ProjectLaptopStore.Repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.beans.Encoder;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Configuration
@Slf4j
public class ApplicationConfifAdmin {

    @Bean
    ApplicationRunner applicationRunner(UserRepository userRepository, AdminRepository adminRepository) {
        return args -> {
            UserEntity user = userRepository.findByUserType(User_Enum.admin.name());
            AdminEntity admin = new AdminEntity();
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            if (user == null) {
                UserEntity user_admin = new UserEntity();
                user_admin.setUserType(User_Enum.admin);
                user_admin.setPassword(encoder.encode("admin"));
                user_admin.setEmail("admin@admin.com");
                user_admin.setPhoneNumber("123456789");
                user_admin.setFullName("admin");
                Date currentDate = new Date();
                user_admin.setRegistrationDate(currentDate);
                userRepository.save(user_admin);
                admin.setCreatedDate(new Date());
                admin.setUser(user_admin);
                admin.setStatus(Status_Enum.active);
                adminRepository.save(admin);

                log.info("Admin created with Infor: ADMIN phone: " + user_admin.getPhoneNumber()+", ADMIN password: 123456789" );
            }
        };
    }

}

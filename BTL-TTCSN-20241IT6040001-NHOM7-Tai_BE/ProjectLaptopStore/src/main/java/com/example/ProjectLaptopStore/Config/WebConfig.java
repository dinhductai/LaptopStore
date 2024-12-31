package com.example.ProjectLaptopStore.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // cho phép tất cả các API
                .allowedOrigins("http://127.0.0.1:5500") //cho phép fe
                .allowedMethods("GET", "POST", "PUT", "DELETE"); // các phương thức HTTP được cho phép
    }
}


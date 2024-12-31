package com.example.ProjectLaptopStore.Exception;

import org.springframework.web.bind.annotation.ExceptionHandler;

public class AccessDeniedException extends RuntimeException {
    public AccessDeniedException(String message) {
        super(message);
    }

}

package com.example.ProjectLaptopStore.Exception;

import com.example.ProjectLaptopStore.DTO.ErrorDetailDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.time.LocalDateTime;

@ControllerAdvice
public class ControllerAdvisor extends ResponseEntityExceptionHandler {
//    @ExceptionHandler(Exception.class)
//    public final ResponseEntity<ErrorDetailDTO> handleAllExceptions(Exception ex, WebRequest request) {
//        ErrorDetailDTO errorDetail = new ErrorDetailDTO(LocalDateTime.now()
//        , ex.getMessage(), request.getDescription(false));
//        return new ResponseEntity<>(errorDetail, HttpStatus.INTERNAL_SERVER_ERROR);
//    }

    @ExceptionHandler(UserNotFoundException.class)
    public final ResponseEntity<ErrorDetailDTO> handleUserNotFoundException(UserNotFoundException ex, WebRequest request) {
        ErrorDetailDTO errorDetail = new ErrorDetailDTO(LocalDateTime.now()
                , ex.getMessage(), request.getDescription(false));
        return new ResponseEntity<>(errorDetail, HttpStatus.NOT_FOUND);
    }
}

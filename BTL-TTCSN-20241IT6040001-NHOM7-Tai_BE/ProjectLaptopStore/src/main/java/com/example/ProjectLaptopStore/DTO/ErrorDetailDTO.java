package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
@Getter
@Setter
public class ErrorDetailDTO {
    private LocalDateTime timestamp;
    private String message;
    private String detail;

    public ErrorDetailDTO() {
    }

    public ErrorDetailDTO(LocalDateTime timestamp, String message, String detail) {
        this.timestamp = timestamp;
        this.message = message;
        this.detail = detail;
    }
}

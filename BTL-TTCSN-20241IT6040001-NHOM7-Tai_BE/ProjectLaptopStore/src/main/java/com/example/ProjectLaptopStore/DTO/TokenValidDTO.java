package com.example.ProjectLaptopStore.DTO;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TokenValidDTO {
    boolean valid;
    String message;
    String token;
}

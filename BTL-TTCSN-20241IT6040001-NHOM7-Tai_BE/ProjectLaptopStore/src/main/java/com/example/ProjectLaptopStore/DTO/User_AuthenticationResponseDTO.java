package com.example.ProjectLaptopStore.DTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User_AuthenticationResponseDTO {
    private String token;
    private boolean status;
}

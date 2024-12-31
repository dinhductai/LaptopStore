package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Getter
@Setter
@Builder
public class Product_ProductSearchCheckBoxDTO {
    private List<Integer> idBrand;//id cua product chua brand nay
    private List<String> price;
    private List<String> cpu;
    private List<Integer> ram;
    private List<String> hardDrive;
    private List<String> demand;
    private List<String> screenSize;
}

package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.ProductDescriptionDTO;

import java.util.List;
import java.util.Map;

public interface ProductDescriptionService {
    List<ProductDescriptionDTO> finAllProductDescription();

    ProductDescriptionDTO finProductDescriptionById(Long id);
    Map<String,String> getCPUTechnologyForCheckbox();
    Map<Integer,Integer> getRamCapacityForCheckbox();
    Map<String,String> getHardDriveForCheckbox();
    Map<String,String> getScreensizeForCheckbox();

}

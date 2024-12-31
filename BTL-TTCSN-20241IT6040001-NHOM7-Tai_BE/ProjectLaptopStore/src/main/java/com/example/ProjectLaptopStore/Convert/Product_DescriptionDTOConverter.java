package com.example.ProjectLaptopStore.Convert;

import com.example.ProjectLaptopStore.DTO.ProductDescriptionDTO;
import com.example.ProjectLaptopStore.Entity.ProductDescriptionEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Product_DescriptionDTOConverter {
    @Autowired
    private ModelMapper modelMapper;

    public ProductDescriptionDTO toProductDescriptionDTO(ProductDescriptionEntity productDescriptionEntity) {
        ProductDescriptionDTO productDescriptionDTO = modelMapper.map(productDescriptionEntity,ProductDescriptionDTO.class);
        return productDescriptionDTO;
    }
}

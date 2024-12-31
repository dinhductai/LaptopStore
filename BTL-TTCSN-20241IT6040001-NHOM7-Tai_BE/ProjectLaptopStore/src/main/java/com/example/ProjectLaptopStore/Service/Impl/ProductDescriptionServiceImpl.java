package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Convert.Product_DescriptionDTOConverter;
import com.example.ProjectLaptopStore.DTO.ProductDescriptionDTO;
import com.example.ProjectLaptopStore.Entity.ProductDescriptionEntity;
import com.example.ProjectLaptopStore.Repository.ProductDescriptionRepository;
import com.example.ProjectLaptopStore.Service.ProductDescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductDescriptionServiceImpl implements ProductDescriptionService {

    @Autowired
    private ProductDescriptionRepository productDescriptionRepository;

    @Autowired
    private Product_DescriptionDTOConverter productDescriptionDTOConverter;

    @Override
    public List<ProductDescriptionDTO> finAllProductDescription() {
        List<ProductDescriptionEntity> productDescriptionEntityList = productDescriptionRepository.findAll();
        List<ProductDescriptionDTO> result = new ArrayList<>();
        for (ProductDescriptionEntity item : productDescriptionEntityList) {
            ProductDescriptionDTO productDescription = productDescriptionDTOConverter.toProductDescriptionDTO(item);
            result.add(productDescription);
        }
        return result;
    }

    @Override
    public ProductDescriptionDTO finProductDescriptionById(Long productID) {
        ProductDescriptionEntity productDescriptionEntity = productDescriptionRepository.findAllByProductId(productID);
        ProductDescriptionDTO result = productDescriptionDTOConverter.toProductDescriptionDTO(productDescriptionEntity);
        return result;
    }

    //API lấy công nghệ CPU cho checkbox
    @Override
    public Map<String, String> getCPUTechnologyForCheckbox() {
        Map<String, String> result = new HashMap<>();
        List<ProductDescriptionEntity> productDescriptionEntityList = productDescriptionRepository.findAll();
        for (ProductDescriptionEntity item : productDescriptionEntityList) {
            result.put(item.getCpuTechnology(),item.getCpuTechnology());

        }
        return result;
    }

    @Override
    public Map<Integer, Integer> getRamCapacityForCheckbox() {
        Map<Integer, Integer> result = new HashMap<>();
        List<ProductDescriptionEntity> productDescriptionEntityList = productDescriptionRepository.findAll();
        for (ProductDescriptionEntity item : productDescriptionEntityList) {
            result.put(item.getRamCapacity(),item.getRamCapacity());
        }
        return result;
    }

    @Override
    public Map<String, String> getHardDriveForCheckbox() {
        Map<String, String> result = new HashMap<>();
        List<ProductDescriptionEntity> productDescriptionEntityList = productDescriptionRepository.findAll();
        for (ProductDescriptionEntity item : productDescriptionEntityList) {
            result.put(item.getHardDriveType(),item.getHardDriveType());
        }
        return result;
    }

    @Override
    public Map<String, String> getScreensizeForCheckbox() {
        Map<String, String> result = new HashMap<>();
        List<ProductDescriptionEntity> productDescriptionEntityList = productDescriptionRepository.findAll();
        for (ProductDescriptionEntity item : productDescriptionEntityList) {
            result.put(item.getScreenSize(),item.getScreenSize());

        }
        return result;
    }


}

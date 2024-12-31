package com.example.ProjectLaptopStore.Response;

import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Admin_ProductDetailResponseDTO {
    List<ProductDetailDTO> productDetail;
    List<SuppliersEntity> listSupplier;
}

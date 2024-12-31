package com.example.ProjectLaptopStore.Convert;

import com.example.ProjectLaptopStore.DTO.ProductsInWarehouse_DTO;
import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductInWareHouseConverter {
    @Autowired
    private ModelMapper modelMapper;
    //chuyển đổi kiểu dữ liệu từ productinwarehouse qua kiểu dto
    public ProductsInWarehouse_DTO toProductInWareHouse(ProductInWarehouseEntity productInWarehouseEntity) {
        ProductsInWarehouse_DTO productsInWarehouseDto = modelMapper.map(productInWarehouseEntity, ProductsInWarehouse_DTO.class);
        ProductsEntity productsEntity = productInWarehouseEntity.getProduct();
        productsInWarehouseDto.setProductId(productsEntity.getProductID());
        productsInWarehouseDto.setProductName(productsEntity.getProductName());
        productsInWarehouseDto.setBrand(productsEntity.getBrand());
        productsInWarehouseDto.setPrice(productsEntity.getPrice());
        productsInWarehouseDto.setModel(productsEntity.getModel());
        productsInWarehouseDto.setReleaseDate(productsEntity.getReleaseDate());
        productsInWarehouseDto.setWarrantyPeriod(productsEntity.getWarrantyPeriod());
        productsInWarehouseDto.setProductBatchCode(productInWarehouseEntity.getProductionBatchCode());
        productsInWarehouseDto.setDimension(productInWarehouseEntity.getDimensions());
        productsInWarehouseDto.setVolume(productInWarehouseEntity.getVolume());
        productsInWarehouseDto.setMinStockLevel(productInWarehouseEntity.getMinStockLevel());
        productsInWarehouseDto.setMaxStockLevel(productInWarehouseEntity.getMaxStockLevel());
        productsInWarehouseDto.setQuantity(productInWarehouseEntity.getQuantity());
        productsInWarehouseDto.setProductInWareHouseId(productInWarehouseEntity.getProductsInWarehouseID());
        return productsInWarehouseDto;
    }
}

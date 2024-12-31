package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Convert.ProductInWareHouseConverter;
import com.example.ProjectLaptopStore.DTO.ProductsInWarehouse_DTO;
import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Repository.ProductRepository;
import com.example.ProjectLaptopStore.Repository.ProductsInWarehouseRepository;
import com.example.ProjectLaptopStore.Service.ProductInWareHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductInWareHouseServiceImpl implements ProductInWareHouseService {
    @Autowired
    private ProductsInWarehouseRepository productsInWarehouseRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ProductInWareHouseConverter productInWareHouseConverter;
    @Override
    public ProductsInWarehouse_DTO getProductInWarehouse(Integer idProduct,Integer warehouseID) {
        ProductInWarehouseEntity productInWarehouseEntity = productsInWarehouseRepository.findByProduct_ProductIDAndWarehouse_warehouseID(idProduct,warehouseID);
        return productInWareHouseConverter.toProductInWareHouse(productInWarehouseEntity);
    }

    @Override
    public void productInWareHouseUpdate(ProductsInWarehouse_DTO productsInWarehouse_Update) {
        ProductInWarehouseEntity productInWarehouseEntity = productsInWarehouseRepository.findById(productsInWarehouse_Update.getProductInWareHouseId()).get();
        ProductsEntity productsEntity = productRepository.findById(productsInWarehouse_Update.getProductId()).get();
        productsInWarehouseRepository.productInWareHouseUpdate(productsInWarehouse_Update,productInWarehouseEntity,productsEntity);
    }
}

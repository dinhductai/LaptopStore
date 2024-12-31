package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.ProductsInWarehouse_DTO;
import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;

import java.util.List;

public interface ProductsInWarehouseRepositoryCustom {
    List<ProductsInWarehouse_DTO> listProductsInWarehouse(Integer warehouseId);
    void productInWareHouseUpdate(ProductsInWarehouse_DTO productsInWarehouse_Update, ProductInWarehouseEntity productInWarehouseEntity, ProductsEntity productsEntity);
}

package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ProductsInWarehouseRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductsInWarehouseRepository extends JpaRepository<ProductInWarehouseEntity,Integer>, ProductsInWarehouseRepositoryCustom {
    //hàm lấy tổng số lượng sản phẩm có trong kho
    @Query(value = "SELECT SUM(Quantity) as sumQuantity FROM ProductsInWarehouse pi " +
            "JOIN Warehouses w ON w.WarehouseID = pi.WarehouseID " +
            "WHERE w.WarehouseID = :warehouseID", nativeQuery = true)
    Integer getTotalQuantity(@Param("warehouseID") Integer warehouseID);

    @Query(value = "SELECT COUNT(ProductsInWarehouse.Quantity) as countQuantity " +
            "FROM ProductsInWarehouse " +
            "join Warehouses on Warehouses.WarehouseID = ProductsInWarehouse.WarehouseID " +
            "WHERE Quantity > MaxStockLevel and  Warehouses.WarehouseID = :warehouseID", nativeQuery = true)
    Integer countProductsMaxStockLevel(@Param("warehouseID") Integer warehouseID);
    @Query(value = "SELECT COUNT(ProductsInWarehouse.Quantity) as countQuantity " +
            "FROM ProductsInWarehouse " +
            "join Warehouses on Warehouses.WarehouseID = ProductsInWarehouse.WarehouseID " +
            "WHERE Quantity < MinStockLevel and  Warehouses.WarehouseID = :warehouseID", nativeQuery = true)
    Integer countProductsMinStockLevel(@Param("warehouseID") Integer warehouseID);
    ProductInWarehouseEntity findByProduct_ProductIDAndWarehouse_warehouseID(Integer productID,Integer warehouseID);
    List<ProductInWarehouseEntity> findAllByWarehouse_warehouseID(Integer warehouseID);
    ProductInWarehouseEntity findByWarehouse_warehouseIDAndProduct_ProductID(Integer warehouseID,Integer productID);

}

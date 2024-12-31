package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.ProductsInWarehouse_DTO;
import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ProductsInWarehouseRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Repository
@Transactional
public class ProductsInWarehouseRepositoryCustomImpl implements ProductsInWarehouseRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<ProductsInWarehouse_DTO> listProductsInWarehouse(Integer warehouseId) {
        String query = "SELECT \n" +
                "p.ProductID AS productId,\n" +
                "p.ProductName AS productName, \n" +
                "p.Brand AS brand,\n" +
                "p.Model AS model,\n" +
                "p.Price as price,\n" +
                "p.ReleaseDate as releaseDate,\n" +
                "p.WarrantyPeriod as warrantyPeriod,\n" +
                "p.ImageURL as imageURL,\n" +
                "pi.ProductionBatchCode as batchCode,\n" +
                "pi.Dimensions as dimension,\n" +
                "pi.Volume as volume,\n" +
                "pi.MinStockLevel AS min,\n" +
                "pi.MaxStockLevel AS max,\n" +
                "pi.Quantity AS quantity,\n" +
                "pi.ProductsInWarehouseID  as productInWareHouseID,\n"+
                "pi.WarehouseID as warehouseID \n"+
                "FROM ProductsInWarehouse pi\n" +
                "JOIN Products p ON pi.ProductID = p.ProductID\n" +
                "WHERE pi.WarehouseID = :idWarehouse"; // Sử dụng tham số idWarehouse trong WHERE clause

        Query nativeQuery = entityManager.createNativeQuery(query);
        nativeQuery.setParameter("idWarehouse", warehouseId);  // Gán giá trị idWarehouse vào câu truy vấn
        List<Object[]> result = nativeQuery.getResultList();
        List<ProductsInWarehouse_DTO> listProductInWareHouse = new ArrayList<>();
        for(Object[] rowOfResult : result) {
            ProductsInWarehouse_DTO item = new ProductsInWarehouse_DTO(
                    (Integer) rowOfResult[0],
                    (String) rowOfResult[1],
                    (String) rowOfResult[2],
                    (String) rowOfResult[3],
                    (Float) rowOfResult[4],
                    (Date) rowOfResult[5],
                    (Integer) rowOfResult[6],
                    (String) rowOfResult[7],
                    (String) rowOfResult[8],
                    (String) rowOfResult[9],
                    (BigDecimal) rowOfResult[10],
                    (Integer) rowOfResult[11],
                    (Integer) rowOfResult[12],
                    (Integer) rowOfResult[13],
                    (Integer) rowOfResult[14],
                    (Integer) rowOfResult[15]
            );
            listProductInWareHouse.add(item);
        }
        return listProductInWareHouse;
    }
    //hàm cập nhật thông tin sản phẩm trong kho
    @Override
    public void productInWareHouseUpdate(ProductsInWarehouse_DTO productsInWarehouse_Update, ProductInWarehouseEntity productInWarehouseEntity, ProductsEntity productsEntity) {
        productsEntity.setProductName(productsInWarehouse_Update.getProductName());
        productsEntity.setBrand(productsInWarehouse_Update.getBrand());
        productsEntity.setModel(productsInWarehouse_Update.getModel());
        productsEntity.setPrice(productsInWarehouse_Update.getPrice());
        productsEntity.setReleaseDate(productsInWarehouse_Update.getReleaseDate());
        productsEntity.setWarrantyPeriod(productsInWarehouse_Update.getWarrantyPeriod());
        productsEntity.setImageURL(productsInWarehouse_Update.getProductImage());
        productInWarehouseEntity.setProduct(productsEntity);
        productInWarehouseEntity.setProductionBatchCode(productsInWarehouse_Update.getProductBatchCode());
        productInWarehouseEntity.setDimensions(productsInWarehouse_Update.getDimension());
        productInWarehouseEntity.setVolume(productsInWarehouse_Update.getVolume());
        productInWarehouseEntity.setMinStockLevel(productsInWarehouse_Update.getMinStockLevel());
        productInWarehouseEntity.setMaxStockLevel(productsInWarehouse_Update.getMaxStockLevel());
        productInWarehouseEntity.setQuantity(productsInWarehouse_Update.getQuantity());
        entityManager.merge(productsEntity);
        entityManager.merge(productInWarehouseEntity);
        entityManager.flush();
    }
}

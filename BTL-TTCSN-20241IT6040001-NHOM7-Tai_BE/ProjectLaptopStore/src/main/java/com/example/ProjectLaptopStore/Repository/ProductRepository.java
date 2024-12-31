package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ProductRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Transactional
//sử dụng spring data jpa, và custom để lấy dữ liệu
public interface ProductRepository extends JpaRepository<ProductsEntity,Integer>, ProductRepositoryCustom {
//    List<ProductsEntity> findByProductNameContainingAndBrandContaining(String productName, String brand);
//    List<ProductsEntity> findByProductNameContainingAndSupplier_SupplierNameContaining(String productName, String supplierName);
    void deleteByProductIDIn(Long[] ids);
    List<ProductsEntity> findTop30ByOrderByReleaseDateDesc();
//    List<ProductsEntity> findByProductIDIn(Long[] ids);
    //hàm ấy các brand tồn tại
    @Query(value = "SELECT MIN(p.ProductID) AS ProductID, p.Brand " +
            "FROM Products p " +
            "JOIN Suppliers s ON s.SupplierID = p.SupplierID " +
            "WHERE s.Status = 'active'\n" +
            "GROUP BY p.Brand ;",nativeQuery = true)
    List<Object[]> getListBrandForCheckBox();
}

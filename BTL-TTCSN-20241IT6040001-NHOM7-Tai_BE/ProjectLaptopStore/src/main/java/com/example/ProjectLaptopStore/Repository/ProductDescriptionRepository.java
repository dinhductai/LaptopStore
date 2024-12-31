package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ProductDescriptionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface ProductDescriptionRepository extends JpaRepository<ProductDescriptionEntity, Long> {
    void deleteByProduct_ProductIDIn(Long[] productID);
    void deleteByProductDescriptionIDIn(Long[] ids);
    @Query(value = "SELECT * FROM ProductDescription pd WHERE pd.ProductID = :productId", nativeQuery = true)
    ProductDescriptionEntity findAllByProductId(@Param("productId") Long productId);
}


package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.PromotionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PromotionRepository extends JpaRepository<PromotionEntity,Integer> {
    List<PromotionEntity> getAllBy();

    @Query(value = "SELECT * FROM Promotions p " +
            "WHERE p.PromotionName LIKE :name", nativeQuery = true)
    List<PromotionEntity> getPromotionByPromotionName(@Param("name") String name);

    @Query(value = "SELECT p.ProductID, \n" +
            "       p.ProductName AS productName, \n" +
            "       p.Brand AS brand, \n" +
            "       MAX(CASE WHEN pm.PromotionID = :promotionID THEN 1 ELSE 0 END) AS hasPromotion\n" +
            "FROM Products p  \n" +
            "LEFT JOIN promotionproduct pp ON p.ProductID = pp.ProductID\n" +
            "LEFT JOIN promotions pm ON pm.PromotionID = pp.PromotionID\n" +
            "GROUP BY p.ProductID", nativeQuery = true)
    List<Object[]> getPromotionProduct(@Param("promotionID")int promotionID);

    @Query(value = "SELECT p.ProductID, \n" +
            "       p.ProductName AS productName, \n" +
            "       p.Brand AS brand, \n" +
            "       MAX(CASE WHEN pm.PromotionID = :promotionID THEN 1 ELSE 0 END) AS hasPromotion\n" +
            "FROM Products p  \n" +
            "LEFT JOIN promotionproduct pp ON p.ProductID = pp.ProductID\n" +
            "LEFT JOIN promotions pm ON pm.PromotionID = pp.PromotionID\n" +
            "WHERE p.ProductName like CONCAT('%', :productName, '%') \n "+
            "GROUP BY p.ProductID", nativeQuery = true)
    List<Object[]> searchProductByName(@Param("promotionID")int promotionID,
                                                               @Param("productName")String productName);

    @Query(value = "SELECT * FROM promotions p WHERE p.PromotionID = :promotionID", nativeQuery = true)
    PromotionEntity getPromotionByID(@Param("promotionID")int promotionID);


    @Query(value = "SELECT p.PromotionID, p.PromotionName, p.DiscountPercentage, p.PromotionDetails" +
            " FROM promotions p " +
            "JOIN promotionproduct pp ON pp.PromotionID = p.PromotionID " +
            "JOIN products pd ON pd.ProductID = pp.ProductID " +
            "WHERE pd.ProductID =  :productID",nativeQuery = true)
    List<PromotionEntity> getPromotionByProductID(@Param("productID")int productID);
}

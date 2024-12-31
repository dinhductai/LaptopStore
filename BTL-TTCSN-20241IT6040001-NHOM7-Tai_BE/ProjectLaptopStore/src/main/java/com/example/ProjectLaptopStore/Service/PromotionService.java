package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.Promotion_getPromotionProductDTO;
import com.example.ProjectLaptopStore.DTO.Promotions_DisplayPromotionsDTO;

import java.util.List;

public interface PromotionService {
    // Lay danh sach promotion
    List<Promotions_DisplayPromotionsDTO> getPromotions();

    // tim kiem khuyen mai
    List<Promotions_DisplayPromotionsDTO> searchPromotion(String promotionName);


    List<Promotion_getPromotionProductDTO> displayPromotionProduct(int id);

    //them khuyen mai
    void addPromotionProduct(int productID,int promotionID);

    //xoa khuyen mai
    void deletePromotionProduct(int productID,int promotionID);

    // cap nhat khuyen mai
    void updatePromotion(Promotions_DisplayPromotionsDTO dto);

    // tim kiem san pham
    List<Promotion_getPromotionProductDTO> searchProductByName(int productID, String productName);

    // lay khuyen mai theo ID
    Promotions_DisplayPromotionsDTO getPromotionByID(int id);

    // lay cac khuyen mai cua san pham
    List<Promotions_DisplayPromotionsDTO> getPromotionByProductID(int productID);
}

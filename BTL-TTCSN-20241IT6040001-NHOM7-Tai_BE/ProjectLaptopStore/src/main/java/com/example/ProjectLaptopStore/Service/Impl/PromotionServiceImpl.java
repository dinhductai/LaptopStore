package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.DTO.Promotion_getPromotionProductDTO;
import com.example.ProjectLaptopStore.DTO.Promotions_DisplayPromotionsDTO;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Entity.PromotionEntity;
import com.example.ProjectLaptopStore.Entity.PromotionProductEntity;
import com.example.ProjectLaptopStore.Exception.PromotionNotFoundException;
import com.example.ProjectLaptopStore.Repository.ProductRepository;
import com.example.ProjectLaptopStore.Repository.PromotionProductRepository;
import com.example.ProjectLaptopStore.Repository.PromotionRepository;
import com.example.ProjectLaptopStore.Service.PromotionService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service
public class PromotionServiceImpl implements PromotionService {
    @Autowired
    PromotionRepository promotionRepository;

    @PersistenceContext
    EntityManager entityManager;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    PromotionProductRepository promotionProductRepository;

    @Override
    public List<Promotions_DisplayPromotionsDTO> getPromotions() {
        List<PromotionEntity> promotionEntities = promotionRepository.findAll();
        List<Promotions_DisplayPromotionsDTO> promotions = new ArrayList<>();
        for (PromotionEntity promotionEntity : promotionEntities) {
            Promotions_DisplayPromotionsDTO dto = modelMapper.map(promotionEntity, Promotions_DisplayPromotionsDTO.class);
            promotions.add(dto);
        }
        return promotions;
    }

    @Override
    public List<Promotions_DisplayPromotionsDTO> searchPromotion(String promotionName) {
        List<PromotionEntity> promotionEntity = promotionRepository.getPromotionByPromotionName(promotionName);
        List<Promotions_DisplayPromotionsDTO> promotion = new ArrayList<>();
        if (promotionEntity != null) {
            for(PromotionEntity pe : promotionEntity){
                Promotions_DisplayPromotionsDTO dto = modelMapper.map(pe, Promotions_DisplayPromotionsDTO.class);
                promotion.add(dto);
            }
        }
        else try {
            throw new Exception();
        } catch (Exception e) {
            throw new PromotionNotFoundException("Không tìm thấy khuyến mãi");
        }
        return promotion;
    }

    @Override
    public List<Promotion_getPromotionProductDTO> displayPromotionProduct(int id) {
        List<Object[]> rs = promotionRepository.getPromotionProduct(id);
        List<Promotion_getPromotionProductDTO> promotionProduct = new ArrayList<>();
        for (Object[] o : rs){
            Promotion_getPromotionProductDTO pp = Promotion_getPromotionProductDTO.builder()
                    .productID((int) o[0])
                    .productName((String) o[1])
                    .brand((String) o[2])
                    .hasPromotion((Long) o[3])
                    .build();
            promotionProduct.add(pp);
        }
        return promotionProduct;
    }

    @Override
    public void addPromotionProduct(int productID, int promotionID) {
        ProductsEntity product = productRepository.findById(productID)
                .orElseThrow(() -> new RuntimeException("Product not found with ID: " + productID));

        // Tìm Promotion theo ID
        PromotionEntity promotion = promotionRepository.findById(promotionID)
                .orElseThrow(() -> new RuntimeException("Promotion not found with ID: " + promotionID));
        PromotionProductEntity promotionProduct = PromotionProductEntity.builder()
                .product(product)
                .promotion(promotion)
                .build();
        // Lưu Product (tự động lưu vào PromotionProduct)
        promotionProductRepository.save(promotionProduct);
    }

    @Transactional
    @Override
    public void deletePromotionProduct(int productID, int promotionID) {
        ProductsEntity product = productRepository.findById(productID)
                .orElseThrow(() -> new RuntimeException("Product not found with ID: " + productID));

        // Tìm Promotion theo ID
        PromotionEntity promotion = promotionRepository.findById(promotionID)
                .orElseThrow(() -> new RuntimeException("Promotion not found with ID: " + promotionID));
        PromotionProductEntity pp = promotionProductRepository.getPromotionProductByProductIDAndPromotionID(productID,promotionID);
        if (pp != null) {
            // Xóa bản ghi trung gian PromotionProductEntity
            promotionProductRepository.delete(pp);
        } else {
            throw new RuntimeException("PromotionProduct not found");
        }
    }

    @Override
    public void updatePromotion(Promotions_DisplayPromotionsDTO dto) {
        PromotionEntity promotion = promotionRepository.findById(dto.getPromotionID()).orElse(null);
        if(promotion == null){
            promotion = new PromotionEntity();
            promotion.setPromotionName(dto.getPromotionName());
            promotion.setDiscountPercentage(dto.getDiscountPercentage());
            promotion.setPromotionDetails(dto.getPromotionDetails());
            entityManager.persist(promotion);
        }
        else{
            promotion.setPromotionName(dto.getPromotionName());
            promotion.setDiscountPercentage(dto.getDiscountPercentage());
            promotion.setPromotionDetails(dto.getPromotionDetails());
            entityManager.merge(promotion);
        }
        entityManager.flush();
    }

    @Override
    public List<Promotion_getPromotionProductDTO> searchProductByName(int productID, String productName) {
        List<Object[]> product = promotionRepository.searchProductByName(productID,productName);
        List<Promotion_getPromotionProductDTO> rs = new ArrayList<>();
        for(Object[] o:product){
            Promotion_getPromotionProductDTO pp = Promotion_getPromotionProductDTO.builder()
                    .productID((int) o[0])
                    .productName((String) o[1])
                    .brand((String) o[2])
                    .hasPromotion((Long) o[3])
                    .build();
            rs.add(pp);
        }
        return rs;
    }

    @Override
    public Promotions_DisplayPromotionsDTO getPromotionByID(int id) {
        PromotionEntity o = promotionRepository.getPromotionByID(id);
        Promotions_DisplayPromotionsDTO rs = new Promotions_DisplayPromotionsDTO();
        if (o == null) throw  new PromotionNotFoundException("Khong ton tai khuyen mai");
        else{
            rs = modelMapper.map(o,Promotions_DisplayPromotionsDTO.class);
        }
        return rs;
    }

    @Override
    public List<Promotions_DisplayPromotionsDTO> getPromotionByProductID(int productID) {
        List<PromotionEntity> entities = promotionRepository.getPromotionByProductID(productID);
        List<Promotions_DisplayPromotionsDTO> rs = new ArrayList<>();
        for(PromotionEntity o:entities){
            Promotions_DisplayPromotionsDTO dto = modelMapper.map(o,Promotions_DisplayPromotionsDTO.class);
            rs.add(dto);
        }
        return rs;
    }
}

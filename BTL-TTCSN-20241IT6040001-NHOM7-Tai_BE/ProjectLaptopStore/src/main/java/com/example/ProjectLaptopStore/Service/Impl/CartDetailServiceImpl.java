package com.example.ProjectLaptopStore.Service.Impl;


import com.example.ProjectLaptopStore.DTO.CartDetailDTO;
import com.example.ProjectLaptopStore.DTO.Promotions_DisplayPromotionsDTO;
import com.example.ProjectLaptopStore.Entity.CartDetailsEntity;
import com.example.ProjectLaptopStore.Entity.CartEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Entity.PromotionEntity;
import com.example.ProjectLaptopStore.Repository.CartDetailRepository;
import com.example.ProjectLaptopStore.Repository.CartRepository;
import com.example.ProjectLaptopStore.Repository.ProductRepository;
import com.example.ProjectLaptopStore.Repository.PromotionRepository;
import com.example.ProjectLaptopStore.Service.CartDetailService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class CartDetailServiceImpl implements CartDetailService {

    @Autowired
    CartDetailRepository cartDetailRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CartRepository cartRepository;
    @Autowired
    private PromotionRepository promotionRepository;
    @Autowired
    private ModelMapper modelMapper;

    // lay ra danh sach cartdetail ra gio hang
    @Override
    public List<CartDetailDTO> getAllCartDetails(int cartID) {
        List<Object[]> objects = cartDetailRepository.getListCartDetail(cartID);
        List<CartDetailDTO> rs = new ArrayList<>();
        for (Object[] o : objects) {
            List<PromotionEntity> promotion = promotionRepository.getPromotionByProductID((int) o[1]);
            List<Promotions_DisplayPromotionsDTO> pros = new ArrayList<>();
            for(PromotionEntity e : promotion){
                Promotions_DisplayPromotionsDTO pro = modelMapper.map(e, Promotions_DisplayPromotionsDTO.class);
                pros.add(pro);
            }
            CartDetailDTO dto = CartDetailDTO.builder()
                    .cartDetailID((int)o[0])
                    .productId((int) o[1])
                    .productImage((String) o[2])
                    .productName((String) o[3])
                    .price((BigDecimal) o[4])
                    .quantity((int) o[5])
                    .lineTotal((BigDecimal) o[6])
                    .promotion(pros)
                    .build();
            rs.add(dto);
        }
        return rs;
    }

    // xoa cartdetail
    @Override
    public void deleteCartDetail(int cartDetailID) {
        CartDetailsEntity cartDetailsEntity = cartDetailRepository.findById(cartDetailID).orElse(null);
        if (cartDetailsEntity != null) {
            cartDetailRepository.delete(cartDetailsEntity);
        }
        else{
            try {
                throw new Exception("cart detail not found");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    // cap nhat so luong va so tien trong DB
    @Override
    public void additionQuantity(int cartDetailID) {
        CartDetailsEntity cartDetailsEntity = cartDetailRepository.findById(cartDetailID).orElse(null);
        if (cartDetailsEntity != null) {
            int quantity = cartDetailsEntity.getQuantity() + 1;
            cartDetailsEntity.setQuantity(quantity);
//            BigDecimal q = new BigDecimal(quantity);
//            cartDetailsEntity.setLineTotal(q.multiply(cartDetailsEntity.getPrice()));
            cartDetailRepository.save(cartDetailsEntity);
        }
        else throw new RuntimeException("cart detail not found");
    }

    // cap nhat so luong va so tien trong DB
    @Override
    public void subtractionQuantity(int cartDetailID) {
        CartDetailsEntity cartDetailsEntity = cartDetailRepository.findById(cartDetailID).orElse(null);
        if (cartDetailsEntity != null) {
            int quantity = cartDetailsEntity.getQuantity() - 1;
            cartDetailsEntity.setQuantity(quantity);
//            BigDecimal q = new BigDecimal(quantity);
//            cartDetailsEntity.setLineTotal(q.multiply(cartDetailsEntity.getPrice()));
            cartDetailRepository.save(cartDetailsEntity);
        }
        else throw new RuntimeException("cart detail not found");
    }

    @Override
    public void addProductToCart(int customerID, int productID) {
        CartEntity cart = cartRepository.getCartByCustomerId(customerID);
        CartDetailsEntity cartDetailsEntity = new CartDetailsEntity();
        ProductsEntity productsEntity = productRepository.findById(productID).get();
        if (cart != null) {
            //kiem tra xem co cung 1 san pham khong
            for(CartDetailsEntity cartDetail : cart.getCartDetails()) {
                if(cartDetail.getProduct().getProductID() == productID) {
                    cartDetail.setQuantity(cartDetail.getQuantity() + 1 );
                    //cap nhat
                    cartDetailRepository.save(cartDetail);
                    return;
                }
            }
            //tao cartdetail moi
            cartDetailsEntity.setCart(cart);
            cartDetailsEntity.setProduct(productsEntity);
            cartDetailsEntity.setQuantity(1);
            BigDecimal priceBigDecimal = new BigDecimal(Float.toString(productsEntity.getPrice()));
            cartDetailsEntity.setPrice(priceBigDecimal);
            cartDetailRepository.save(cartDetailsEntity);
        }
        else throw new RuntimeException("can not add product to cart");
    }
}

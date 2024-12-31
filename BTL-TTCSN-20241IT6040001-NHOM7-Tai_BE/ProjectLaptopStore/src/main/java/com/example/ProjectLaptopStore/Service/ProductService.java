package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Response.Admin_ProductDetailResponseDTO;
import com.example.ProjectLaptopStore.Response.Admin_ProductResponseDTO;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Map;

public interface ProductService {
    List<ProductDetailDTO> findTopPurchasedProductAtService();
    void createNewProduct(ProductDetailDTO productCreate);
    void updateProduct(ProductDetailDTO productUpdate);
    void deleteProduct(Long[] ids);
    List<ProductDetailDTO> listSearchProductByKey(String key);
    List<ProductDetailDTO> listProductForHomePage();
    List<ProductDetailDTO> listProductDetail();
    Admin_ProductResponseDTO adminProduct();
    List<ProductDetailDTO> getProductById(List<Integer>  ids);
    Admin_ProductDetailResponseDTO adminProductDetail(List<Integer>  idProducts);
    Map<Integer,String> getBrandForCheckbox();
    List<ProductDetailDTO> getProductByCheckbox(MultiValueMap<String,Object> params);
    List<Product_GetReceiptDTO> findAllProducts();
}

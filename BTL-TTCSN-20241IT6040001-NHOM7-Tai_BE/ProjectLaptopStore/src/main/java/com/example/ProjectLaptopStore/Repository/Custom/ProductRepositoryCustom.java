package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.DTO.Product_FindTopPurchasedProductsDTO;
import com.example.ProjectLaptopStore.DTO.Product_GetReceiptDTO;
import com.example.ProjectLaptopStore.DTO.Product_ProductSearchCheckBoxDTO;
import com.example.ProjectLaptopStore.Entity.ContentEntity;
import com.example.ProjectLaptopStore.Entity.ProductDescriptionEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;

import java.util.List;

public interface ProductRepositoryCustom {
    List<ProductDetailDTO> findAllProductsWithTotalQuantityOrdered();
    void createProduct(ProductDetailDTO productNew, ProductsEntity productsEntity, ProductDescriptionEntity productDescriptionEntity, ContentEntity contentEntity);
    void updateProduct(ProductDetailDTO updateProductDTO, ProductsEntity productsEntityById,ProductDescriptionEntity productDescriptionEntity,ContentEntity contentEntity);
    List<ProductDetailDTO> findAllProductsByKey(String key);
    List<ProductDetailDTO> listProductDetail();
    List<ProductDetailDTO> getOneProductDetail(List<Integer>  id);
    List<ProductDetailDTO> getProductDetailByCheckbox(Product_ProductSearchCheckBoxDTO productSearchCheckBoxDTO);
//    Page<Product_DisplayForHomePageDTO> findAllProductsByPage(int pageNo, int pageSize);
    List<Product_GetReceiptDTO> listProductForReceipt();
}

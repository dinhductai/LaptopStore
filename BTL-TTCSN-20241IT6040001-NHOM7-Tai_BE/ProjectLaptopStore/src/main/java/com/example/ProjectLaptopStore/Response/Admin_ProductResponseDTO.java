package com.example.ProjectLaptopStore.Response;

import com.example.ProjectLaptopStore.DTO.OrderDetail_CountQuantityProductPerMonthDTO;
import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.DTO.Product_FindTopPurchasedProductsDTO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Admin_ProductResponseDTO {
    List<OrderDetail_CountQuantityProductPerMonthDTO> quantityProductForChart;
    List<ProductDetailDTO> listTopProductSell;
    List<ProductDetailDTO> listProductDetail;
}
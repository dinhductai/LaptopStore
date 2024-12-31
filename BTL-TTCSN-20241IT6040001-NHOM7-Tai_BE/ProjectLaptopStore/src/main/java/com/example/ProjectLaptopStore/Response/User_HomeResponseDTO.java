package com.example.ProjectLaptopStore.Response;

import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.DTO.Product_FindTopPurchasedProductsDTO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;
@Getter
@Setter
public class User_HomeResponseDTO {
    private List<ProductDetailDTO> findProductByKeyword;
    private List<ProductDetailDTO> getProductForHomePage;
    private List<ProductDetailDTO> getOutstandingProducts;
    private Map<Integer,String> getSuppliersForCheckboxAndBtn;
    private Map<String,String> getPriceProductForCheckbox;
    private Map<String,String> getCPUForCheckbox;
    private Map<Integer,Integer> getRamForCheckbox;
    private Map<String,String> getHardDriveForCheckbox;
    private Map<String,String> getCustomerDemandForCheckBox;
    private Map<String,String> getScreenSizeForCheckbox;

    public User_HomeResponseDTO() {
    }

}

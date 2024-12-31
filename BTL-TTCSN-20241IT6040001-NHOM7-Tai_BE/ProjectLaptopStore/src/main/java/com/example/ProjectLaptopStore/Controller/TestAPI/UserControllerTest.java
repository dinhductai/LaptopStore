package com.example.ProjectLaptopStore.Controller.TestAPI;

import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.Entity.Enum.ProDescription_FindByUserDemand_Enum;
import com.example.ProjectLaptopStore.Entity.Enum.Product_FindProductsByPriceRange_Enum;
import com.example.ProjectLaptopStore.Service.ProductDescriptionService;
import com.example.ProjectLaptopStore.Service.ProductService;
import com.example.ProjectLaptopStore.Service.SuppliersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/test")
public class UserControllerTest {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductDescriptionService productDescriptionService;

    @Autowired
    private SuppliersService suppliersService;





    //=========================================== API test =====================================================

//    @GetMapping(value = "/product/productdescription/")
//    public List<ProductDescriptionDTO> ProductDescription(){
//        List<ProductDescriptionDTO> result = productDescriptionService.finAllProductDescription();
//        return result;
//    }
//    @GetMapping(value = "/may-tinh-xach-tay/{productID}")
//    public ProductDescriptionDTO productDescription(@PathVariable Long productID){
//        ProductDescriptionDTO result = productDescriptionService.finProductDescriptionById(productID);
//        return result;
//    }
//

//    //API người dùng tìm kiếm danh sách sản phẩm bằng 1 từ khóa bất kì
//    @GetMapping(value = "/user/searchproduct/")
//    public List<Product_DisplayForHomePageDTO> listProductSearchByKey(@RequestParam(value = "keyword") Object keyword) {
//        List<Product_DisplayForHomePageDTO> result = productService.listSearchProductByKey(keyword);
//        return result;
//
//    }
//
//    @GetMapping(value = "/user/hometest/")
//    public List<Product_DisplayForHomePageDTO> listProductForHomePage() {
//        List<Product_DisplayForHomePageDTO> result = productService.listProductForHomePage();
//        return result;
//    }

    //API lấy nhà cung cấp cho checkbox(cả checkbox và btn)
    @GetMapping(value = "/user/checkboxsuppliers/")
    public Map<Integer,String> getSuppliersCheckbox(){
        Map<Integer,String> result = productService.getBrandForCheckbox();
        return result;
    }

    //API hiện mức giá cho checkbox
    @GetMapping(value = "/user/checkboxprice/")
    public Map<String,String> getPricesCheckbox(){
        Map<String,String> result = Product_FindProductsByPriceRange_Enum.getPriceRanges();
        return result;
    }

    //API lấy công nghệ CPU cho checkbox
    @GetMapping(value = "/user/checkboxcpu/")
    public Map<String,String> getCpuTechnologyCheckbox(){
        Map<String,String> result = productDescriptionService.getCPUTechnologyForCheckbox();
        return result;
    }
    //API lấy dung lượng Ram cho checkbox
    @GetMapping(value = "/user/checkboxram/")
    public Map<Integer,Integer> getRamCapacityCheckbox(){
        Map<Integer,Integer> result = productDescriptionService.getRamCapacityForCheckbox();
        return result;
    }
    //API lấy loại ổ cứng cho checkbox
    @GetMapping(value = "/user/checkboxharddrive/")
    public Map<String,String> getHardDriveCheckbox(){
        Map<String,String> result = productDescriptionService.getHardDriveForCheckbox();
        return result;
    }
    //API lấy kích thước màn hình cho checkbox
    @GetMapping(value = "/user/checkboxscreensize/")
    public Map<String,String> getScreenSizeForCheckbox(){
        Map<String,String> result = productDescriptionService.getScreensizeForCheckbox();
        return result;
    }

    //API lấy nhu cầu của khách hàng(cả checkbox và btn)
    @GetMapping(value = "/user/checkboxuserdemand/")
    public Map<String,String> getUserDemandForCheckbox(){
        Map<String,String> result = ProDescription_FindByUserDemand_Enum.typeUserDemand();
        return result;
    }

    //API lấy số khách mới mỗi tháng cho biểu đồ
    @GetMapping(value = "/user/findbykey/{key}")
    public List<ProductDetailDTO> searchProductByKey(@PathVariable(name = "key") String key ){
        List<ProductDetailDTO> result = productService.listSearchProductByKey(key);
        return result;
    }
}

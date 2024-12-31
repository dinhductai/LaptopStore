package com.example.ProjectLaptopStore.Controller;


import com.example.ProjectLaptopStore.Response.User_HomeResponseDTO;
import com.example.ProjectLaptopStore.Service.ProductDescriptionService;
import com.example.ProjectLaptopStore.Service.ProductService;
import com.example.ProjectLaptopStore.Service.UserService;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.Enum.ProDescription_FindByUserDemand_Enum;
import com.example.ProjectLaptopStore.Entity.Enum.Product_FindProductsByPriceRange_Enum;
import com.example.ProjectLaptopStore.Entity.ShippingAddressEntity;
import com.example.ProjectLaptopStore.Repository.ShippingAddressesRepository;
import com.example.ProjectLaptopStore.Response.User_HomeResponseDTO;
import com.example.ProjectLaptopStore.Service.*;
import com.example.ProjectLaptopStore.Util.JwtTokenUtil;
import com.nimbusds.jose.JOSEException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

import lombok.RequiredArgsConstructor;
import lombok.experimental.NonFinal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.relational.core.sql.In;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
//@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RestController
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private EmployeesService employeesService;
    @Autowired
    private ProductDescriptionService productDescriptionService;
    @Autowired
    private SuppliersService suppliersService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProductService productService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderDetailService orderDetailService;
    @Autowired
    private ShippingAddressesService shippingAddressesService;
    @Autowired
    JwtTokenUtil jwtTokenUtil;
    @Autowired
    CartDetailService cartDetailService;

    @Autowired
    private PromotionService promotionService;
    //API lấy thông tin cho homepage
    @GetMapping(value = "/user/home")
    public User_HomeResponseDTO getHomePage(){
        User_HomeResponseDTO result = userService.userHomePage();
        return result;
    }
    //API tìm kiếm bằng từ khóa,hãng,nhu cầu
    @GetMapping(value = "/user/search")
    public List<ProductDetailDTO> getProductsSearch(@RequestParam String keyword){
        return productService.listSearchProductByKey(keyword);
    }
    //API tìm bằng checkbox
    @GetMapping(value = "/user/home/")
    public List<ProductDetailDTO> listProductSearchCheckbox(@RequestParam MultiValueMap<String, Object> searchMap){
        return productService.getProductByCheckbox(searchMap);
    }
    //API lấy thông tin sản phẩm chi tiết
    @GetMapping(value = "/user/product")
    public List<ProductDetailDTO> getProductDetail(@RequestParam List<Integer>  id){
        return productService.getProductById(id);
    }
    //API lấy thông tin sản phẩm  để so sánh
    @GetMapping(value = "/user/compare")
    public List<ProductDetailDTO> getProductDetailCompare(@RequestParam List<Integer>  ids){
        return productService.getProductById(ids);
    }

    // hien thi thong tin ca nhan
    @GetMapping(value = "/user/myInfor")
    public User_DTO getMyInfor(@RequestParam(value = "id")int id ){
        User_DTO dto = userService.UserInfor(id);
        return  dto;
    }

    // API cap nhat thong tin user
    @PostMapping(value = "/user/update-infor")
    public ResponseEntity<?> updateUser(@RequestBody(required = true) User_UpdateUserDTO dto){
        userService.updateUser(dto);
        return ResponseEntity.ok("User updated successfully");
    }
    //API lấy thông tin cho danh sách đơn hàng
    @GetMapping(value = "/user/my-orders")
    public List<Order_OrderDetailDTO> getOrder(@RequestParam(name = "customerID")int customerID){
        List<Order_OrderDetailDTO> rs = orderService.ListOrderDetail(customerID);
        return rs;
    }
    //API lấy thông tin đơn hàng dựa vào trạng thái
    @GetMapping(value = "/user/my-orders/")
    public List<Order_OrderDetailDTO> getOrderByStatus(@RequestParam(name = "customerID")int customerID,
                                               @RequestParam(name = "status")String status){
        List<Order_OrderDetailDTO> rs = orderService.ListOrderDetailByStatus(customerID,status);
        return rs;
    }

    // API lay danh sach Shipping address
    @GetMapping(value = "/user/shipping-address")
    public List<ShippingAddressesDTO> getShippingAddresses(@RequestParam(value = "customerID")int customerID){
        List<ShippingAddressesDTO> rs = shippingAddressesService.getAllShippingAddresses(customerID);
        return rs;
    }

    // API them dia chi nhan hang
    @PostMapping(value = "/user/add-shipping-address/{customerID}")
    public ResponseEntity<?> addShippingAddress(@RequestBody ShippingAddressesDTO dto,@PathVariable(value = "customerID")int customerID){
        shippingAddressesService.addShippingAddresses(dto,customerID);
        return ResponseEntity.ok("Shipping address added successfully");
    }

    // API cap nhat thong tin dia chi nhan hang
    @PutMapping(value = "/user/update-shipping-address")
    public ResponseEntity<?> updateShippingAddress(@RequestBody ShippingAddressesDTO dto){
        shippingAddressesService.updateShippingAddresses(dto);
        return ResponseEntity.ok("Shipping address updated successfully");
    }

    // API xoa dia chi nhan hang
    @DeleteMapping(value = "/user/remove-shipping-address")
    public ResponseEntity<?> removeShippingAddress(@RequestParam(value = "addressID")int addressID){
        shippingAddressesService.deleteShippingAddresses(addressID);
        return ResponseEntity.ok("Shipping address removed successfully");
    }


    // API lay ra cartdetail
    @GetMapping(value = "/user/mycart/cart-detail")
    public List<CartDetailDTO> getCartDetail(@RequestParam(name = "cartID")int cartID){
        List<CartDetailDTO> rs = cartDetailService.getAllCartDetails(cartID);
        return rs;
    }

    // API xoa sp trong cart
    @DeleteMapping(value = "/user/mycart/remove-cartdetail")
    public ResponseEntity<?> deleteCartDetail(@RequestParam("cartDetailID")int cartDetailID){
        cartDetailService.deleteCartDetail(cartDetailID);
        return ResponseEntity.ok("Cart detail deleted successfully");
    }

    //API tao don hang moi
    @PutMapping(value = "/user/mycart/create-order")
    public ResponseEntity<?> createOrder(@RequestBody OrderDTO dto){
        orderService.createOrder(dto);
        return ResponseEntity.ok("Order created successfully");
    }

    //API thêm sản phẩm vào giỏ hàng
    @PostMapping(value = "/user/product-add")
    public ResponseEntity<?> addProduct(@RequestBody Cart_AddProductToCartDTO dto){
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
//        int customerID = userDetails.getId_Customer();
        cartDetailService.addProductToCart(dto.getCustomerID(),dto.getProductID());
        return ResponseEntity.ok("Product added successfully");
    }

    // API lay khuyen mai len cho san pham
    @GetMapping(value = "/user/promotion-product/{id}")
    public ResponseEntity<?> getPromotionProduct(@PathVariable(value = "id")int id){
        List<Promotions_DisplayPromotionsDTO> rs = promotionService.getPromotionByProductID(id);
        return ResponseEntity.ok(rs);
    }

    //API huy don hang
    @PutMapping(value = "/user/cancel-order/{orderID}")
    ResponseEntity<?> cacelOrder(@PathVariable(value = "orderID")int orderID){
        orderService.cancelOrder(orderID);
        return ResponseEntity.ok("Order canceled successfully");
    }
    //API lấy tất cả nhân viên
    @GetMapping(value = "/user/employee")
    public List<EmployeeDTO> getListEmployee(){
        return employeesService.getAllEmployee();
    }
}

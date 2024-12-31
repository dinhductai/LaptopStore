package com.example.ProjectLaptopStore.Controller.TestAPI;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;
import com.example.ProjectLaptopStore.Service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/test")
public class AdminControllerTest {
    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private SuppliersService suppliersService;

    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private WareHouseService wareHouseService;

    //API lấy số sản phẩm bán trong tháng
    @GetMapping(value = "/admin/sellproduct/")
    public Integer getQuantityProductCurrentMonth(){
        Integer result = orderDetailService.getQuantityProductCurrentMonthAtService();
        return result;
    }
    //API lấy tổng tiền trong tháng hiện tại
    @GetMapping(value = "/admin/totalmount/")
    public BigDecimal TotalAmountInMount(){
        BigDecimal res = orderService.getTotalAmountInMountAtService();
        return res;
    }


    //API lấy tổng khách hàng trong tháng hiện tại
    @GetMapping(value = "/admin/totalcustomer/")
    public Integer TotalCustomerInMonth(){
        Integer result = orderService.TotalCustomerInMonthAtService();
        return result;
    }

    //API lấy số khách hàng mới trong thời điểm nhất định
//    @GetMapping(value = "/admin/countcustomer/")
//    public Integer CountNewCustomer(@RequestParam Map<String,Object> params){
//        Integer result = customerService.countCustomers(params);
//        return result;
//    }

    //API lấy số khách mới trong tháng
    @GetMapping(value = "/admin/newcustomer/")
    public Integer NewCustomerInMonth(){
        Integer result = customerService.getNewCustomerCurrentMonth();
        return result;
    }


    //API lấy số khách mới mỗi tháng cho biểu đồ
    @GetMapping(value = "/admin/countcustomer/")
    public List<Customer_CountNewCustomerPerMonthDTO> CountCustomerInMonth(){
        List<Customer_CountNewCustomerPerMonthDTO> result = customerService.listCountNewCustomerPerMonth();
        return result;
    }


    //API lấy số sp bán được trong các tháng cho biểu đồ
    @GetMapping(value = "/admin/quantitysell/")
    public List<OrderDetail_CountQuantityProductPerMonthDTO> QuantitySellProduct(){
        List<OrderDetail_CountQuantityProductPerMonthDTO> result = orderDetailService.listCountQuantityProductPerMonth();
        return result;
    }

    //API lấy doanh thu trong các tháng
    @GetMapping(value = "/admin/totalamount/")
    public List<Order_CountTotalAmountDTO> TotalAmount(){
        List<Order_CountTotalAmountDTO> result = orderService.listCountTotalAmountAtService();
        return result;
    }

    //API lấy top sản phẩm
    @GetMapping(value = "/admin/topproduct/")
    public List<ProductDetailDTO> TopProduct(){
        List<ProductDetailDTO> result = productService.findTopPurchasedProductAtService();
        return result;
    }

    //API lấy top nhà cung cấp
    @GetMapping(value = "/admin/topsuppliers/")
    public List<Supplier_FindTopSupplierDTO> TopSuppliers(){
        List<Supplier_FindTopSupplierDTO> result = suppliersService.listTopSupplier();
        return result;
    }


    //API tạo sản phẩm
    @PostMapping("/admin/createproduct/")
    public void createProduct(@RequestBody ProductDetailDTO createProductDTO){
        productService.createNewProduct(createProductDTO);
    }

    //API tạo khách hàng
    @PostMapping("/admin/createcustomer/")
    public void createCustomer(@RequestBody CustomerDTO customerNew){
        customerService.createCustomerAtService(customerNew);
    }
    //API tạo nhà cung cấp
    @PostMapping("/admin/createsupplier/")
    public void createSupplier(@RequestBody SupplierDTO supplierNew){
        suppliersService.createSupplier(supplierNew);
    }


    //API cập nhật  sản phẩm (trả về cho repo product chứa id)
    @PutMapping("/admin/updateproduct/")
    public void updateProduct(@RequestBody ProductDetailDTO updateProductDTO){
        productService.updateProduct(updateProductDTO);
    }

    //API cập nhật người dùng
    @PutMapping("/admin/updatecustomer/")
    public void updateCustomer(@RequestBody CustomerDTO customerUpdateDTO){
        customerService.updateCustomerAtService(customerUpdateDTO);
    }
    //API cập nhật nhà cung cấp
    @PutMapping("/admin/updatesupplier/")
    public void updateSupplier(@RequestBody SupplierDTO supplierUpdateDTO){
        suppliersService.updateSupplier(supplierUpdateDTO);
    }


    // cách chạy test api xóa trên postman là đẩy id sản phẩm về thanh param (dạng check box)
    // http://localhost:8080/admin/deleteproduct/5,6,2
    //API xóa sản phẩm
    @DeleteMapping("/admin/deleteproduct/{ids}")
    public void deleteProduct(@PathVariable Long[] ids){
        productService.deleteProduct(ids);
    }
    //API xóa khách hàng ( thay đổi status)
    @DeleteMapping("/admin/deletecustomer/{ids}")
    public void deleteCustomer(@PathVariable Long[] ids){
        customerService.deleteCustomerAtService(ids);
    }
    //API xóa nhà cung cấp
    @DeleteMapping("/admin/deletesuppliers/{ids}")
    public void deleteSupplier(@PathVariable Long[] ids){
        suppliersService.deleteSupplier(ids);
    }

//    //API lấy danh sách top người tiêu dùng trong tháng
//    @GetMapping("/admin/topcustomer/")
//    public List<Customer_FindTopCustomerInMonthDTO> TopCustomerInMonth(){
//        List<Customer_FindTopCustomerInMonthDTO> result = customerService.listTopCustomerInMonth();
//        return result;
//    }

    //API lấy danh sách bill
    @GetMapping(value = "/admin/listbill/")
    public List<Order_ListBillDTO> ListBill(){
        List<Order_ListBillDTO> result = orderService.ListBillAtService();
        return result;
    }

    //API lấy danh sách invoice chi tiết
    @GetMapping(value = "/admin/list_invoicedetail/")
    public List<Order_InvoiceDetailDTO> ListInvoice(){
        List<Order_InvoiceDetailDTO> result = orderService.ListInvoiceDetailAtService();
        return result;
    }
    //api lấy tổng tiền thanh toán online
    @GetMapping(value = "/admin/payonline/")
    public BigDecimal TotalAmountPayOnline(){
        BigDecimal result = orderService.getTotalAmountOnline();
        return result;
    }
    //api lấy tổng tiền thanh toán offline
    @GetMapping(value = "/admin/payoffline/")
    public BigDecimal TotalAmountPayOffline(){
        BigDecimal result = orderService.getTotalAmountOffline();
        return result;
    }

    @GetMapping(value = "/admin/getallwarehouse")
    public List<WareHouseEntity> getall(){
        List<WareHouseEntity> result = wareHouseService.getListWareHouse();
        return result;
    }
    //API lấy thông tin tt khách hàng
    @GetMapping(value = "/admin/customerinfor/")
    public List<CustomerDTO> adminCustomer(){
        return customerService.getListCustomers();
    }

}

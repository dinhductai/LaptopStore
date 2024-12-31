package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Convert.Order_TotalAmountInMonthDTOConverter;
import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;
import com.example.ProjectLaptopStore.Repository.*;
import com.example.ProjectLaptopStore.Response.Admin_BillResponseDTO;
import com.example.ProjectLaptopStore.Response.Admin_DashBoardResponseDTO;
import com.example.ProjectLaptopStore.Response.Admin_WarehouseResponseDTO;
import com.example.ProjectLaptopStore.Service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
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
    private OrderRepository orderRepository;
    @Autowired
    private WareHouseService wareHouseService;
    @Autowired
    private ExportReceiptDetailsRepository exportReceiptDetailsRepository;
    @Autowired
    private WareHouseRepository wareHouseRepository;
    @Autowired
    private Order_TotalAmountInMonthDTOConverter order_TotalAmountInMonthDTOConverter;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private ProductsInWarehouseRepository productsInWarehouseRepository;
    @Autowired
    private ImportReceiptDetailsRepository importReceiptDetailsRepository;
    //hàm gộp thông tin cho trang dashboard
    @Override
    public Admin_DashBoardResponseDTO adminDashBoardAtService() {
        Admin_DashBoardResponseDTO adminInfo = new Admin_DashBoardResponseDTO();
        try {
            Integer productSellInMonth = orderDetailService.getQuantityProductCurrentMonthAtService();
            Integer totalCustomerInMonth = orderService.TotalCustomerInMonthAtService();
            Integer totalNewCustomerInMonth = customerService.getNewCustomerCurrentMonth();
            BigDecimal totalAmountInMonth = orderService.getTotalAmountInMountAtService();
            List<Customer_CountNewCustomerPerMonthDTO> newCustomerForChart = customerService.listCountNewCustomerPerMonth();
            List<Order_CountTotalAmountDTO> totalAmountForChart = orderService.listCountTotalAmountAtService();
            List<OrderDetail_CountQuantityProductPerMonthDTO> quantityProductForChart = orderDetailService.listCountQuantityProductPerMonth();
            List<ProductDetailDTO> listTopProductSell = productService.findTopPurchasedProductAtService();
            List<CustomerDTO> listTopCustomer = customerRepository.listTopCustomerInMonth();
            adminInfo.setQuantitySellProductCurrentMonth(productSellInMonth);
            adminInfo.setTotalCustomerInCurrentMonth(totalCustomerInMonth);
            adminInfo.setTotalNewCustomerInCurrentMonth(totalNewCustomerInMonth);
            adminInfo.setTotalAmountInCurrentMonth(totalAmountInMonth);
            adminInfo.setNewCustomerPerMonthMap(newCustomerForChart);
            adminInfo.setTotalAmountPerMonthMap(totalAmountForChart);
            adminInfo.setTotalQuantitySellProductPerMonthMap(quantityProductForChart);
            adminInfo.setTopPurchasedProductInMonth(listTopProductSell);
            adminInfo.setTopCustomerInMonth(listTopCustomer);
        }catch (Exception e){
            e.printStackTrace();
        }
        return adminInfo;
    }

    @Override
    public Admin_BillResponseDTO adminBillingAtService() {
            Admin_BillResponseDTO billingResponseDTO = new Admin_BillResponseDTO();
            try {
                BigDecimal totalAmountOnline = orderRepository.getTotalAmountPayOnline();
                BigDecimal totalAmountOffline = orderRepository.getTotalAmountPayOffline();
                List<Order_InvoiceDetailDTO> listInvoice = orderRepository.listInvoiceDetail();
                billingResponseDTO.setTotalAmountPayOnline(totalAmountOnline);
                billingResponseDTO.setTotalAmountPayOffline(totalAmountOffline);
                billingResponseDTO.setListInvoiceDetail(listInvoice);
            }catch (Exception e)
            {
                e.printStackTrace();
            }
            return billingResponseDTO;
    }

    @Override
    public Admin_WarehouseResponseDTO adminReceiptAtService(Integer warehouseID) {
        Admin_WarehouseResponseDTO adminReceiptResponseDTO = new Admin_WarehouseResponseDTO();
        try {
            List<WareHouseEntity> listWarehouse = wareHouseService.getListWareHouse();
            WareHouseEntity wareHouse = wareHouseRepository.findByWarehouseIDAndStatus(warehouseID, Status_Enum.active);
            Integer totalQuantity = productsInWarehouseRepository.getTotalQuantity(warehouseID);
            Integer minStock = productsInWarehouseRepository.countProductsMinStockLevel(warehouseID);
            Integer maxStock = productsInWarehouseRepository.countProductsMaxStockLevel(warehouseID);
            List<ImportExport_ReceiptDisplayDTO> listExportReceipt = exportReceiptDetailsRepository.listExportReceipt(warehouseID);
            List<ImportExport_ReceiptDisplayDTO> listImportReceipt = importReceiptDetailsRepository.listImportReceipt(warehouseID);
            List<ProductsInWarehouse_DTO> listProductsInWarehouse = productsInWarehouseRepository.listProductsInWarehouse(warehouseID);
            adminReceiptResponseDTO.setWarehouseList(listWarehouse);
            adminReceiptResponseDTO.setWarehouseInfo(wareHouse);
            adminReceiptResponseDTO.setTotalQuantity(totalQuantity);
            adminReceiptResponseDTO.setCountProductsMinStockLevel(minStock);
            adminReceiptResponseDTO.setCountProductsMaxStockLevel(maxStock);
            adminReceiptResponseDTO.setListExportReceipt(listExportReceipt);
            adminReceiptResponseDTO.setListImportReceipt(listImportReceipt);
            adminReceiptResponseDTO.setListProductsInWarehouse(listProductsInWarehouse);
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return adminReceiptResponseDTO;
    }



}

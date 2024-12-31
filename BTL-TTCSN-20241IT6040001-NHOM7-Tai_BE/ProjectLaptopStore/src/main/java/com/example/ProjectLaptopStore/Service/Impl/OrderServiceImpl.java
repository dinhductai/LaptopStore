package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Convert.Order_TotalAmountInMonthDTOConverter;
import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.*;
import com.example.ProjectLaptopStore.Entity.Enum.OrderStatus_Enum;
import com.example.ProjectLaptopStore.Repository.*;
import com.example.ProjectLaptopStore.Service.*;
import jakarta.persistence.EntityManager;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private Order_TotalAmountInMonthDTOConverter order_TotalAmountInMonthDTOConverter;

    @Autowired
    private ProductService productService;


    @Autowired
    private CustomerService customerService;

    @Autowired
    private SuppliersService suppliersService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    EntityManager entityManager;

    @Autowired
    CustomerRepository CustomerRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    ShippingAddressesRepository shippingAddressesRepository;

    @Autowired
    PaymentMethodRepository PaymentMethodRepository;

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Autowired
    CartDetailRepository CartDetailRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Override
    public BigDecimal getTotalAmountInMountAtService() {
        BigDecimal res = orderRepository.getTotalAmount();
        return res;
    }

    @Override
    public Integer TotalCustomerInMonthAtService() {
        Integer totalCustomer = orderRepository.countCustomersForCurrentMonth();
        return totalCustomer;
    }

    @Override
    public List<Order_ListBillDTO> ListBillAtService() {
        List<Order_ListBillDTO> result = orderRepository.listBill();
        return result;
    }

    @Override
    public List<Order_InvoiceDetailDTO> ListInvoiceDetailAtService() {
        List<Order_InvoiceDetailDTO> result = orderRepository.listInvoiceDetail();
        return result;
    }

    @Override
    public List<Order_CountTotalAmountDTO> listCountTotalAmountAtService() {
        List<Order_CountTotalAmountDTO> result = orderRepository.listCountTotalAmount();
        return result;
    }

    @Override
    public BigDecimal getTotalAmountOnline() {
        BigDecimal result = orderRepository.getTotalAmountPayOnline();
        return result;
    }

    @Override
    public BigDecimal getTotalAmountOffline() {
        BigDecimal result = orderRepository.getTotalAmountPayOffline();
        return result;
    }


    @Override
    public void createOrder(OrderDTO dto) {

        // kiem tra neu khong co san pham trong gio hang thi Exception
        if(dto.getOrderDetails().size() == 0){
            throw new RuntimeException("Create Order Failed");
        }
        // tim kiem customer voi ID de them order
        CustomerEntity c = customerRepository.findById(dto.getCustomerID()).orElse(null);

        // neu customer khong tim thay => Exception
        if(c == null){
            throw new RuntimeException("Create Order Failed");
        }

        // tim kiem phuong thuc thanh toan
        PayMentMethodsEntity pm = paymentMethodRepository.findById(dto.getPaymentMethodID()).orElse(null);
        if(pm == null){
            throw new RuntimeException("You must select payment method");
        }

        // tim kiem dia chia
        ShippingAddressEntity sa = shippingAddressesRepository.findById(dto.getAddressID()).orElse(null);

        // kiem tra ton tai dia chi khong
        if(sa == null){
            throw new RuntimeException("you must select a shipping address");
        }



        // tao moi 1 orderEntity
        OrdersEntity order = new OrdersEntity();

        // set cac du lieu duoc gui ve cho order entity
        order.setCustomer(c);
        order.setOrderDate(new Date());
        order.setTotalAmount(dto.getTotalAmount());
        order.setShippingFee(dto.getShippingFee());
        order.setOrderStatus(OrderStatus_Enum.Pending);
        order.setEstimatedDeliveryDate(dto.getEstimatedDeliveryDate());
        order.setActualDeliveryDate(dto.getActualDeliveryDate());
        order.setPayMentMethod(pm);
        order.setShipAddress(sa);

        // them vao csdl
        entityManager.persist(order);
        entityManager.flush();

        // duyet cac order detail
        for (OrderDetail_createOrderDTO orderdetail : dto.getOrderDetails()) {

            // tao moi order detail
            OrderDetailEntity orderDetailEntity = new OrderDetailEntity();

            // tim kiem san pham
            ProductsEntity products = productRepository.findById(orderdetail.getProductID()).orElse(null);

            // kiem tra ton san pham ton tai khong
            if(products == null){
                throw new RuntimeException("You must select a product to order");
            }

            // set cac du lieu duoc gui ve cho order detail
            orderDetailEntity.setOrder(order);
            orderDetailEntity.setProduct(products);
            orderDetailEntity.setQuantity(orderdetail.getQuantity());
            orderDetailEntity.setPrice(orderdetail.getPrice());

            // them order detail vao csdl
            entityManager.persist(orderDetailEntity);
            entityManager.flush();
        }
    }

    @Override
    public List<Order_OrderDetailDTO> ListOrderDetail(int id) {
        // danh sach id cua order
        List<Integer> ids = orderRepository.findOrderIDByCustomerID(id);
        List<Order_OrderDetailDTO> result = new ArrayList<>();
        String status ="";
        for (Integer i : ids) {
            List<Object[]> od = orderDetailRepository.getOrderDetail(i);
            List<OrderDetail_displayForStatusDTO> orderDetail = new ArrayList<>();
            for (Object[] o : od) {
                OrderDetail_displayForStatusDTO dto2 = OrderDetail_displayForStatusDTO.builder()
                        .imageURL((String) o[0])
                        .productName((String) o[1])
                        .quantity((int)o[2])
                        .lineTotal((BigDecimal) o[3])
                        .build();
                orderDetail.add(dto2);
                status = (String) o[4];

            }
            Order_OrderDetailDTO dto = new Order_OrderDetailDTO();
            dto.setOrderdetail(orderDetail);
            dto.setStatus(status);
            dto.setOrderID(i);
            if(dto.getOrderdetail().size() != 0){
                result.add(dto);
            }
        }
        return  result;
    }

    @Override
    public List<Order_OrderDetailDTO> ListOrderDetailByStatus(int customerID, String status) {
        List<Integer> ids = orderRepository.findOrderIDByCustomerID(customerID);
        List<Order_OrderDetailDTO> result = new ArrayList<>();
        String s = "";
        for (Integer i : ids) {
            List<Object[]> od = orderDetailRepository.SearchOrderDetailByStatus(i,status);
            List<OrderDetail_displayForStatusDTO> orderDetail = new ArrayList<>();
            for (Object[] o : od) {
                OrderDetail_displayForStatusDTO dto2 = OrderDetail_displayForStatusDTO.builder()
                        .imageURL((String) o[0])
                        .productName((String) o[1])
                        .quantity((int)o[2])
                        .lineTotal((BigDecimal) o[3])
                        .build();
                orderDetail.add(dto2);
                s = (String) o[4];
            }
            Order_OrderDetailDTO dto = new Order_OrderDetailDTO();
            dto.setOrderdetail(orderDetail);
            dto.setStatus(s);
            dto.setOrderID(i);
            if(dto.getOrderdetail().size() != 0){
                result.add(dto);
            }
        }
        return  result;
    }

    @Override
    public void cancelOrder(int orderID) {
        OrdersEntity order = orderRepository.findById(orderID).orElse(null);
        if(order == null){
            throw new RuntimeException("You must select a order or your order is null");
        }
        else{
            order.setOrderStatus(OrderStatus_Enum.Canceled);
            entityManager.merge(order);
        }
    }
}

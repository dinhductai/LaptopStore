package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.CustomerEntity;
import com.example.ProjectLaptopStore.Entity.ShippingAddressEntity;
import com.example.ProjectLaptopStore.Entity.UserEntity;

import java.util.List;


public interface CustomerRepositoryCustom {
    List<Customer_CountNewCustomerPerMonthDTO> listNewCustomerPerMonth();
//    Integer countNewCustomer(CustomerSearchBuilder customerSearchBuilder); //đếm số người dùng mới
//    List<Customer_FindTopCustomer> findTopCustomer(); //tìm danh sách khách mua nhiều nhất
    void deleteCustomer(List<CustomerEntity> listCustomerDelete);
    void createCustomer(CustomerDTO customerNew);
    void updateCustomer(CustomerDTO customerUpdate, ShippingAddressEntity shippingAddressEntity, CustomerEntity customerEntity, UserEntity userEntity);
    List<CustomerDTO> listTopCustomerInMonth();
    List<CustomerDTO> getListCustomer();
    List<Customer_GetListCusDTO> getListCustomerNoAdr();

}


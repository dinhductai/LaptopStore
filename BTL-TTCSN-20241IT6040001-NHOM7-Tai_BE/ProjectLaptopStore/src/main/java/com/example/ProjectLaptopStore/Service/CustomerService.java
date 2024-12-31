package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Response.Admin_CustomerResponseDTO;

import java.util.List;

public interface CustomerService {
//    Integer countCustomers(Map<String, Object> params);
    List<Customer_CountNewCustomerPerMonthDTO> listCountNewCustomerPerMonth();
    void deleteCustomerAtService(Long[] ids);
    void createCustomerAtService(CustomerDTO customerNew);
    void updateCustomerAtService(CustomerDTO customerUpdate);

    Integer getNewCustomerCurrentMonth();
    List<CustomerDTO> getListCustomers();
    Admin_CustomerResponseDTO adminCustomer();
    Customer_GetListCusDTO getCustomerByID(Integer id);
}

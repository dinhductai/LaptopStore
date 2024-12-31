package com.example.ProjectLaptopStore.Response;

import com.example.ProjectLaptopStore.DTO.CustomerDTO;
import com.example.ProjectLaptopStore.DTO.Customer_CountNewCustomerPerMonthDTO;
import com.example.ProjectLaptopStore.DTO.Customer_FindTopCustomerInMonthDTO;
import com.example.ProjectLaptopStore.DTO.Customer_GetListCusDTO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Admin_CustomerResponseDTO {
    List<Customer_CountNewCustomerPerMonthDTO> countNewCustomerPerMonth;
    List<CustomerDTO> findTopCustomerInMonth;
    List<Customer_GetListCusDTO> listCustomer;
}

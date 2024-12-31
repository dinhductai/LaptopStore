package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Convert.Customer_CountNewCustomerConverter;
import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.CustomerEntity;
import com.example.ProjectLaptopStore.Entity.ShippingAddressEntity;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Repository.CustomerRepository;
import com.example.ProjectLaptopStore.Repository.UserRepository;
import com.example.ProjectLaptopStore.Repository.ShippingAddressesRepository;
import com.example.ProjectLaptopStore.Response.Admin_CustomerResponseDTO;
import com.example.ProjectLaptopStore.Service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private Customer_CountNewCustomerConverter customerCountNewCustomerConverter;

    @Autowired
    private ShippingAddressesRepository shippingAddressesRepository;
    @Autowired
    private UserRepository userRepository;
    @Override
    public List<Customer_CountNewCustomerPerMonthDTO> listCountNewCustomerPerMonth() {
        List<Customer_CountNewCustomerPerMonthDTO> result = customerRepository.listNewCustomerPerMonth();
        if(result == null || result.isEmpty()){
            throw new NoSuchElementException("No data found or system error");
        }
        return result;
    }

    @Override
    public void deleteCustomerAtService(Long[] ids) {
        List<CustomerEntity> listCustomerDeleteById = customerRepository.findAllByCustomerIDIn(ids);
        if(listCustomerDeleteById.isEmpty()){
            throw new NoSuchElementException("No such customer");
        }else {
            customerRepository.deleteCustomer(listCustomerDeleteById);
        }
    }

    @Override
    public void createCustomerAtService(CustomerDTO customerNew) {
        List<UserEntity> listUser = userRepository.findAll();
        if(listUser.isEmpty() || listUser.size() == 0){
            throw new NoSuchElementException("List user is empty");
        }
        for(UserEntity user : listUser){
            if(user.getEmail().equals(customerNew.getEmail())){
                throw new NoSuchElementException("Email is already in use");
            }else{
                customerRepository.createCustomer(customerNew);
                break;
            }
        }
    }

    @Override
    public void updateCustomerAtService(CustomerDTO customerUpdate) {
        CustomerEntity customerEntity = customerRepository.findById(customerUpdate.getCustomerID()).get();
        UserEntity userEntity = userRepository.findById(customerUpdate.getUserID()).get();
        ShippingAddressEntity shippingAddressEntity = shippingAddressesRepository.findById(customerUpdate.getAddressID()).get();
        customerRepository.updateCustomer(customerUpdate,shippingAddressEntity,customerEntity,userEntity);
    }

    @Override
    public Integer getNewCustomerCurrentMonth() {
        Integer result = customerRepository.getNewCustomerCurrentMonth();
        return result;
    }

    @Override
    public List<CustomerDTO> getListCustomers() {
        return customerRepository.getListCustomer();
    }

    @Override
    public Admin_CustomerResponseDTO adminCustomer() {
        Admin_CustomerResponseDTO result = new Admin_CustomerResponseDTO();
        try {
            List<Customer_CountNewCustomerPerMonthDTO> listCountNewCustomerPerMonth = customerRepository.listNewCustomerPerMonth();
            List<CustomerDTO> listTopCustomerInMonth = customerRepository.listTopCustomerInMonth();
            List<Customer_GetListCusDTO> listCustomer = customerRepository.getListCustomerNoAdr();
            result.setCountNewCustomerPerMonth(listCountNewCustomerPerMonth);
            result.setFindTopCustomerInMonth(listTopCustomerInMonth);
            result.setListCustomer(listCustomer);
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return result;
    }

    // sang fix lai hien thi
//    @Override
//    public Admin_CustomerResponseDTO adminCustomer() {
//        Admin_CustomerResponseDTO result = new Admin_CustomerResponseDTO();
//        try {
//            List<Customer_CountNewCustomerPerMonthDTO> listCountNewCustomerPerMonth = customerRepository.listNewCustomerPerMonth();
//            List<CustomerDTO> listTopCustomerInMonth = customerRepository.listTopCustomerInMonth();
//            List<CustomerDTO> listCustomer = customerRepository.getListCustomer();
//            result.setCountNewCustomerPerMonth(listCountNewCustomerPerMonth);
//            result.setFindTopCustomerInMonth(listTopCustomerInMonth);
//            result.setListCustomer(listCustomer);
//        }catch (Exception e)
//        {
//            e.printStackTrace();
//        }
//        return result;
//    }

    @Override
    public Customer_GetListCusDTO getCustomerByID(Integer id) {
        List<Customer_GetListCusDTO> listCustomer = customerRepository.getListCustomerNoAdr();
        for(Customer_GetListCusDTO customer : listCustomer){
            if(customer.getCustomerID().equals(id)){
                return customer;
            }
        }
        return null;
    }


}

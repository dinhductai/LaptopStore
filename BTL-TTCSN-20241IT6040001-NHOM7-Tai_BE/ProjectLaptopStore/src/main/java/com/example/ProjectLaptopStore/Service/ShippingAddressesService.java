package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.ShippingAddressesDTO;

import java.util.List;


public interface ShippingAddressesService {
    // lay danh sach dia chi customer
    List<ShippingAddressesDTO> getAllShippingAddresses(int customerId);

    //them moi dia chi nguoi nhan
    void addShippingAddresses(ShippingAddressesDTO shippingAddressesDTO,int customerId);

    // cap nhap thong tin dia chi nguoi nhan
    void updateShippingAddresses(ShippingAddressesDTO shippingAddressesDTO);

    // xoa dia chi nguoi nhan
    void deleteShippingAddresses(int addressID);
}

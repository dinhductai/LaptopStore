package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.DTO.ShippingAddressesDTO;
import com.example.ProjectLaptopStore.Entity.ShippingAddressEntity;
import com.example.ProjectLaptopStore.Repository.CustomerRepository;
import com.example.ProjectLaptopStore.Repository.ShippingAddressesRepository;
import com.example.ProjectLaptopStore.Service.ShippingAddressesService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityNotFoundException;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Transactional
@Service
public class ShippingAddressServiceImpl implements ShippingAddressesService {
    @Autowired
    ShippingAddressesRepository shippingAddressesRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    EntityManager entityManager;

    @Autowired
    ModelMapper modelMapper;

    @Override
    public List<ShippingAddressesDTO> getAllShippingAddresses(int id) {
        List<Object[]> ship = shippingAddressesRepository.getAllShippingAddresses(id);
        List<ShippingAddressesDTO> resutl = new ArrayList<>();

        for (Object[] o : ship) {
            ShippingAddressesDTO dto = ShippingAddressesDTO.builder()
                    .addressID((int) o[0])
                    .address((String) o[1])
                    .city((String) o[2])
                    .district((String) o[3])
                    .ward((String) o[4])
                    .streetAddress((String) o[5])
                    .phoneNumber((String) o[6])
                    .build();

            resutl.add(dto);
        }
        return resutl;
    }


    @Override
    public void addShippingAddresses(ShippingAddressesDTO shippingAddressesDTO,int customerID) {
        ShippingAddressEntity sa = new ShippingAddressEntity();
        sa.setCustomer(customerRepository.findById(customerID).get());
        sa.setAddress(shippingAddressesDTO.getAddress());
        sa.setCity(shippingAddressesDTO.getCity());
        sa.setDistrict(shippingAddressesDTO.getDistrict());
        sa.setWard(shippingAddressesDTO.getWard());
        sa.setStreetAddress(shippingAddressesDTO.getStreetAddress());
        entityManager.persist(sa);

    }

    @Override
    public void updateShippingAddresses(ShippingAddressesDTO dto) {
        ShippingAddressEntity sa = shippingAddressesRepository.getShippingAddressById(dto.getAddressID());
        if (sa == null) {
            throw new EntityNotFoundException("Shipping address with id " + dto.getAddressID() + " not found");
        }
        sa.setAddress(dto.getAddress());
        sa.setCity(dto.getCity());
        sa.setDistrict(dto.getDistrict());
        sa.setWard(dto.getWard());
        sa.setStreetAddress(dto.getStreetAddress());
        entityManager.merge(sa);

    }

    @Override
    public void deleteShippingAddresses(int id) {
        ShippingAddressEntity sa = shippingAddressesRepository.getShippingAddressById(id);
        if (sa == null) {
            throw new EntityNotFoundException("shipping address with id " + id + " not found");
        }
        entityManager.remove(sa);
    }
}

package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.CustomerEntity;
import com.example.ProjectLaptopStore.Entity.Enum.Customer_Enum;
import com.example.ProjectLaptopStore.Entity.Enum.User_Enum;
import com.example.ProjectLaptopStore.Entity.ShippingAddressEntity;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Repository.Custom.CustomerRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository
//@Primary
@Transactional
public class CustomerRepositoryCustomImpl implements CustomerRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

//    // Hàm xây dựng câu truy vấn điều kiện
//    public static void queryNomal(CustomerSearchBuilder customerSearchBuilder, StringBuilder where) {
//        // Nếu có ngày bắt đầu
//        if (customerSearchBuilder.getDateRegisterFrom() != null) {
//            where.append(" and c.RegistrationDate >= :dateRegisterFrom ");
//        }
//        // Nếu có ngày kết thúc
//        if (customerSearchBuilder.getDateRegisterTo() != null) {
//            where.append(" and c.RegistrationDate <= :dateRegisterTo ");
//        }
//    }

//    @Override
//    public Integer countNewCustomer(CustomerSearchBuilder customerSearchBuilder) {
//        StringBuilder sql = new StringBuilder("select count(distinct c.CustomerID) from customers c ");
//        StringBuilder where = new StringBuilder(" where 1=1 ");
//        queryNomal(customerSearchBuilder, where);
//        sql.append(where);
//        // Hiển thị câu lệnh trong console (nếu cần kiểm tra)
//        System.out.println(sql.toString());
//
//        Query query = entityManager.createNativeQuery(sql.toString());
//        // Set các tham số cho câu truy vấn
//        if (customerSearchBuilder.getDateRegisterFrom() != null) {
//            query.setParameter("dateRegisterFrom", customerSearchBuilder.getDateRegisterFrom());
//        }
//        if (customerSearchBuilder.getDateRegisterTo() != null) {
//            query.setParameter("dateRegisterTo", customerSearchBuilder.getDateRegisterTo());
//        }
//        // Trả về kết quả duy nhất
//        try {
//            return ((Number) query.getSingleResult()).intValue();
//        } catch (NoResultException e) {
//            return 0;
//        }
//    }

    //lấy ra số khách hàng mới trong các tháng,trong năm hiện tại
    @Override
    public List<Customer_CountNewCustomerPerMonthDTO> listNewCustomerPerMonth() {
        String query = "SELECT " +
                "MONTH(RegistrationDate) AS month, " +
                "COUNT(DISTINCT CustomerID) AS NewCustomerCount " +
                "FROM " +
                "Customers " +
                "WHERE YEAR(RegistrationDate) = YEAR(CURDATE()) " +
                "GROUP BY Month " +
                "ORDER BY Month ";
        Query nativeQuery = entityManager.createNativeQuery(query) ;
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<Customer_CountNewCustomerPerMonthDTO> listCountNewCustomer = new ArrayList<>();
        for(Object[] rowOfResult : resultQuery) {
            Customer_CountNewCustomerPerMonthDTO dto = new Customer_CountNewCustomerPerMonthDTO(
                    (Long) rowOfResult[0],
                    (Long) rowOfResult[1]
            );
            listCountNewCustomer.add(dto);
        }
        return listCountNewCustomer;
    }

    @Override
    public void deleteCustomer(List<CustomerEntity> listCustomerDelete) {

        for(CustomerEntity cusOfListDel : listCustomerDelete) {
            cusOfListDel.setStatus(Customer_Enum.locked);
            entityManager.merge(cusOfListDel);
        }
        entityManager.flush();
    }

    //sử dụng JPA tạo khách hàng mới
    @Override
    public void createCustomer(CustomerDTO customerNew) {
        CustomerEntity customerEntity = new CustomerEntity();
        UserEntity userEntity = new UserEntity();
//        ShippingAddressEntity shippingAddressEntity = new ShippingAddressEntity();

        userEntity.setFullName(customerNew.getFullName());
        userEntity.setEmail(customerNew.getEmail());
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userEntity.setPassword(passwordEncoder.encode(customerNew.getPassWord()));
        userEntity.setPhoneNumber(customerNew.getPhoneNumber());
        userEntity.setUserType(User_Enum.customer);
        userEntity.setRegistrationDate(customerNew.getRegistrationDate());

        customerEntity.setUser(userEntity);
        customerEntity.setRegistrationDate(customerNew.getRegistrationDate());
        customerEntity.setStatus(Customer_Enum.active);

//        shippingAddressEntity.setCustomer(customerEntity);
//        shippingAddressEntity.setAddress(customerNew.getAddress());
//        shippingAddressEntity.setCity(customerNew.getCity());
//        shippingAddressEntity.setDistrict(customerNew.getDistrict());
//        shippingAddressEntity.setWard(customerNew.getWard());
//        shippingAddressEntity.setStreetAddress(customerNew.getStreetAddress());
        entityManager.persist(userEntity);
        entityManager.persist(customerEntity);
//        entityManager.persist(shippingAddressEntity);
    }

    @Override
    public void updateCustomer(CustomerDTO customerUpdate,ShippingAddressEntity shippingAddressEntity, CustomerEntity customerEntity, UserEntity userEntity) {
        userEntity.setFullName(customerUpdate.getFullName());
        userEntity.setEmail(customerUpdate.getEmail());
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userEntity.setPassword(passwordEncoder.encode(customerUpdate.getPassWord()));
        userEntity.setPhoneNumber(customerUpdate.getPhoneNumber());
        userEntity.setUserType(User_Enum.customer);
        userEntity.setRegistrationDate(customerUpdate.getRegistrationDate());

        customerEntity.setUser(userEntity);
//        customerEntity.setRegistrationDate(customerUpdate.getRegistrationDate());
        customerEntity.setStatus(Customer_Enum.active);

//        shippingAddressEntity.setCustomer(customerEntity);
//        shippingAddressEntity.setAddress(customerUpdate.getAddress());
//        shippingAddressEntity.setCity(customerUpdate.getCity());
//        shippingAddressEntity.setDistrict(customerUpdate.getDistrict());
//        shippingAddressEntity.setWard(customerUpdate.getWard());
//        shippingAddressEntity.setStreetAddress(customerUpdate.getStreetAddress());
        entityManager.merge(userEntity);
        entityManager.merge(customerEntity);
//        entityManager.merge(shippingAddressEntity);
        entityManager.flush();
    }

    @Override
    public List<CustomerDTO> listTopCustomerInMonth() {
        StringBuilder query= new StringBuilder(" SELECT " +
                " SUM(o.TotalAmount) AS totalamount, ");
        query.append(setQuery(" MONTH(o.OrderDate) = MONTH(CURDATE()) " +
                " AND YEAR(o.OrderDate) = YEAR(CURDATE()) AND "," JOIN Orders o ON c.CustomerID = o.CustomerID "));
        query.append(" ORDER BY totalamount DESC ");
        Query queryNative = entityManager.createNativeQuery(query.toString());
        List<Object[]> resultQuery = queryNative.getResultList();
        List<CustomerDTO> listCustomerDTO = new ArrayList<>();
        for(Object[] rowOfResult : resultQuery) {
            CustomerDTO dto = setConstructor(rowOfResult,1);
            listCustomerDTO.add(dto);
        }
        return listCustomerDTO;

    }
    //sang fix hien thi
//    @Override
//    public List<CustomerDTO> getListCustomer() {
//        StringBuilder query = new StringBuilder("Select u.UserID,c.CustomerID,u.FullName, u.Email, u.PhoneNumber \n" +
//                "FROM Users u\n" +
//                "JOIN Customers c ON u.UserID = c.UserID ");
////        query.append(setQuery(" "," "));
//        Query queryNative = entityManager.createNativeQuery(query.toString());
//        List<Object[]> resultQuery = queryNative.getResultList();
//        List<CustomerDTO> listCustomerDTO = new ArrayList<>();
//        for(Object[] rowOfResult : resultQuery) {
//            CustomerDTO dto = new CustomerDTO();
//            dto.setFullName(rowOfResult[0].toString());
//            dto.setEmail(rowOfResult[1].toString());
//            dto.setPhoneNumber(rowOfResult[2].toString());
//            listCustomerDTO.add(dto);
//        }
//        return listCustomerDTO;
//    }
    @Override
    public List<CustomerDTO> getListCustomer() {
        StringBuilder query = new StringBuilder("Select ");
        query.append(setQuery(" "," "));
        Query queryNative = entityManager.createNativeQuery(query.toString());
        List<Object[]> resultQuery = queryNative.getResultList();
        List<CustomerDTO> listCustomerDTO = new ArrayList<>();
        for(Object[] rowOfResult : resultQuery) {
            CustomerDTO dto = setConstructor(rowOfResult,2);
            listCustomerDTO.add(dto);
        }
        return listCustomerDTO;
    }

    @Override
    public List<Customer_GetListCusDTO> getListCustomerNoAdr() {
        String query = "Select u.UserID ,\n" +
                "c.CustomerID,\n" +
                "u.FullName,\n" +
                "u.Email ,\n" +
                "u.Password ,\n" +
                "u.PhoneNumber,\n" +
                "u.RegistrationDate\n" +
                "FROM Users u\n" +
                "JOIN Customers c ON u.UserID = c.UserID\n" +
                "WHERE  \n" +
                "c.Status = 'active' \n";
        Query nativeQuery = entityManager.createNativeQuery(query);
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<Customer_GetListCusDTO> listCustomerDTO = new ArrayList<>();
        for(Object[] rowOfResult : resultQuery) {
            Customer_GetListCusDTO dto = Customer_GetListCusDTO.builder()
                    .userID((Integer) rowOfResult[0])
                    .customerID((Integer) rowOfResult[1])
                    .fullName((String) rowOfResult[2])
                    .email((String) rowOfResult[3])
                    .passWord((String) rowOfResult[4])
                    .phoneNumber((String) rowOfResult[5])
                    .registrationDate((Date) rowOfResult[6])
                    .build();
            listCustomerDTO.add(dto);
        }
        return listCustomerDTO;
    }

    public StringBuilder setQuery(String addQuery,String addQueryJoin){
        StringBuilder query = new StringBuilder(
                        "    u.UserID AS userID,\n" +
                        "    c.CustomerID AS customerID,\n" +
                        "    sa.AddressID AS addressID,\n" +
                        "    u.FullName AS fullName,\n" +
                        "    u.Email AS email,\n" +
                        "    u.Password AS passWord,\n" +
                        "    u.PhoneNumber AS phoneNumber,\n" +
                        "    u.RegistrationDate AS registrationDate,\n" +
                        "    sa.Address AS address,\n" +
                        "    sa.City AS city,\n" +
                        "    sa.District AS district,\n" +
                        "    sa.Ward AS ward,\n" +
                        "    sa.StreetAddress AS streetAddress\n" +
                        "FROM Users u\n" +
                        "JOIN Customers c ON u.UserID = c.UserID\n" +
                        "JOIN ShippingAddresses sa ON c.CustomerID = sa.CustomerID \n" +
                        addQueryJoin +
                        "WHERE  \n" +
                        addQuery+
                        "  c.Status = 'active' \n" +
                        " AND sa.AddressID = (\n" +
                        "    SELECT MIN(sa2.AddressID) \n" +
                        "    FROM ShippingAddresses sa2 \n" +
                        "    WHERE sa2.CustomerID = sa.CustomerID\n" +
                        " ) "+
                        "GROUP BY \n" +
                        "    u.UserID, c.CustomerID, sa.AddressID, u.FullName, u.Email, u.Password, \n" +
                        "    u.PhoneNumber, u.RegistrationDate, sa.Address, sa.City, sa.District, \n" +
                        "    sa.Ward, sa.StreetAddress  "
                );

        return query;
    }

    public CustomerDTO setConstructor(Object[] rowOfResult,Integer task){
            if(task==1) {
                CustomerDTO dto = new CustomerDTO(
                        (BigDecimal) rowOfResult[0],
                        (Integer) rowOfResult[1],
                        (Integer) rowOfResult[2],
                        (Integer) rowOfResult[3],
                        (String) rowOfResult[4],
                        (String) rowOfResult[5],
                        (String) rowOfResult[6],
                        (String) rowOfResult[7],
                        (Date) rowOfResult[8],
                        (String) rowOfResult[9],
                        (String) rowOfResult[10],
                        (String) rowOfResult[11],
                        (String) rowOfResult[12],
                        (String) rowOfResult[13]
                );
                return dto;
            }
            else{
                CustomerDTO dto = new CustomerDTO(
                        null,
                        (Integer) rowOfResult[0],
                        (Integer) rowOfResult[1],
                        (Integer) rowOfResult[2],
                        (String) rowOfResult[3],
                        (String) rowOfResult[4],
                        (String) rowOfResult[5],
                        (String) rowOfResult[6],
                        (Date) rowOfResult[7],
                        (String) rowOfResult[8],
                        (String) rowOfResult[9],
                        (String) rowOfResult[10],
                        (String) rowOfResult[11],
                        (String) rowOfResult[12]
                );
                return dto;
            }
    }
}

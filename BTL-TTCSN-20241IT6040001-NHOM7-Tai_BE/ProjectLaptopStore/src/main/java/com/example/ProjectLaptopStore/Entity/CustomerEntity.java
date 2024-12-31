package com.example.ProjectLaptopStore.Entity;

import com.example.ProjectLaptopStore.Entity.Enum.Customer_Enum;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "customers")
public class CustomerEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer customerID;
    @Column(name = "RegistrationDate",nullable = false)
    private Date registrationDate;
    @Enumerated(EnumType.STRING)
    @Column(name = "Status")
    private Customer_Enum status = Customer_Enum.active;
    @OneToMany(mappedBy = "customer",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<ProductReviewsEntity> productReviews = new ArrayList<>();
    @OneToMany(mappedBy = "customer",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<CartEntity> cartEntities  = new ArrayList<>();
    @OneToMany(mappedBy = "customer",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<OrdersEntity> ordersEntities  = new ArrayList<>();
    @ManyToOne
    @JoinColumn(name = "UserID")
    private UserEntity user;
    @OneToMany(mappedBy = "customer",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<ShippingAddressEntity> shippingAddressEntities = new ArrayList<>();
}

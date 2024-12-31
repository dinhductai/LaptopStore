package com.example.ProjectLaptopStore.DTO;


import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class ShippingAddressesDTO {
    int addressID;
    String address;
    String city;
    String district;
    String ward;
    String streetAddress;
    String phoneNumber;
}

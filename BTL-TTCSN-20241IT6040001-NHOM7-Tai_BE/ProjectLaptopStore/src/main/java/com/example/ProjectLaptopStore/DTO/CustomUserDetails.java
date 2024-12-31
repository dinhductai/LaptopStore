package com.example.ProjectLaptopStore.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
public class CustomUserDetails{

    private int id_User;
    private int id_Customer;
    private int id_Cart;
    private String phoneNumber;
//    private GrantedAuthority authorities;



    public CustomUserDetails() {
    }

//    public Collection<? extends GrantedAuthority> getAuthorities(UserEntity user) {
//        List<SimpleGrantedAuthority> authorityList = new ArrayList<>();
//        authorityList.add(new SimpleGrantedAuthority("ROLE_"+user.getUserType()));
////        authorityList.add(new SimpleGrantedAuthority("ROLE_USER"));
//        return authorityList;
//    }



}

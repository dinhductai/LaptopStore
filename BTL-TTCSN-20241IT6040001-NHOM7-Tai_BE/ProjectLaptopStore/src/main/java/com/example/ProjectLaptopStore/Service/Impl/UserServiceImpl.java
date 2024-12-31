package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.Enum.*;

import com.example.ProjectLaptopStore.Entity.CartEntity;
import com.example.ProjectLaptopStore.Entity.CustomerEntity;

import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Exception.EmailAlreadyExistsException;
import com.example.ProjectLaptopStore.Exception.PhoneNumberAlreadyExistsException;
import com.example.ProjectLaptopStore.Exception.UserAlreadyExistsException;
import com.example.ProjectLaptopStore.Exception.UserNotFoundException;
import com.example.ProjectLaptopStore.Repository.CartRepository;
import com.example.ProjectLaptopStore.Repository.CustomerRepository;
import com.example.ProjectLaptopStore.Repository.UserRepository;

import com.example.ProjectLaptopStore.Response.User_HomeResponseDTO;
import com.example.ProjectLaptopStore.Service.ProductDescriptionService;
import com.example.ProjectLaptopStore.Service.ProductService;
import com.example.ProjectLaptopStore.Service.SuppliersService;
import com.example.ProjectLaptopStore.Service.UserService;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import jakarta.persistence.EntityManager;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import com.example.ProjectLaptopStore.Util.JwtTokenUtil;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Component
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal=true)
public class UserServiceImpl implements UserService {
    private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);
    @Autowired
    private ProductDescriptionService productDescriptionService;

    @Autowired
    private SuppliersService suppliersService;


    @Autowired
    private ProductService productService;


    UserRepository userRepository;

    ModelMapper modelMapper;

    CustomerRepository customerRepository;

    CartRepository cartRepository;

    EntityManager entityManager;
//    private final Authentication authentication;

    JwtTokenUtil jwtTokenUtil;
    @NonFinal
    @Value("${jwt.signerKey}")
    protected  String SIGNER_KEY;

//    private final UserAPI userAPI;

    // lay tat ca user
    @Override
    public List<User_RegisterDTO> getAllUsers() {
        List<UserEntity> entities = userRepository.findAll();
        List<User_RegisterDTO> user_loginDTO = new ArrayList<>();
        for (UserEntity entity : entities) {
            User_RegisterDTO loginDTO = new User_RegisterDTO();
            loginDTO = modelMapper.map(entity, User_RegisterDTO.class);
            user_loginDTO.add(loginDTO);
        }
        return  user_loginDTO;
    }

    // tao user
    @Override
    public void createUser(User_RegisterDTO user) {
        if(userRepository.existsByPhoneNumber(user.getPhoneNumber())) {
                throw new PhoneNumberAlreadyExistsException("Your phone number already exists");
        }
        if(userRepository.existsByEmail(user.getEmail())) {
                throw new EmailAlreadyExistsException("Your email already exists");
        }
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        // tao moi user
        UserEntity userEntity = new UserEntity();
        // tao moi customer
        CustomerEntity customer = new CustomerEntity();
        //tao moi cart cho customer
        CartEntity cart = new CartEntity();

        Date date = new Date();

        userEntity = modelMapper.map(user, UserEntity.class);
        userEntity.setPassword(passwordEncoder.encode(user.getPassword()));
        userEntity.setRegistrationDate(date);
        userEntity.setUserType(User_Enum.customer);
        userRepository.save(userEntity);

        customer.setStatus(Customer_Enum.active);
        customer.setUser(userEntity);
        customer.setRegistrationDate(date);
        customerRepository.save(customer);

        cart.setCreatedDate(date);
        cart.setStatus(CardStatus_Enum.active);
        cart.setCustomer(customer);
        cartRepository.save(cart);
    }

    //update user
    @Transactional
    @Override
    public void updateUser(User_UpdateUserDTO user) {
            UserEntity entity = userRepository.findById(user.getUserID()).orElse(null);
            if(entity == null) {
                throw new UserNotFoundException("User not found");
            }
            else{
                if(user.getEmail() == "" || user.getNewPassword() == "" || user.getPassword() == "" ||
                user.getPhoneNumber() == "" || user.getFullName() == "") {
                    try {
                        throw new Exception("Cac truong du lieu khong hop le");
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                }
                else{

                    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
                    entity.setFullName(user.getFullName());
                    if(user.getPhoneNumber() != entity.getPhoneNumber() && !userRepository.existsByPhoneNumber(user.getPhoneNumber())){
                        entity.setPhoneNumber(user.getPhoneNumber());
                    }else{
                        if(user.getPhoneNumber().equals(entity.getPhoneNumber())){
                            entity.setPhoneNumber(user.getPhoneNumber());
                        }
                        else
                        throw new PhoneNumberAlreadyExistsException("Phone number already exists");
                    }
                    if(user.getEmail() != entity.getEmail() && !userRepository.existsByEmail(user.getEmail())){
                        entity.setEmail(user.getEmail());
                    }else {
                        if(user.getEmail().equals(entity.getEmail())){
                            entity.setEmail(user.getEmail());
                        }
                        else
                        throw  new EmailAlreadyExistsException("Email already exists");
                    }
                    entity.setPassword(passwordEncoder.encode(user.getNewPassword()));
                    entityManager.merge(entity);
                }
            }
    }


    // xoa user
    @Transactional
    @Override
    public void deleteUser(String phoneNumber) {
        if(userRepository.existsByPhoneNumber(phoneNumber)) {
            userRepository.deleteByPhoneNumber(phoneNumber);
        }
        else throw new RuntimeException("So dien thoai khong ton tai");
    }
// tra ve token
    @Autowired
    JwtTokenUtil JwtTokenUtil;

    @Override
    public User_AuthenticationResponseDTO Authenticate(String phoneNumber, String password) {
        UserEntity userEntity = userRepository.findAllByPhoneNumber(phoneNumber);
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if(userEntity != null) {
            CustomerEntity customer = customerRepository.getCustomerID(userEntity.getUserID());

            if (customer!=null && customer.getStatus().equals(Customer_Enum.active) || userEntity.getUserType().equals(User_Enum.admin)) {
                boolean status = passwordEncoder.matches(password, userEntity.getPassword());
                var token = JwtTokenUtil.generateToken(userEntity);
                if (!status)
                    token = null;
                return User_AuthenticationResponseDTO.builder()
                        .status(status)
                        .token(token)
                        .build();
            }
            else throw new RuntimeException("Your account is not active");
        }
        else throw new UserNotFoundException("User not found");

    }

    // kiem tra token co hop le khong



    //phan trang user
    @Override
    public Page<User_DTO> searchUser(int page, int size) {
        Pageable pageable = PageRequest.of(page-1, size);
        List<UserEntity> entities = userRepository.getUsers(pageable);
        List<User_DTO> userDTOs = new ArrayList<>();
        for (UserEntity entity : entities) {
            User_DTO userDTO = modelMapper.map(entity, User_DTO.class);
            userDTOs.add(userDTO);
        }
        Page<User_DTO> userDTOPage = new PageImpl<>(userDTOs);
        return userDTOPage;
    }

    @Override
    public User_HomeResponseDTO userHomePage() {
        User_HomeResponseDTO homeInfor = new User_HomeResponseDTO();
        try {
            List<ProductDetailDTO> getProductForHomePage = productService.listProductDetail();
            homeInfor.setGetProductForHomePage(getProductForHomePage);
            List<ProductDetailDTO> listOutstandingProduct = productService.findTopPurchasedProductAtService();
            Map<Integer,String> getBrandCheckboxBtn = productService.getBrandForCheckbox();
            Map<String,String> getPriceCheckbox = Product_FindProductsByPriceRange_Enum.getPriceRanges();
            Map<String,String> getCPUTechnologyCheckbox = productDescriptionService.getCPUTechnologyForCheckbox();
            Map<Integer,Integer> getRamCapacityCheckbox = productDescriptionService.getRamCapacityForCheckbox();
            Map<String,String> getHardDriveCheckbox = productDescriptionService.getHardDriveForCheckbox();
            Map<String,String> getCustomerDemandCheckbox = ProDescription_FindByUserDemand_Enum.typeUserDemand();
            Map<String,String> getScreenSizeCheckbox = ProDescription_ScreenSize_Enum.getScreenSize();
            homeInfor.setGetOutstandingProducts(listOutstandingProduct);
            homeInfor.setGetSuppliersForCheckboxAndBtn(getBrandCheckboxBtn);
            homeInfor.setGetPriceProductForCheckbox(getPriceCheckbox);
            homeInfor.setGetCPUForCheckbox(getCPUTechnologyCheckbox);
            homeInfor.setGetRamForCheckbox(getRamCapacityCheckbox);
            homeInfor.setGetHardDriveForCheckbox(getHardDriveCheckbox);
            homeInfor.setGetCustomerDemandForCheckBox(getCustomerDemandCheckbox);
            homeInfor.setGetScreenSizeForCheckbox(getScreenSizeCheckbox);
        }catch (Exception e){
            e.printStackTrace();
        }
        return homeInfor;
    }

    // tao token


    @Override
    public User_DTO UserInfor(int id) {
        UserEntity user = userRepository.findById(id).orElse(null);
        if (user == null) {
            throw new UserNotFoundException("User not found");
        }
        User_DTO userDTO = modelMapper.map(user,User_DTO.class);
        return userDTO;
    }
}


package com.example.ProjectLaptopStore.Util;

import com.example.ProjectLaptopStore.DTO.IntrospecTokenDTO;
import com.example.ProjectLaptopStore.DTO.TokenValidDTO;
import com.example.ProjectLaptopStore.Entity.CartEntity;
import com.example.ProjectLaptopStore.Entity.CustomerEntity;
import com.example.ProjectLaptopStore.Entity.Enum.User_Enum;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Repository.CartRepository;
import com.example.ProjectLaptopStore.Repository.CustomerRepository;
import com.example.ProjectLaptopStore.Service.Impl.UserServiceImpl;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.experimental.NonFinal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.SignatureException;
import java.text.ParseException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;

@Component
public class JwtTokenUtil {
    private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    CartRepository CartRepository;

    @Autowired
    CustomerRepository customerRepository;

    @NonFinal
    @Value("${jwt.signerKey}")
    protected String SIGNER_KEY;

    // Giải mã token và lấy các claim
    public Claims extractClaims(String token) throws SignatureException {

        try {
            return Jwts.parserBuilder()
                    .setSigningKey(SIGNER_KEY.getBytes())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            throw new SignatureException("Invalid JWT token", e);
        }
    }

    // Lấy user ID từ token
    public int getCustomerID(String token) {
        try {
            return extractClaims(token).get("id-customer", Integer.class);
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }
    }

    // Lấy thông tin phone từ token (hoặc bất kỳ claim nào khác)
    public String extractPhone(String token) {
        try {
            return extractClaims(token).get("phone", String.class);
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }
    }

    // Kiểm tra xem token có hợp lệ không (kiểm tra ngày hết hạn và chữ ký)

    // Kiểm tra token có hợp lệ không (không hết hạn và chữ ký đúng)
    public TokenValidDTO validateToken(String token) throws JOSEException, ParseException {
        var tk = token;
        JWSVerifier verifier = new MACVerifier(SIGNER_KEY.getBytes());
        SignedJWT signedJWT = SignedJWT.parse(tk);
        Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        var verified = signedJWT.verify(verifier);
        boolean ms = verified && expirationTime.after(new Date());
        String message;
        if (ms == true){
            message = "Your token is Valid" ;
        }
        else {
            message = "Your token is Invalid";
        }
        return TokenValidDTO.builder()
                .token(tk)
                .valid(ms)
                .message(message)
                .build();
    }

    public boolean CheckValidateToken(String token) throws JOSEException, ParseException {
        var tk = token;
        JWSVerifier verifier = new MACVerifier(SIGNER_KEY.getBytes());
        SignedJWT signedJWT = SignedJWT.parse(tk);
        Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        var verified = signedJWT.verify(verifier);
        boolean ms = verified && expirationTime.after(new Date());

        return ms;
    }
    public int getCartID(String token) {
        try {
            return extractClaims(token).get("id-cart", Integer.class);
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }
    }
    public int getUserID(String token) {
        try {
            return extractClaims(token).get("id-user", Integer.class);
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }
    }

    public String generateToken(UserEntity user){
        JWSHeader jwsHeader = new JWSHeader(JWSAlgorithm.HS512);
        CustomerEntity customer = customerRepository.getCustomerID(user.getUserID());
        CartEntity cart;
        int idcart = 0;
        int id = 0;
        if(customer != null) {
            id = customer.getCustomerID();
            cart = CartRepository.getCartByCustomerId(id);
            if(cart != null) {
                idcart = cart.getCartID();
            }
        }
        String role;
        if(user.getUserType().equals(User_Enum.customer)) {
            role = "customer";
        }
        else {
            role = "admin";
        }
        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(user.getPhoneNumber())
                .issuer("laptopabc.com")
                .issueTime(new Date())
                .claim("scope",role)
                .claim("id-customer",id)
                .claim("id-cart",idcart)
                .claim("id-user",user.getUserID())
                .claim("phone",user.getPhoneNumber())
                .expirationTime(new Date(
                        Instant.now().plus(1, ChronoUnit.HOURS).toEpochMilli()
                ))
                .build();
        Payload payload = new Payload(jwtClaimsSet.toJSONObject());
        JWSObject jwsObject = new JWSObject(jwsHeader,payload);
        try {
            jwsObject.sign(new MACSigner(SIGNER_KEY.getBytes()));
            return jwsObject.serialize();
        } catch (JOSEException e) {
            log.error(e.getMessage() + "Can not create token");
            throw new RuntimeException(e);
        }
    }

    public boolean isTokenExpired(String token) {
        Date expirationDate = null;
        try {
            expirationDate = this.extractClaims(token).getExpiration();
        } catch (SignatureException e) {
            throw new RuntimeException(e);
        }
        return expirationDate.before(new Date());
    }

}



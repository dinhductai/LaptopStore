//package com.example.ProjectLaptopStore.Filters;
//
//
//import com.example.ProjectLaptopStore.DTO.CustomUserDetails;
//import com.example.ProjectLaptopStore.Entity.UserEntity;
//import com.example.ProjectLaptopStore.Repository.UserRepository;
//import com.example.ProjectLaptopStore.Util.JwtTokenUtil;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import lombok.NonNull;
//import lombok.RequiredArgsConstructor;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.util.Pair;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
//import org.springframework.stereotype.Component;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//import java.io.IOException;
//import java.util.Arrays;
//import java.util.List;
//
//
//@Component
//@RequiredArgsConstructor
//public class JwtTokenFilter extends OncePerRequestFilter {
//
//    @Autowired
//    private JwtTokenUtil jwtTokenUtil;
//
//    @Autowired
//    UserRepository userRepository;
//    @Override
//    protected void doFilterInternal(@NonNull HttpServletRequest request,
//                                    @NonNull HttpServletResponse response,
//                                    @NonNull FilterChain filterChain)
//            throws ServletException, IOException {
//        try {
////            // Nếu là các API bypass không cần xác thực, bỏ qua filter
////            if (isPublicEndpoint(request)) {
////                filterChain.doFilter(request, response); // tiếp tục chuỗi filter
////                return;
////            }
////
////            // Lấy token từ header
//            final String authHeader = request.getHeader("Authorization");
//            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
//                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
//                return;
//            }
//
//            // Trích xuất token (loại bỏ "Bearer ")
//            final String token = authHeader.substring(7);
//
//            // Giải mã token và lấy các giá trị
//            int idUser = jwtTokenUtil.getUserID(token);
//            int idCart = jwtTokenUtil.getCartID(token);
//            int idCustomer = jwtTokenUtil.getCustomerID(token);
//
//            String phoneNumber = jwtTokenUtil.extractPhone(token);
//            UserEntity user = userRepository.findAllByPhoneNumber(phoneNumber);
//                // Tải thông tin người dùng từ database (thường qua UserDetailsService)
//
//                // Kiểm tra token hợp lệ và chưa hết hạn
//                if (jwtTokenUtil.CheckValidateToken(token)) {
//                    // Tạo CustomUserDetails chứa các thông tin người dùng
//                    CustomUserDetails userDetails = new CustomUserDetails();
//                    userDetails.setId_User(idUser);
//                    userDetails.setId_Customer(idCustomer);
//                    userDetails.setId_Cart(idCart);
//                    userDetails.setPhoneNumber(phoneNumber);
//                    userDetails.setAuthorities(new SimpleGrantedAuthority("ROLE_" + user.getUserType()));
//
//                    // Thiết lập thông tin xác thực trong SecurityContext
//                    UsernamePasswordAuthenticationToken authenticationToken =
//                            new UsernamePasswordAuthenticationToken(userDetails, null);
//                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
//                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
//                }
//
//            // Tiếp tục chuỗi filter
//            filterChain.doFilter(request, response);
//
//        } catch (Exception e) {
////            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
//            response.sendError(HttpServletResponse.SC_BAD_GATEWAY, "U");
//        }
//    }
//
////    public boolean isPublicEndpoint(@NonNull HttpServletRequest request) {
////        // Danh sách các endpoint không cần đăng nhập
////        final List<Pair<String, String>> publicEndpoints = Arrays.asList(
////                Pair.of("/register", "POST"), // Đăng ký
////                Pair.of("/login", "POST"),   // Đăng nhập
////                Pair.of("/user/home/", "GET"),   // Kiểm tra sức khỏe server
////                Pair.of("/user/product", "GET"), // Endpoint public khác
////                Pair.of("/user/compare", "GET")
//////                Pair.of("/v2/api-docs", "GET"),         // Swagger API docs
//////                Pair.of("/swagger-resources/**", "GET"), // Swagger resources
//////                Pair.of("/webjars/**", "GET")
////        );
////
////        // Kiểm tra xem request có khớp với danh sách bypass không
////        for (Pair<String, String> endpoint : publicEndpoints) {
////            if (request.getServletPath().equals(endpoint.getFirst()) &&
////                    request.getMethod().equalsIgnoreCase(endpoint.getSecond())) {
////                return true;
////            }
////        }
////        return false;
////    }
//}
//

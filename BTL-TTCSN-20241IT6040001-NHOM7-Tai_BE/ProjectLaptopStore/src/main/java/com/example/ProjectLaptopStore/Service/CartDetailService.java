package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.CartDetailDTO;

import java.util.List;

public interface CartDetailService {

    //lay ra danh sach cartdetail
    List<CartDetailDTO> getAllCartDetails(int cartID);

    //xoa cartdetail
    void deleteCartDetail(int cartDetailID);

    // cap nhat so luong va so tien khi bam vao dau +
    void additionQuantity(int cartDetailID);

    // cap nhat so luong va so tien khi bam vao dau -
    void subtractionQuantity(int cartDetailID);

    //them san pham vao gio hang
    void addProductToCart(int cartID, int productID);
}

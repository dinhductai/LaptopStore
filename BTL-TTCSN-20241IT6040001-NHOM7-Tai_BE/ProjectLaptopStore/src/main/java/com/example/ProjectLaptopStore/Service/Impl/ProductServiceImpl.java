package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Convert.ProductCheckboxConverter;
import com.example.ProjectLaptopStore.Convert.Product_DisplayForHomePageConverter;
import com.example.ProjectLaptopStore.Convert.Product_SearchBuilderConverter;
import com.example.ProjectLaptopStore.DTO.*;
import com.example.ProjectLaptopStore.Entity.ContentEntity;
import com.example.ProjectLaptopStore.Entity.ProductDescriptionEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;
import com.example.ProjectLaptopStore.Repository.ContentRepository;
import com.example.ProjectLaptopStore.Repository.OrderDetailRepository;
import com.example.ProjectLaptopStore.Repository.ProductDescriptionRepository;
import com.example.ProjectLaptopStore.Repository.ProductRepository;
import com.example.ProjectLaptopStore.Response.Admin_ProductDetailResponseDTO;
import com.example.ProjectLaptopStore.Response.Admin_ProductResponseDTO;
import com.example.ProjectLaptopStore.Service.ProductService;
import com.example.ProjectLaptopStore.Service.SuppliersService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ContentRepository contentRepository;
    @Autowired
    private Product_SearchBuilderConverter productSearchBuilderConverter;
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    @Autowired
    private SuppliersService suppliersService;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private ProductDescriptionRepository productDescriptionRepository;
    @Autowired
    private Product_DisplayForHomePageConverter productDisplayForHomePageConverter;
    @Autowired
    private ProductCheckboxConverter productCheckboxConverter;
    @Override
    public List<ProductDetailDTO> findTopPurchasedProductAtService() {
        List<ProductDetailDTO> result = productRepository.findAllProductsWithTotalQuantityOrdered();
        return result;
    }

    @Override
    public void createNewProduct(ProductDetailDTO productNew) {
        ProductsEntity productsEntity = new ProductsEntity();
        ProductDescriptionEntity productDescriptionEntity = new ProductDescriptionEntity();
        ContentEntity contentEntity = new ContentEntity();
        productRepository.createProduct(productNew,productsEntity,productDescriptionEntity,contentEntity);
    }

    @Override
    public void updateProduct(ProductDetailDTO productUpdate) {
        ProductsEntity productsEntity = productRepository.findById(productUpdate.getProductId()).get();
        ProductDescriptionEntity productDescriptionEntity = productDescriptionRepository.findById(Long.valueOf(productUpdate.getProductDescriptionId())).get();
        ContentEntity contentEntity = contentRepository.findByProduct_ProductID(productUpdate.getProductId());
        productRepository.updateProduct(productUpdate, productsEntity,productDescriptionEntity,contentEntity);
    }

    @Override
    public void deleteProduct(Long[] ids) {
        productRepository.deleteByProductIDIn(ids);
        productDescriptionRepository.deleteByProduct_ProductIDIn(ids);
    }

    @Override
    public List<ProductDetailDTO> listSearchProductByKey(String key) {
        List<ProductDetailDTO> result = productRepository.findAllProductsByKey(key);
        return result;
    }

    //hàm lấy sản phẩm ra cho trang chủ nhưng giới hạn trong 30 sản phẩm và sắp xếp theo sản phẩm mới
    @Override
    public List<ProductDetailDTO> listProductForHomePage() {
        List<ProductsEntity> listProduct = productRepository.findTop30ByOrderByReleaseDateDesc();
        List<ProductDetailDTO> result = new ArrayList<>();
        for(ProductsEntity item : listProduct){
//            ProductDetailDTO productDisplayForHomePageDTO = productDisplayForHomePageConverter.toDisplayHomePage(item);
//            result.add(productDisplayForHomePageDTO);
        }
        return result;
    }

    @Override
    public List<ProductDetailDTO> listProductDetail() {
        return productRepository.listProductDetail();
    }

    @Override
    public Admin_ProductResponseDTO adminProduct() {
        Admin_ProductResponseDTO result = new Admin_ProductResponseDTO();
        try {
            List<OrderDetail_CountQuantityProductPerMonthDTO> quantityProductForChart = orderDetailRepository.listCountQuantityProductPerMonth();
            List<ProductDetailDTO> listTopProductSell = productRepository.findAllProductsWithTotalQuantityOrdered();
            List<ProductDetailDTO> listProduct = listProductDetail();
            result.setQuantityProductForChart(quantityProductForChart);
            result.setListTopProductSell(listTopProductSell);
            result.setListProductDetail(listProduct);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public List<ProductDetailDTO> getProductById(List<Integer>  ids) {
        return productRepository.getOneProductDetail(ids);
    }

    @Override
    public Admin_ProductDetailResponseDTO adminProductDetail(List<Integer>  idProducts) {
        Admin_ProductDetailResponseDTO result = new Admin_ProductDetailResponseDTO();
        try{
            List<ProductDetailDTO> productDetail = getProductById(idProducts);
            List<SuppliersEntity> listSupplier = suppliersService.getListSupplier();
            result.setProductDetail(productDetail);
            result.setListSupplier(listSupplier);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    //hàm lấy nhà cung cấp cho checkbox homepage
    @Override
    public Map<Integer, String> getBrandForCheckbox() {
        List<Object[]> resultQuery = productRepository.getListBrandForCheckBox();
        Map<Integer, String> result = new HashMap<>();
        for (Object[] rowOfResult : resultQuery) {
            Integer idProduct = (Integer) rowOfResult[0];
            String brand = (String) rowOfResult[1];
            result.put(idProduct, brand);
        }
        return result;
    }

    @Override
    public List<ProductDetailDTO> getProductByCheckbox(MultiValueMap<String, Object> params) {
        Product_ProductSearchCheckBoxDTO productSearchCheckBoxDTO = productCheckboxConverter.toProductCheckboxBuilder(params);
        List<ProductDetailDTO> listProduct = productRepository.getProductDetailByCheckbox(productSearchCheckBoxDTO);
        return listProduct;
    }

    @Override
    public List<Product_GetReceiptDTO> findAllProducts() {
        return productRepository.listProductForReceipt();
    }


}

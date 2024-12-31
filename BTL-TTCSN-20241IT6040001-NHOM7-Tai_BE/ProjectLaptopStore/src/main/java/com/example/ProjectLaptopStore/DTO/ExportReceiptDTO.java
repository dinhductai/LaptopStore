package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ExportReceiptDTO {
    private Integer adminId;
    private Integer productId;
    private Integer warehouseId;
    private int quantity;

}

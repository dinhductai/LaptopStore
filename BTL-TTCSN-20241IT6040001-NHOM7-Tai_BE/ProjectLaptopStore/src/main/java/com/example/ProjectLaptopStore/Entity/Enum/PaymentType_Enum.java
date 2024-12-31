
package com.example.ProjectLaptopStore.Entity.Enum;

public enum PaymentType_Enum {
    OFFLINE("OFFLINE"),
    ONLINE("ONLINE");


    private final String displayValue;

    PaymentType_Enum(String displayValue) {
        this.displayValue = displayValue;
    }

    public String getDisplayValue() {
        return displayValue;
    }
}


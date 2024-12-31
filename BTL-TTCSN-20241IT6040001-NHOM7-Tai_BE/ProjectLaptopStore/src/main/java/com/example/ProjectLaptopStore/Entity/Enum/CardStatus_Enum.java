package com.example.ProjectLaptopStore.Entity.Enum;

public enum CardStatus_Enum {
    active("Active"),
    checked_out("Checked Out");

    private final String displayValue;

    public String getDisplayValue() {
        return displayValue;
    }

    CardStatus_Enum(String displayName) {
        this.displayValue = displayName;
    }
}

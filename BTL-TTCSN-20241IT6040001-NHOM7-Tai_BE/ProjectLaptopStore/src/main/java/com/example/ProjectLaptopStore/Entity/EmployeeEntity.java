package com.example.ProjectLaptopStore.Entity;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "Employees")
public class EmployeeEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer EmployeeID;
    @Column(name = "Name",nullable = false)
    private String name;
    @Column(name = "CreatedDate",nullable = false)
    private Date createdDate;
    @Column(name = "Status")
    @Enumerated(EnumType.STRING)
    private Status_Enum status = Status_Enum.active;
    @ManyToOne
    @JoinColumn(name = "UserID")
    private UserEntity user;
}

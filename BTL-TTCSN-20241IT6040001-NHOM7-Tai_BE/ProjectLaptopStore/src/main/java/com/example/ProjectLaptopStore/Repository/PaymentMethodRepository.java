package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.PayMentMethodsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentMethodRepository extends JpaRepository<PayMentMethodsEntity,Integer> {
}

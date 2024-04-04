package com.example.EHotel.dtos;

import java.time.LocalDate;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddPaymentDTO {
    
    private Integer idRental;
    @NotNull
    private LocalDate paymentDate;
    @NotNull
    private String paymentMethod;
    @NotNull
    @Min(0)
    private Double amount;
    @NotNull
    private String paymentStatus;
}

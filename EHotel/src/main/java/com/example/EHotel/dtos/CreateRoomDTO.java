package com.example.EHotel.dtos;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreateRoomDTO {
    
    
    @NotNull
    @Min(1)
    private Integer roomNumber;
    @NotNull
    private Boolean availability;
    @NotNull
    @Min(0)
    private Double price;
    @NotNull
    private String view;
    @NotNull
    private Boolean extensible;
    @NotNull
    private String capacity;
    @NotNull
    private Integer idHotel;
}

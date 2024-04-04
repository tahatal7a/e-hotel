package com.example.EHotel.dtos;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RoomSearchCriteriaDTO {

    @NotNull
    private String roomCapacity;
    @NotNull
    @Min(0)
    private double maxPrice;
    private int hotelChainId;
    @NotNull
    @Min(1)
    @Max(5)
    private int startNumber;
    @NotNull
    private int roomsNumber;
    private LocalDate startDate;
    private LocalDate endDate;
}

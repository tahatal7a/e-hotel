package com.example.EHotel.dtos;

import java.time.LocalDate;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookingDTO {
 
    @NotNull
    @Pattern(regexp = "^\\d{3}-\\d{3}-\\d{3}$", message = "SIN must be in the format 123-456-789")
    private String sinCustomer;
    @NotNull
    @Size(min = 2, max = 50)
    private String firstname;
    @NotNull
    @Size(min = 2, max = 50)
    private String lastname;
    private LocalDate checkInDate = LocalDate.now();
    @NotNull
    @Min(1)
    private Integer streetNumber;
    @NotNull
    @Size(min = 2, max = 50)
    private String streetName;
    @NotNull
    @Size(min = 2, max = 50) 
    private String city;
    @NotNull
    @Pattern(regexp = "^[ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1} *\\d{1}[A-Z]{1}\\d{1}$", message = "Postal code must be in the format A1A 1A1")
    private String postalCode;
    @NotNull
    private String country;


    private Integer idRoom;
    @NotNull
    private LocalDate startDate;
    @NotNull
    private LocalDate endDate;

}

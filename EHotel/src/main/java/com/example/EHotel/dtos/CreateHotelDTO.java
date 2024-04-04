package com.example.EHotel.dtos;


import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CreateHotelDTO {
    
    private Integer idHotel;

    @NotNull
    @Size(min = 2, max = 50)
    private String name;

    @NotNull
    @Min(1)
    private Integer roomsNumber;

    @NotNull
    @Min(1)
    @Max(5)
    private Integer startNumber;
    
    @NotNull
    @Email
    private String email;
    
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

    @NotNull
    private Integer idHotelChain;

    @NotNull
    private String sinManager;
}

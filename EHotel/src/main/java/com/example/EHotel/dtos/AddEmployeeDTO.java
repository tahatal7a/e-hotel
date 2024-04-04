package com.example.EHotel.dtos;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
@NoArgsConstructor
public class AddEmployeeDTO {

    @NotNull
    @Pattern(regexp = "^\\d{3}-\\d{3}-\\d{3}$", message = "SIN must be in the format 123-456-789")
    private String sinEmployee;
    @NotNull
    @Size(min = 2, max = 50)
    private String firstname;
    @NotNull
    @Size(min = 2, max = 50)
    private String lastname;
    @NotNull
    private String role;
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
    private Integer idHotel;
}

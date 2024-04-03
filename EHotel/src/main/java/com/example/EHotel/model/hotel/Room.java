package com.example.EHotel.model.hotel;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "room")
public class Room {
    @Id
    @Column(name = "id_room")
    private Integer idRoom;
    
    @Column(name = "room_number", nullable = false)
    private Integer roomNumber;
    
    @Column(name = "availability", nullable = false)
    private Boolean availability;
    
    @Column(name = "price", nullable = false)
    private Double price;
    
    @Column(name = "view", nullable = false)
    private String view;
    
    @Column(name = "extensible", nullable = false)
    private Boolean extensible;
    
    @Column(name = "capacity", nullable = false)
    private String capacity;
    
    @ManyToOne
    @JoinColumn(name = "id_hotel", nullable = false)
    private Hotel hotel;
}

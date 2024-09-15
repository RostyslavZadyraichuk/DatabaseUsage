package com.zadyraichuk.entity;

import com.zadyraichuk.entity.vehicle.Vehicle;
import lombok.*;

import java.time.LocalDate;

@Setter
@Getter
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
public class Sale {

    @EqualsAndHashCode.Include
    private Integer id;

    private LocalDate date;

    private Double totalPrice;

    private Double discount;

    private VehicleShop shop;

    private Vehicle<?> vehicle;

    private Customer customer;

}

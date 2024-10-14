package com.zadyraichuk.entity.vehicle;

import lombok.*;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
public abstract class VehicleInfo<T extends VehicleType> {

    @EqualsAndHashCode.Exclude
    private Integer id;

    private String make;

    private String model;

    private Integer manufactureYear;

    private Double newVehiclePrice;

    private T type;

}

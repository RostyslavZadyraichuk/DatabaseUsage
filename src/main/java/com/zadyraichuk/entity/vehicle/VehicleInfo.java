package com.zadyraichuk.entity.vehicle;

import lombok.*;

@Setter
@Getter
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
public abstract class VehicleInfo<T extends VehicleType> {

    @EqualsAndHashCode.Include
    private Integer id;

    private String make;

    private String model;

    private Double newVehiclePrice;

    private T type;

}

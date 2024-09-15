package com.zadyraichuk.entity.vehicle;

import lombok.*;

@Getter
@Setter
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
public abstract class Vehicle<T extends VehicleInfo<?>> {

    @EqualsAndHashCode.Include
    private String vin;

    private Integer manufactureYear;

    private Double realPrice;

    private T info;

}

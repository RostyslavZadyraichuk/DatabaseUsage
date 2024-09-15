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

    private Color color;

    private Status status;

    private T type;


    public enum Color {
        WHITE, BLACK, RED, GREEN, GRAY
    }

    public enum Status {
        NEW, USED
    }

}

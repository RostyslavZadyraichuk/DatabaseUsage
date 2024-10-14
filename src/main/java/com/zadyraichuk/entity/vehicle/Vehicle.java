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

    private Double realPrice;

    private Color color;

    private Status status;

    private T info;

    public enum Color {
        WHITE, BLACK, RED, GREEN, GRAY
    }

    public enum Status {
        NEW, USED, SOLD
    }

}

package com.zadyraichuk.entity.vehicle;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class CarInfo extends VehicleInfo<CarInfo.CarType> {

    private Integer doorAmount;

    private Boolean isElectric;


    public enum CarType implements VehicleType {
        SEDAN, COUPLE, JEEP, TRUCK;

        @Override
        public String getTypeAsString() {
            return this.name();
        }
    }

}

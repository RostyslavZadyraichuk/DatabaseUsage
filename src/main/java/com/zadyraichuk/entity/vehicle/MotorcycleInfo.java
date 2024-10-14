package com.zadyraichuk.entity.vehicle;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MotorcycleInfo extends VehicleInfo<MotorcycleInfo.MotorcycleType> {

    private Boolean hasHelmetStorage;

    private RidingPosition ridingPosition;


    public enum MotorcycleType implements VehicleType {
        CHOPPER, SCOOTER, SPORT;

        @Override
        public String getTypeAsString() {
            return this.name();
        }
    }

    public enum RidingPosition {
        UPRIGHT, FORWARD_LEANING, SPORT
    }

}

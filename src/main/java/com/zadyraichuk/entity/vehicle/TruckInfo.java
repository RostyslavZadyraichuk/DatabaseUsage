package com.zadyraichuk.entity.vehicle;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class TruckInfo extends VehicleInfo<TruckInfo.TruckType> {

    private Double maxLoadCapacity;

    public enum TruckType implements VehicleType {
        AMERICAN, EUROPEAN;

        @Override
        public String getTypeAsString() {
            return this.name();
        }
    }

}

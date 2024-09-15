package com.zadyraichuk.entity;

import com.zadyraichuk.entity.vehicle.Vehicle;
import com.zadyraichuk.entity.vehicle.VehicleInfo;
import lombok.*;

import java.util.Map;
import java.util.Set;

@Getter
@Setter
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
public class VehicleShop {

    @EqualsAndHashCode.Include
    private Integer id;

    private String address;

    private String email;

    @Setter(AccessLevel.NONE)
    Set<Vehicle<?>> vehiclesInStock;

    @Setter(AccessLevel.NONE)
    Map<VehicleInfo<?>, Integer> availableVehicles;

    public void addToStock(Vehicle<?> vehicle) {
        vehiclesInStock.add(vehicle);
    }

    public void removeFromStock(Vehicle<?> vehicle) {
        vehiclesInStock.remove(vehicle);
    }

    public void addAvailable(VehicleInfo<?> vehicleInfo, int amount) {
        availableVehicles.put(vehicleInfo, amount);
    }

    public void removeAvailable(VehicleInfo<?> vehicleInfo) {
        availableVehicles.remove(vehicleInfo);
    }

}

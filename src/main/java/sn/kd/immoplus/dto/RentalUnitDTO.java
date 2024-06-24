package sn.kd.immoplus.dto;

import sn.kd.immoplus.model.Amenity;
import sn.kd.immoplus.model.Building;
import sn.kd.immoplus.model.RentalUnit;

import java.util.List;

public class RentalUnitDTO {
    private RentalUnit rentalUnit;
    private Building building;
    private List<Amenity> amenities;

    public RentalUnitDTO(RentalUnit rentalUnit, Building building, List<Amenity> amenities) {
        this.rentalUnit = rentalUnit;
        this.building = building;
        this.amenities = amenities;
    }

    // Getters and setters
}

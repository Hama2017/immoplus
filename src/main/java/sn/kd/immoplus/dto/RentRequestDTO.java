package sn.kd.immoplus.dto;
import sn.kd.immoplus.model.Building;
import sn.kd.immoplus.model.RentRequest;
import sn.kd.immoplus.model.RentalUnit;
import sn.kd.immoplus.model.User;

public class RentRequestDTO {
    private RentRequest rentRequest;
    private RentalUnit rentalUnit;
    private Building building;
    private User user;


    public RentRequestDTO(RentRequest rentRequest, RentalUnit rentalUnit, Building building) {
        this.rentRequest = rentRequest;
        this.rentalUnit = rentalUnit;
        this.building = building;
    }


    public RentRequestDTO(RentRequest rentRequest, RentalUnit rentalUnit, Building building, User user) {
        this.rentRequest = rentRequest;
        this.rentalUnit = rentalUnit;
        this.building = building;
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public RentRequest getRentRequest() {
        return rentRequest;
    }

    public RentalUnit getRentalUnit() {
        return rentalUnit;
    }

    public Building getBuilding() {
        return building;
    }


}

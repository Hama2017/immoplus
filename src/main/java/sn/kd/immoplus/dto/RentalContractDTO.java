package sn.kd.immoplus.dto;

import sn.kd.immoplus.model.RentalContract;
import sn.kd.immoplus.model.RentalUnit;
import sn.kd.immoplus.model.User;

public class RentalContractDTO {
    private RentalContract rentalContract;
    private User tenant;
    private RentalUnit rentalUnit;

    public RentalContractDTO(RentalContract rentalContract, User tenant, RentalUnit rentalUnit) {
        this.rentalContract = rentalContract;
        this.tenant = tenant;
        this.rentalUnit = rentalUnit;
    }

    // Getters and setters
    public RentalContract getRentalContract() {
        return rentalContract;
    }

    public void setRentalContract(RentalContract rentalContract) {
        this.rentalContract = rentalContract;
    }

    public User getTenant() {
        return tenant;
    }

    public void setTenant(User tenant) {
        this.tenant = tenant;
    }

    public RentalUnit getRentalUnit() {
        return rentalUnit;
    }

    public void setRentalUnit(RentalUnit rentalUnit) {
        this.rentalUnit = rentalUnit;
    }
}

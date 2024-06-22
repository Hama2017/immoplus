package sn.kd.immoplus.service;

import sn.kd.immoplus.model.RentalUnit;
import java.util.List;

public interface RentalUnitService {
    void save(RentalUnit rentalUnit);
    RentalUnit findById(int id);
    List<RentalUnit> findAll();
    void update(RentalUnit rentalUnit);
    void delete(int id);
}

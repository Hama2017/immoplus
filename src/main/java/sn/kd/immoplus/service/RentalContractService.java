package sn.kd.immoplus.service;

import sn.kd.immoplus.model.RentalContract;
import java.util.List;

public interface RentalContractService {
    void save(RentalContract rentalContract);
    RentalContract findById(int id);
    List<RentalContract> findAll();
    void update(RentalContract rentalContract);
    void delete(int id);
}

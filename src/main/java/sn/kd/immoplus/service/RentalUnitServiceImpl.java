package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.RentalUnitDAO;
import sn.kd.immoplus.model.RentalUnit;

import java.util.List;

public class RentalUnitServiceImpl implements RentalUnitService {

    private final RentalUnitDAO rentalUnitDAO = new RentalUnitDAO();

    @Override
    public void save(RentalUnit rentalUnit) {
        rentalUnitDAO.save(rentalUnit);
    }

    @Override
    public RentalUnit findById(int id) {
        return rentalUnitDAO.findById(id);
    }

    @Override
    public List<RentalUnit> findAll() {
        return rentalUnitDAO.findAll();
    }

    @Override
    public void update(RentalUnit rentalUnit) {
        rentalUnitDAO.update(rentalUnit);
    }

    @Override
    public void delete(int id) {
        RentalUnit rentalUnit = rentalUnitDAO.findById(id);
        if (rentalUnit != null) {
            rentalUnitDAO.delete(rentalUnit);
        }
    }
}

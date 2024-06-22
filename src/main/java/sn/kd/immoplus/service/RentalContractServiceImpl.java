package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.RentalContractDAO;
import sn.kd.immoplus.model.RentalContract;

import java.util.List;

public class RentalContractServiceImpl implements RentalContractService {

    private final RentalContractDAO rentalContractDAO = new RentalContractDAO();

    @Override
    public void save(RentalContract rentalContract) {
        rentalContractDAO.save(rentalContract);
    }

    @Override
    public RentalContract findById(int id) {
        return rentalContractDAO.findById(id);
    }

    @Override
    public List<RentalContract> findAll() {
        return rentalContractDAO.findAll();
    }

    @Override
    public void update(RentalContract rentalContract) {
        rentalContractDAO.update(rentalContract);
    }

    @Override
    public void delete(int id) {
        RentalContract rentalContract = rentalContractDAO.findById(id);
        if (rentalContract != null) {
            rentalContractDAO.delete(rentalContract);
        }
    }
}

package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.RentRequestDAO;
import sn.kd.immoplus.model.RentRequest;

import java.util.List;

public class RentRequestServiceImpl implements RentRequestService {

    private final RentRequestDAO rentRequestDAO = new RentRequestDAO();

    @Override
    public void save(RentRequest rentRequest) {
        rentRequestDAO.save(rentRequest);
    }

    @Override
    public RentRequest findById(int id) {
        return rentRequestDAO.findById(id);
    }

    @Override
    public List<RentRequest> findAll() {
        return rentRequestDAO.findAll();
    }

    @Override
    public void update(RentRequest rentRequest) {
        rentRequestDAO.update(rentRequest);
    }

    @Override
    public void delete(int id) {
        RentRequest rentRequest = rentRequestDAO.findById(id);
        if (rentRequest != null) {
            rentRequestDAO.delete(rentRequest);
        }
    }
}

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

    @Override
    public List<RentRequest> findByUserId(int userId) {
        return rentRequestDAO.findByUserId(userId);
    }


    @Override
    public List<RentRequest> findByOwnerId(int ownerId) {
        return rentRequestDAO.findByOwnerId(ownerId);
    }

    @Override
    public void updateStatus(int requestId, String status) {
        RentRequest rentRequest = rentRequestDAO.findById(requestId);
        if (rentRequest != null) {
            rentRequest.setStatus(status);
            rentRequestDAO.update(rentRequest);
        }
    }

    @Override
    public List<RentRequest> findAcceptedRequests(int userId) {
        return rentRequestDAO.findAcceptedRequests(userId);
    }

    @Override
    public void deleteByRentalUnitId(int rentalUnitId) {
        rentRequestDAO.deleteByRentalUnitId(rentalUnitId);
    }

    @Override
    public boolean hasUserRequested(int userId, int rentalUnitId) {
        return rentRequestDAO.hasUserRequested(userId, rentalUnitId);
    }

    @Override
    public void rejectRequestsForRentalUnit(int rentalUnitId) {
         rentRequestDAO.rejectRequestsForRentalUnit(rentalUnitId);
    }


}

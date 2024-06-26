package sn.kd.immoplus.service;

import sn.kd.immoplus.model.RentRequest;
import sn.kd.immoplus.model.RentalUnit;

import java.util.List;

public interface RentRequestService {
    void save(RentRequest rentRequest);
    RentRequest findById(int id);
    List<RentRequest> findAll();
    void update(RentRequest rentRequest);
    void delete(int id);
    List<RentRequest> findByUserId(int userId); // Ajoutez cette méthode
    List<RentRequest> findByOwnerId(int ownerId);
    void updateStatus(int requestId, String status);
    List<RentRequest> findAcceptedRequests(int userId);
    void deleteByRentalUnitId(int rentalUnitId); // Nouvelle méthode
    boolean hasUserRequested(int userId, int rentalUnitId); // Nouvelle méthode
    void rejectRequestsForRentalUnit(int rentalUnitId); // Nouvelle méthode


}

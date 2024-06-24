package sn.kd.immoplus.service;

import sn.kd.immoplus.model.RentRequest;
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

}

package sn.kd.immoplus.service;

import sn.kd.immoplus.model.RentRequest;
import java.util.List;

public interface RentRequestService {
    void save(RentRequest rentRequest);
    RentRequest findById(int id);
    List<RentRequest> findAll();
    void update(RentRequest rentRequest);
    void delete(int id);
}

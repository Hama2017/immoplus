package sn.kd.immoplus.service;

import sn.kd.immoplus.model.Amenity;
import java.util.List;

public interface AmenityService {
    void save(Amenity amenity);
    Amenity findById(int id);
    List<Amenity> findAll();
    void update(Amenity amenity);
    void delete(Amenity amenity);
}

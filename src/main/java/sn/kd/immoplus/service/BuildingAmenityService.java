package sn.kd.immoplus.service;

import sn.kd.immoplus.model.BuildingAmenity;
import java.util.List;

public interface BuildingAmenityService {
    void save(BuildingAmenity buildingAmenity);
    BuildingAmenity findById(int id);
    List<BuildingAmenity> findAll();
    void update(BuildingAmenity buildingAmenity);
    void delete(int id);
}

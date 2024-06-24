package sn.kd.immoplus.service;

import sn.kd.immoplus.model.Building;
import java.util.List;

public interface BuildingService {
    void save(Building building);
    Building findById(int id);
    List<Building> findAll();
    List<Building> getByUserId(int userId);
    void update(Building building);
    void delete(int id);
    void deleteBuildingAndUnits(int buildingId);

}

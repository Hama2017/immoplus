package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.BuildingAmenityDAO;
import sn.kd.immoplus.model.Amenity;
import sn.kd.immoplus.model.BuildingAmenity;

import java.util.List;

public class BuildingAmenityServiceImpl implements BuildingAmenityService {

    private final BuildingAmenityDAO buildingAmenityDAO = new BuildingAmenityDAO();

    @Override
    public void save(BuildingAmenity buildingAmenity) {
        buildingAmenityDAO.save(buildingAmenity);
    }

    @Override
    public BuildingAmenity findById(int id) {
        return buildingAmenityDAO.findById(id);
    }

    @Override
    public List<BuildingAmenity> findAll() {
        return buildingAmenityDAO.findAll();
    }

    @Override
    public void update(BuildingAmenity buildingAmenity) {
        buildingAmenityDAO.update(buildingAmenity);
    }

    @Override
    public void delete(int id) {
        BuildingAmenity buildingAmenity = buildingAmenityDAO.findById(id);
        if (buildingAmenity != null) {
            buildingAmenityDAO.delete(buildingAmenity);
        }
    }

    @Override
    public List<BuildingAmenity> getBuildingAmenities(int buildingId) {
        return buildingAmenityDAO.findByBuildingId(buildingId);
    }

    @Override
    public void deleteByBuildingId(int buildingId) {
        buildingAmenityDAO.deleteByBuildingId(buildingId);
    }
    @Override
    public List<Amenity> findAmenitiesByBuildingId(int buildingId) {
        return buildingAmenityDAO.findAmenitiesByBuildingId(buildingId);
    }
}

package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.*;
import sn.kd.immoplus.model.Building;
import sn.kd.immoplus.model.RentalUnit;

import java.util.List;

public class BuildingServiceImpl implements BuildingService {

    private BuildingDAO buildingDAO = new BuildingDAO();
    private RentalUnitDAO rentalUnitDAO = new RentalUnitDAO(); // Assurez-vous d'avoir un DAO pour RentalUnit
    private BuildingAmenityDAO buildingAmenityDAO = new BuildingAmenityDAO();


    @Override
    public void save(Building building) {
        buildingDAO.save(building);
    }

    @Override
    public Building findById(int id) {
        return buildingDAO.findById((long) id);
    }

    @Override
    public List<Building> findAll() {
        return buildingDAO.findAll();
    }

    @Override
    public void update(Building building) {
        buildingDAO.update(building);
    }

    @Override
    public void delete(int id) {
        Building building = buildingDAO.findById((long) id);
        if (building != null) {
            buildingDAO.delete(building);
        }
    }


    @Override
    public List<Building> getByUserId(int userId) {
        return buildingDAO.getByUserId(userId);
    }

    @Override
    public void deleteBuildingAndUnits(int buildingId) {

        // Suppression des relations BuildingAmenity
        buildingAmenityDAO.deleteByBuildingId(buildingId);

        // Suppression des appartements associés
        List<RentalUnit> rentalUnits = rentalUnitDAO.findByBuildingId(buildingId);
        for (RentalUnit unit : rentalUnits) {
            rentalUnitDAO.delete(unit);
        }
        // Suppression de l'immeuble
        Building building = buildingDAO.findById((long) buildingId);
        if (building != null) {
            buildingDAO.delete(building);
        }
    }

}

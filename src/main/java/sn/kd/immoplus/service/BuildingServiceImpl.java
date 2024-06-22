package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.AmenityDAO;
import sn.kd.immoplus.DAO.BuildingDAO;
import sn.kd.immoplus.model.Building;
import sn.kd.immoplus.DAO.GenericDAO;
import java.util.List;

public class BuildingServiceImpl implements BuildingService {

    private BuildingDAO buildingDAO = new BuildingDAO();

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
}

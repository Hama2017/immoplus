package sn.kd.immoplus.DAO;

import sn.kd.immoplus.model.Building;

public class BuildingDAO extends GenericDAOImpl<Building, Long> {

    public BuildingDAO() {
        super(Building.class);
    }
}

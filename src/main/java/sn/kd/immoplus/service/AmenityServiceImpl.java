package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.AmenityDAO;
import sn.kd.immoplus.model.Amenity;

import java.util.List;

public class AmenityServiceImpl implements AmenityService {

    private AmenityDAO amenityDAO = new AmenityDAO();

    @Override
    public void save(Amenity entity) {
        amenityDAO.save(entity);
    }

    @Override
    public Amenity findById(int id) {
        return amenityDAO.findById((long) id);
    }

    @Override
    public List<Amenity> findAll() {
        return amenityDAO.findAll();
    }

    @Override
    public void update(Amenity entity) {
        amenityDAO.update(entity);
    }

    @Override
    public void delete(Amenity entity) {
        amenityDAO.delete(entity);
    }
}

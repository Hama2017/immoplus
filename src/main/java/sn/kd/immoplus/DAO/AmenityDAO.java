package sn.kd.immoplus.DAO;
import sn.kd.immoplus.model.Amenity;

public class AmenityDAO extends GenericDAOImpl<Amenity, Long> {

    public AmenityDAO() {
        super(Amenity.class);
    }
}

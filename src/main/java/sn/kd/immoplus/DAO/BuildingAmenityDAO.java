package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.Amenity;
import sn.kd.immoplus.model.BuildingAmenity;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;

public class BuildingAmenityDAO extends GenericDAOImpl<BuildingAmenity, Integer> {

    public BuildingAmenityDAO() {
        super(BuildingAmenity.class);
    }

    public List<BuildingAmenity> findByBuildingId(int buildingId) {
        Session session = HibernateUtil.getSession();
        Query<BuildingAmenity> query = session.createQuery("from BuildingAmenity where buildingId = :buildingId", BuildingAmenity.class);
        query.setParameter("buildingId", buildingId);
        List<BuildingAmenity> amenities = query.list();
        session.close();
        return amenities;
    }

    public void deleteByBuildingId(int buildingId) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Query query = session.createQuery("delete from BuildingAmenity where buildingId = :buildingId");
            query.setParameter("buildingId", buildingId);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public List<Amenity> findAmenitiesByBuildingId(int buildingId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT a FROM Amenity a JOIN BuildingAmenity ba ON a.id = ba.amenityId WHERE ba.buildingId = :buildingId";
            Query<Amenity> query = session.createQuery(hql, Amenity.class);
            query.setParameter("buildingId", buildingId);
            return query.list();
        }
    }
}

package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.RentalUnit;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;

public class RentalUnitDAO extends GenericDAOImpl<RentalUnit, Integer> {

    public RentalUnitDAO() {
        super(RentalUnit.class);
    }

    public List<RentalUnit> findByBuildingId(int buildingId) {
        Session session = HibernateUtil.getSession();
        String hql = "FROM RentalUnit WHERE buildingId = :buildingId";
        Query<RentalUnit> query = session.createQuery(hql, RentalUnit.class);
        query.setParameter("buildingId", buildingId);
        List<RentalUnit> rentalUnits = query.list();
        session.close();
        return rentalUnits;
    }

    public List<RentalUnit> findByUserId(int userId) {
        Session session = HibernateUtil.getSession();
        Query<RentalUnit> query = session.createQuery(
                "SELECT ru FROM RentalUnit ru JOIN Building b ON ru.buildingId = b.id WHERE b.userId = :userId",
                RentalUnit.class
        );
        query.setParameter("userId", userId);
        List<RentalUnit> rentalUnits = query.list();
        session.close();
        return rentalUnits;
    }

    public List<RentalUnit> findAll(Integer priceMin, Integer priceMax, Integer amenityId) {
        Session session = HibernateUtil.getSession();
        StringBuilder sql = new StringBuilder("SELECT ru.* FROM rental_unit ru");

        if (amenityId != null) {
            sql.append(" JOIN building_amenities ba ON ru.building_id = ba.building_id");
        }

        sql.append(" WHERE 1=1");

        if (priceMin != null) {
            sql.append(" AND ru.monthly_rent >= :priceMin");
        }
        if (priceMax != null) {
            sql.append(" AND ru.monthly_rent <= :priceMax");
        }
        if (amenityId != null) {
            sql.append(" AND ba.amenity_id = :amenityId");
        }

        NativeQuery<RentalUnit> query = session.createNativeQuery(sql.toString(), RentalUnit.class);

        if (priceMin != null) {
            query.setParameter("priceMin", priceMin);
        }
        if (priceMax != null) {
            query.setParameter("priceMax", priceMax);
        }
        if (amenityId != null) {
            query.setParameter("amenityId", amenityId);
        }

        List<RentalUnit> rentalUnits = query.list();
        session.close();
        return rentalUnits;
    }



    public List<RentalUnit> findAvailableUnits(Integer priceMin, Integer priceMax, Integer amenityId) {
        try (Session session = HibernateUtil.getSession()) {
            StringBuilder sql = new StringBuilder("SELECT ru.* FROM rental_unit ru WHERE ru.id NOT IN (SELECT rc.rental_unit_id FROM rental_contract rc WHERE rc.status = 'Validée')");

            if (priceMin != null) {
                sql.append(" AND ru.monthly_rent >= :priceMin");
            }
            if (priceMax != null) {
                sql.append(" AND ru.monthly_rent <= :priceMax");
            }
            if (amenityId != null) {
                sql.append(" AND ru.id IN (SELECT ba.rental_unit_id FROM building_amenity ba WHERE ba.amenity_id = :amenityId)");
            }

            Query<RentalUnit> query = session.createNativeQuery(sql.toString(), RentalUnit.class);

            if (priceMin != null) {
                query.setParameter("priceMin", priceMin);
            }
            if (priceMax != null) {
                query.setParameter("priceMax", priceMax);
            }
            if (amenityId != null) {
                query.setParameter("amenityId", amenityId);
            }

            return query.list();
        }
    }



}

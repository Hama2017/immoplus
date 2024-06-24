package sn.kd.immoplus.DAO;

import org.hibernate.Session;
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
}

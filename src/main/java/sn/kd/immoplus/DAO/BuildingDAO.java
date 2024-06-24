package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.Building;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.ArrayList;
import java.util.List;

public class BuildingDAO extends GenericDAOImpl<Building, Long> {

    public BuildingDAO() {
        super(Building.class);
    }

    public List<Building> getByUserId(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            String sql = "SELECT * FROM buildings WHERE id_user = :userId";
            Query<Building> query = session.createNativeQuery(sql, Building.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }


}

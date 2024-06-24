package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import sn.kd.immoplus.model.RentalContract;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;

public class RentalContractDAO extends GenericDAOImpl<RentalContract, Integer> {

    public RentalContractDAO() {
        super(RentalContract.class);
    }

    public List<RentalContract> findByUserId(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            String sql = "SELECT rc.* FROM rental_contract rc " +
                    "JOIN rental_unit ru ON rc.rental_unit_id = ru.id " +
                    "JOIN buildings b ON ru.building_id = b.id " +
                    "WHERE b.id_user = :userId";
            NativeQuery<RentalContract> query = session.createNativeQuery(sql, RentalContract.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}

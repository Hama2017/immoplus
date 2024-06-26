package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.RentRequest;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;

public class RentRequestDAO extends GenericDAOImpl<RentRequest, Integer> {

    public RentRequestDAO() {
        super(RentRequest.class);
    }

    public List<RentRequest> findByUserId(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            Query<RentRequest> query = session.createQuery("FROM RentRequest WHERE userId = :userId", RentRequest.class);
            query.setParameter("userId", userId);
            return query.list();
        }
    }

    public List<RentRequest> findByOwnerId(int ownerId) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "SELECT rr FROM RentRequest rr JOIN RentalUnit ru ON rr.rentalUnitId = ru.id JOIN Building b ON ru.buildingId = b.id WHERE b.userId = :ownerId";
            Query<RentRequest> query = session.createQuery(hql, RentRequest.class);
            query.setParameter("ownerId", ownerId);
            return query.list();
        }
    }



    public List<RentRequest> findAcceptedRequests(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            String sql = "SELECT rr.* FROM rent_requests rr " +
                    "JOIN rental_unit ru ON rr.rental_unit_id = ru.id " +
                    "JOIN buildings b ON ru.building_id = b.id " +
                    "LEFT JOIN rental_contract rc ON rr.rental_unit_id = rc.rental_unit_id AND rr.id_user = rc.user_id " +
                    "WHERE rr.status = 'Validée' AND b.id_user = :userId AND rc.id IS NULL";
            NativeQuery<RentRequest> query = session.createNativeQuery(sql, RentRequest.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void deleteByRentalUnitId(int rentalUnitId) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "DELETE FROM RentRequest WHERE rentalUnitId = :rentalUnitId";
            Query<?> query = session.createQuery(hql);
            query.setParameter("rentalUnitId", rentalUnitId);
            session.beginTransaction();
            query.executeUpdate();
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public boolean hasUserRequested(int userId, int rentalUnitId) {
        try (Session session = HibernateUtil.getSession()) {
            String sql = "SELECT COUNT(*) FROM rent_requests WHERE id_user = :userId AND rental_unit_id = :rentalUnitId";
            Query<Long> query = session.createNativeQuery(sql, Long.class);
            query.setParameter("userId", userId);
            query.setParameter("rentalUnitId", rentalUnitId);
            return query.uniqueResult() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void rejectRequestsForRentalUnit(int rentalUnitId) {
        try (Session session = HibernateUtil.getSession()) {
            session.beginTransaction();
            String hql = "UPDATE RentRequest SET status = 'Refusée' WHERE rentalUnitId = :rentalUnitId AND status = 'En attente'";
            Query query = session.createQuery(hql);
            query.setParameter("rentalUnitId", rentalUnitId);
            query.executeUpdate();
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}

package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.Notification;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;


public class NotificationDAO extends GenericDAOImpl<Notification, Integer> {

    public NotificationDAO() {
        super(Notification.class);
    }

    public List<Notification> findByUserId(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "FROM Notification WHERE userId = :userId ORDER BY id DESC";
            return session.createQuery(hql, Notification.class)
                    .setParameter("userId", userId)
                    .list();
        }
    }


    public void deleteAllByUserId(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "DELETE FROM Notification WHERE userId = :userId";
            session.beginTransaction();
            session.createQuery(hql)
                    .setParameter("userId", userId)
                    .executeUpdate();
            session.getTransaction().commit();
        }
    }

    public int countUnreadNotifications(int userId) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "SELECT COUNT(n) FROM Notification n WHERE n.userId = :userId AND n.status = 0";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("userId", userId);
            return query.uniqueResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}

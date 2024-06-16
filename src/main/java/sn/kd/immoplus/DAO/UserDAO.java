package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.User;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;

public class UserDAO extends GenericDAOImpl<User, Long> {

    public UserDAO() {

        super(User.class);
    }

    public User findByEmail(String email) {
        Session session = HibernateUtil.getSession();
        User user = null;
        try {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            user = query.uniqueResult();
        } finally {
            session.close();
        }
        return user;
    }

    public boolean emailExists(String email) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "SELECT 1 FROM User WHERE email = :email";
            Query query = session.createQuery(hql);
            query.setParameter("email", email);
            return query.uniqueResult() != null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
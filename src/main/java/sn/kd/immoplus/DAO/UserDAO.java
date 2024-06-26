package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.Transaction;
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

    public boolean phoneNumberExists(String phoneNumber) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "SELECT 1 FROM User WHERE phoneNumber = :phoneNumber";
            Query query = session.createQuery(hql);
            query.setParameter("phoneNumber", phoneNumber);
            return query.uniqueResult() != null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(int userId, String newPassword) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession()) {
            transaction = session.beginTransaction();

            String hql = "UPDATE User SET password = :newPassword WHERE id = :userId";
            Query query = session.createQuery(hql);
            query.setParameter("newPassword", newPassword);
            query.setParameter("userId", userId);

            int result = query.executeUpdate();
            transaction.commit();

            return result > 0;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfile(int userId, String firstName, String lastName, String email, String phoneNumber, String address) {
        try (Session session = HibernateUtil.getSession()) {
            Transaction transaction = session.beginTransaction();

            User user = session.get(User.class, userId);
            if (user == null) {
                transaction.rollback();
                return false;
            }

            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);

            session.update(user);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



}
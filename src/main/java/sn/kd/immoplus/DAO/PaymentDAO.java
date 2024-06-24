package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.Payment;
import sn.kd.immoplus.util.HibernateUtil;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class PaymentDAO extends GenericDAOImpl<Payment, Integer> {

    public PaymentDAO() {
        super(Payment.class);
    }

    public void deleteByRentalContractId(int rentalContractId) {
        try (Session session = HibernateUtil.getSession()) {
            String hql = "DELETE FROM Payment WHERE rentalContractId = :rentalContractId";
            Query<?> query = session.createQuery(hql);
            query.setParameter("rentalContractId", rentalContractId);
            session.beginTransaction();
            query.executeUpdate();
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Payment> findByContractId(int contractId) {
        try (Session session = HibernateUtil.getSession()) {
            String sql = "SELECT * FROM payments WHERE rental_contract_id = :contractId";
            NativeQuery<Payment> query = session.createNativeQuery(sql, Payment.class);
            query.setParameter("contractId", contractId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void payPayment(int paymentId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession()) {
            transaction = session.beginTransaction();
            Payment payment = session.get(Payment.class, paymentId);
            if (payment != null) {
                payment.setPaidDate(LocalDate.now().format(DateTimeFormatter.ofPattern("MM-dd-yyyy")));
                payment.setStatus("Validé");
                session.update(payment);
                transaction.commit();
            }
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}

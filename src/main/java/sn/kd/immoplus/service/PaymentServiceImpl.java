package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.PaymentDAO;
import sn.kd.immoplus.model.Payment;

import java.util.List;

public class PaymentServiceImpl implements PaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    public void save(Payment payment) {
        paymentDAO.save(payment);
    }

    @Override
    public Payment findById(int id) {
        return paymentDAO.findById(id);
    }

    @Override
    public List<Payment> findAll() {
        return paymentDAO.findAll();
    }

    @Override
    public void update(Payment payment) {
        paymentDAO.update(payment);
    }

    @Override
    public void delete(int id) {
        Payment payment = paymentDAO.findById(id);
        if (payment != null) {
            paymentDAO.delete(payment);
        }
    }
}

package sn.kd.immoplus.DAO;

import sn.kd.immoplus.model.Payment;

public class PaymentDAO extends GenericDAOImpl<Payment, Integer> {

    public PaymentDAO() {
        super(Payment.class);
    }
}

package sn.kd.immoplus.service;

import sn.kd.immoplus.model.Payment;
import java.util.List;

public interface PaymentService {
    void save(Payment payment);
    Payment findById(int id);
    List<Payment> findAll();
    void update(Payment payment);
    void delete(int id);
    void deleteByRentalContractId(int rentalContractId); // Nouvelle méthode
    void createPaymentsForContract(int contractId, String startDate, int months, int amount); // Nouvelle méthode
    public List<Payment> findByContractId(int contractId);
    public void payPayment(int paymentId);
}

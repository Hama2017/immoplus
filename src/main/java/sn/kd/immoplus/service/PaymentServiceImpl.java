package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.PaymentDAO;
import sn.kd.immoplus.model.Payment;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

    @Override
    public void deleteByRentalContractId(int rentalContractId) {
        paymentDAO.deleteByRentalContractId(rentalContractId);
    }

    @Override
    public void createPaymentsForContract(int contractId, String startDate, int months, int amount) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = LocalDate.parse(startDate, formatter);
        List<Payment> payments = new ArrayList<>();

        for (int i = 0; i < months; i++) {
            LocalDate paymentDate = start.plusMonths(i);
            Payment payment = new Payment();
            payment.setRentalContractId(contractId);
            payment.setPaymentDate(paymentDate.format(formatter));
            payment.setAmount(amount);
            payment.setStatus("En attente");
            payment.setDateCreated(LocalDate.now().format(formatter));
            payments.add(payment);
        }

        payments.forEach(this::save);
    }

    @Override
    public List<Payment> findByContractId(int contractId) {
        return paymentDAO.findByContractId(contractId);
    }

    @Override
    public void payPayment(int paymentId) {
     paymentDAO.payPayment(paymentId);
    }


}

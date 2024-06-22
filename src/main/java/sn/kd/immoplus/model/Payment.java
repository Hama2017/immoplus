package sn.kd.immoplus.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "payments")
@Data
@NoArgsConstructor
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "rental_contract_id", nullable = false)
    private int rentalContractId;

    @Column(name = "payment_date", nullable = false)
    private String paymentDate;

    @Column(name = "amount", nullable = false)
    private int amount;

    @Column(name = "status", nullable = false, length = 100)
    private String status;

    @Column(name = "paid_date", nullable = true)
    private String paidDate;

    @Column(name = "date_created", nullable = false, length = 100)
    private String dateCreated;
}

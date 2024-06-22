package sn.kd.immoplus.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "rental_contract")
@Data
@NoArgsConstructor
public class RentalContract {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @Column(name = "rental_unit_id", nullable = false)
    private int rentalUnitId;

    @Column(name = "start_date", nullable = false)
    private String startDate;

    @Column(name = "end_date", nullable = false)
    private String endDate;

    @Column(name = "amount", nullable = false)
    private int amount;

    @Column(name = "status", nullable = false, length = 225)
    private String status;

    @Column(name = "date_created", nullable = false, length = 100)
    private String dateCreated;
}

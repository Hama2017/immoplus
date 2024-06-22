package sn.kd.immoplus.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "rent_requests")
@Data
@NoArgsConstructor
public class RentRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "id_user", nullable = false)
    private int userId;

    @Column(name = "expected_start_date", nullable = false)
    private String expectedStartDate;

    @Column(name = "months_number", nullable = false)
    private int monthsNumber;

    @Column(name = "persons_number", nullable = false)
    private int personsNumber;

    @Column(name = "rental_unit_id", nullable = false)
    private int rentalUnitId;

    @Column(name = "status", nullable = false, length = 100)
    private String status;

    @Column(name = "date_created", nullable = false, length = 100)
    private String dateCreated;
}

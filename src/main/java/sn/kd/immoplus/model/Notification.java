package sn.kd.immoplus.model;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "notifications")
@Data
@NoArgsConstructor
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "id_user", nullable = false)
    private int userId;

    @Column(name = "title", nullable = false, length = 100)
    private String title;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "rental_contract_id", nullable = true)
    private Integer rentalContractId;

    @Column(name = "rent_request_id", nullable = true)
    private Integer rentRequestId;

    @Column(name = "status", nullable = false)
    private int status;

    @Column(name = "date_created", nullable = false, length = 100)
    private String dateCreated;
}

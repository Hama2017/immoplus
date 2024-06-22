package sn.kd.immoplus.model;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "buildings")
@Data
@NoArgsConstructor
public class Building {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "adress", nullable = false, length = 200)
    private String adress;

    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "floor_number", nullable = false)
    private int floorNumber;

    @Column(name = "img_path", nullable = false, length = 225)
    private String imgPath;

    @Column(name = "date_created", nullable = false, length = 100)
    private String dateCreated;

    @Column(name = "id_user", nullable = false)
    private int userId;
}

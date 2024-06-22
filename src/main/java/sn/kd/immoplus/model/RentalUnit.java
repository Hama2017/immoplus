package sn.kd.immoplus.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "rental_unit")
@Data
@NoArgsConstructor
public class RentalUnit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "building_id", nullable = false)
    private int buildingId;

    @Column(name = "unit_number", nullable = false, length = 100)
    private String unitNumber;

    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "floor_level", nullable = false)
    private int floorLevel;

    @Column(name = "number_of_rooms", nullable = false)
    private int numberOfRooms;

    @Column(name = "area", nullable = false)
    private int area;

    @Column(name = "monthly_rent", nullable = false)
    private int monthlyRent;

    @Column(name = "date_created", nullable = false, length = 100)
    private String dateCreated;
}

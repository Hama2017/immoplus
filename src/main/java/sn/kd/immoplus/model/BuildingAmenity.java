package sn.kd.immoplus.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "building_amenities")
@Data
@NoArgsConstructor
public class BuildingAmenity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "building_id", nullable = false)
    private int buildingId;

    @Column(name = "amenity_id", nullable = false)
    private int amenityId;
}

package sn.kd.immoplus.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false, length = 200)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 100)
    private String lastName;

    @Column(name = "adress", nullable = false, length = 200)
    private String address;

    @Column(name = "phone_number", nullable = false, length = 15)
    private String phoneNumber;

    @Column(name = "email", nullable = false, length = 200)
    private String email;

    @Column(name = "password", nullable = false, length = 225)
    private String password;

    @Column(name = "role", nullable = false, length = 100)
    private String role;

    @Column(name = "status", nullable = false)
    private int status;

    @Column(name = "date_created", nullable = false)
    private Date dateCreated;
}

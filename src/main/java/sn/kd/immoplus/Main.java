package sn.kd.immoplus;

import sn.kd.immoplus.model.User;
import sn.kd.immoplus.util.HibernateUtil;
import org.hibernate.Session;

import java.util.Date;


public class Main {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSession();
        session.beginTransaction();

        User entity = new User();
        entity.setFirstName("John");
        entity.setLastName("Doe");
        entity.setAddress("123 Main Street");
        entity.setPhoneNumber("555-1234");
        entity.setEmail("john.doe@example.com");
        entity.setPassword("password123");
        entity.setRole("user");
        entity.setStatus(1);

        //entity.setDateCreated(new Date());

        session.save(entity);
        session.getTransaction().commit();
        session.close();

        HibernateUtil.shutdown();
    }
}

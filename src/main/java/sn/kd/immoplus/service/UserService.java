package sn.kd.immoplus.service;

import sn.kd.immoplus.model.User;

import java.util.List;

public interface UserService {
    void save(User entity);
    User findById(int id);
    User findByEmail(String email);
    boolean emailExists(String email);
    List<User> findAll();
    void update(User entity);
    boolean updatePassword(int userId, String newPassword);
    boolean updateProfile(int userId, String firstName, String lastName, String email, String phoneNumber, String address);
    void delete(User entity);
    boolean phoneNumberExists(String phoneNumber);

}

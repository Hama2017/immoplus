package sn.kd.immoplus.service;


import sn.kd.immoplus.DAO.UserDAO;
import sn.kd.immoplus.model.User;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO = new UserDAO();

    @Override
    public void save(User entity) {
        userDAO.save(entity);
    }

    @Override
    public User findById(int id) {
        return userDAO.findById((long) id);
    }

    @Override
    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    @Override
    public boolean emailExists(String email) {
        return userDAO.emailExists(email);
    }

    @Override
    public List<User> findAll() {
        return userDAO.findAll();
    }

    @Override
    public void update(User entity) {
        userDAO.update(entity);
    }

    @Override
    public boolean updatePassword(int userId, String newPassword) {
        return userDAO.updatePassword(userId, newPassword);
    }

    @Override
    public boolean updateProfile(int userId, String firstName, String lastName, String email, String phoneNumber, String address) {
        return userDAO.updateProfile( userId,  firstName,  lastName,  email,  phoneNumber,  address);
    }

    @Override
    public void delete(User entity) {
        userDAO.delete(entity);
    }

    @Override
    public boolean phoneNumberExists(String phoneNumber) {
        return userDAO.phoneNumberExists(phoneNumber);
    }

}

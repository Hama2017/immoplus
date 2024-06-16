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
    public User findById(Long id) {
        return userDAO.findById(id);
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
    public void delete(User entity) {
        userDAO.delete(entity);
    }
}

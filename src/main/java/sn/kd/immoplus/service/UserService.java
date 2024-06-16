package sn.kd.immoplus.service;

import sn.kd.immoplus.model.User;

import java.util.List;

public interface UserService {

    void save(User entity);
    User findById(Long id);
    List<User> findAll();
    void update(User entity);
    void delete(User entity);
}

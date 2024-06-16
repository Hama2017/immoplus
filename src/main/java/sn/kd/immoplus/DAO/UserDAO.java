package sn.kd.immoplus.DAO;

import sn.kd.immoplus.model.User;

import java.util.List;

public class UserDAO extends GenericDAOImpl<User, Long> {

    public UserDAO() {

        super(User.class);
    }
}
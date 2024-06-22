package sn.kd.immoplus.DAO;

import sn.kd.immoplus.model.Notification;

public class NotificationDAO extends GenericDAOImpl<Notification, Integer> {

    public NotificationDAO() {
        super(Notification.class);
    }
}

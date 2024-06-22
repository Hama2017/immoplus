package sn.kd.immoplus.service;

import sn.kd.immoplus.model.Notification;
import java.util.List;

public interface NotificationService {
    void save(Notification notification);
    Notification findById(int id);
    List<Notification> findAll();
    void update(Notification notification);
    void delete(int id);
}

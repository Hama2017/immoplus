package sn.kd.immoplus.service;

import sn.kd.immoplus.model.Notification;
import java.util.List;

public interface NotificationService {
    void save(Notification notification);
    Notification findById(int id);
    List<Notification> findAll();
    void update(Notification notification);
    void delete(int id);
    List<Notification> getNotificationsByUserId(int userId);
    void markAsRead(int notificationId);
    void deleteNotification(Notification notification);
    void deleteAllNotificationsByUserId(int userId);
    int getUnreadNotificationsCount(int userId);

    }

package sn.kd.immoplus.service;
import sn.kd.immoplus.DAO.NotificationDAO;
import sn.kd.immoplus.model.Notification;
import java.util.List;

public class NotificationServiceImpl implements NotificationService {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    public void save(Notification notification) {
        notificationDAO.save(notification);
    }

    @Override
    public Notification findById(int id) {
        return notificationDAO.findById(id);
    }

    @Override
    public List<Notification> findAll() {
        return notificationDAO.findAll();
    }

    @Override
    public void update(Notification notification) {
        notificationDAO.update(notification);
    }

    @Override
    public void delete(int id) {
        Notification notification = notificationDAO.findById(id);
        if (notification != null) {
            notificationDAO.delete(notification);
        }
    }
}

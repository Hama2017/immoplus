package sn.kd.immoplus.DAO;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import sn.kd.immoplus.model.Setting;
import sn.kd.immoplus.util.HibernateUtil;

import java.util.List;

public class SettingDAO extends GenericDAOImpl<Setting, Long> {

    public SettingDAO() {
        super(Setting.class);
    }


    public boolean updateFileConfig(String allowedFileTypes, int maxFileSize) {
        try (Session session = HibernateUtil.getSession()) {
            Transaction transaction = session.beginTransaction();

            Setting setting = session.get(Setting.class, 1L); // Assuming the ID of the setting is 1
            if (setting == null) {
                transaction.rollback();
                return false;
            }

            setting.setAllowedFileTypes(allowedFileTypes);
            setting.setMaxFileSize(maxFileSize);

            session.update(setting);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

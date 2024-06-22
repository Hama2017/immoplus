package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.SettingDAO;
import sn.kd.immoplus.model.Setting;

import java.util.List;

public class SettingServiceImpl implements SettingService {

    private SettingDAO settingDAO = new SettingDAO();

    @Override
    public void save(Setting entity) {
        settingDAO.save(entity);
    }

    @Override
    public Setting findById(int id) {
        return settingDAO.findById((long)id);
    }

    @Override
    public List<Setting> findAll() {
        return settingDAO.findAll();
    }

    @Override
    public void update(Setting entity) {
        settingDAO.update(entity);
    }

    @Override
    public void delete(Setting entity) {
        settingDAO.delete(entity);
    }

    @Override
    public boolean updateFileConfig(String allowedFileTypes, int maxFileSize) {
        return settingDAO.updateFileConfig(allowedFileTypes, maxFileSize);
    }


}

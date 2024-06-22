package sn.kd.immoplus.service;

import sn.kd.immoplus.DAO.SettingDAO;
import sn.kd.immoplus.model.Setting;

import java.util.List;

public interface SettingService {

    void save(Setting entity);

    Setting findById(int id);

    List<Setting> findAll();

    void update(Setting entity);

    void delete(Setting entity);

    boolean updateFileConfig(String allowedFileTypes, int maxFileSize);

}

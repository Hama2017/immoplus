package sn.kd.immoplus.DAO;


import org.hibernate.Session;
import org.hibernate.Transaction;
import sn.kd.immoplus.util.HibernateUtil;

import java.io.Serializable;
import java.util.List;

public abstract class GenericDAOImpl<T, ID extends Serializable> implements GenericDAO<T, ID> {

    private Class<T> entityClass;

    public GenericDAOImpl(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    @Override
    public void save(T entity) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession()) {
            transaction = session.beginTransaction();
            session.save(entity);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public T findById(ID id) {
        try (Session session = HibernateUtil.getSession()) {
            return session.get(entityClass, id);
        }
    }

    @Override
    public List<T> findAll() {
        try (Session session = HibernateUtil.getSession()) {
            return session.createQuery("from " + entityClass.getName(), entityClass).list();
        }
    }

    @Override
    public void update(T entity) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession()) {
            transaction = session.beginTransaction();
            session.update(entity);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void delete(T entity) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession()) {
            transaction = session.beginTransaction();
            session.delete(entity);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }
}

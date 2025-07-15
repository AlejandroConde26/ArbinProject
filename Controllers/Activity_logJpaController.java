/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import Models.Activity_log;
import Models.User;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author USER
 */
public class Activity_logJpaController implements Serializable {

    public Activity_logJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    public Activity_logJpaController(){
        emf =Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public void create(Activity_log activity_log) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            User user_id = activity_log.getUser_id();
            if (user_id != null) {
                user_id = em.getReference(user_id.getClass(), user_id.getId_users());
                activity_log.setUser_id(user_id);
            }
            em.persist(activity_log);
            if (user_id != null) {
                user_id.getListActivity_log().add(activity_log);
                user_id = em.merge(user_id);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Activity_log activity_log) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Activity_log persistentActivity_log = em.find(Activity_log.class, activity_log.getActivity_log_id());
            User user_idOld = persistentActivity_log.getUser_id();
            User user_idNew = activity_log.getUser_id();
            if (user_idNew != null) {
                user_idNew = em.getReference(user_idNew.getClass(), user_idNew.getId_users());
                activity_log.setUser_id(user_idNew);
            }
            activity_log = em.merge(activity_log);
            if (user_idOld != null && !user_idOld.equals(user_idNew)) {
                user_idOld.getListActivity_log().remove(activity_log);
                user_idOld = em.merge(user_idOld);
            }
            if (user_idNew != null && !user_idNew.equals(user_idOld)) {
                user_idNew.getListActivity_log().add(activity_log);
                user_idNew = em.merge(user_idNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = activity_log.getActivity_log_id();
                if (findActivity_log(id) == null) {
                    throw new NonexistentEntityException("The activity_log with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(int id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Activity_log activity_log;
            try {
                activity_log = em.getReference(Activity_log.class, id);
                activity_log.getActivity_log_id();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The activity_log with id " + id + " no longer exists.", enfe);
            }
            User user_id = activity_log.getUser_id();
            if (user_id != null) {
                user_id.getListActivity_log().remove(activity_log);
                user_id = em.merge(user_id);
            }
            em.remove(activity_log);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Activity_log> findActivity_logEntities() {
        return findActivity_logEntities(true, -1, -1);
    }

    public List<Activity_log> findActivity_logEntities(int maxResults, int firstResult) {
        return findActivity_logEntities(false, maxResults, firstResult);
    }

    private List<Activity_log> findActivity_logEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Activity_log.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Activity_log findActivity_log(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Activity_log.class, id);
        } finally {
            em.close();
        }
    }

    public int getActivity_logCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Activity_log> rt = cq.from(Activity_log.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

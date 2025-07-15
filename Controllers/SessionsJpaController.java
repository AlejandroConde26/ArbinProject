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
import Models.User;
import Models.Sessions;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author USER
 */
public class SessionsJpaController implements Serializable {

    public SessionsJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    public SessionsJpaController(){
        emf =Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }
    public void create(Sessions sessions) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            User user_id = sessions.getUser_id();
            if (user_id != null) {
                user_id = em.getReference(user_id.getClass(), user_id.getId_users());
                sessions.setUser_id(user_id);
            }
            em.persist(sessions);
            if (user_id != null) {
                user_id.getListSessiones().add(sessions);
                user_id = em.merge(user_id);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Sessions sessions) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Sessions persistentsessions = em.find(Sessions.class, sessions.getSession_id());
            User user_idOld = persistentsessions.getUser_id();
            User user_idNew = sessions.getUser_id();
            if (user_idNew != null) {
                user_idNew = em.getReference(user_idNew.getClass(), user_idNew.getId_users());
                sessions.setUser_id(user_idNew);
            }
            sessions = em.merge(sessions);
            if (user_idOld != null && !user_idOld.equals(user_idNew)) {
                user_idOld.getListSessiones().remove(sessions);
                user_idOld = em.merge(user_idOld);
            }
            if (user_idNew != null && !user_idNew.equals(user_idOld)) {
                user_idNew.getListSessiones().add(sessions);
                user_idNew = em.merge(user_idNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = sessions.getSession_id();
                if (findsessions(id) == null) {
                    throw new NonexistentEntityException("The sessions with id " + id + " no longer exists.");
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
            Sessions sessions;
            try {
                sessions = em.getReference(Sessions.class, id);
                sessions.getSession_id();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The sessions with id " + id + " no longer exists.", enfe);
            }
            User user_id = sessions.getUser_id();
            if (user_id != null) {
                user_id.getListSessiones().remove(sessions);
                user_id = em.merge(user_id);
            }
            em.remove(sessions);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Sessions> findsessionsEntities() {
        return findsessionsEntities(true, -1, -1);
    }

    public List<Sessions> findsessionsEntities(int maxResults, int firstResult) {
        return findsessionsEntities(false, maxResults, firstResult);
    }

    private List<Sessions> findsessionsEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Sessions.class));
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

    public Sessions findsessions(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Sessions.class, id);
        } finally {
            em.close();
        }
    }

    public int getsessionsCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Sessions> rt = cq.from(Sessions.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

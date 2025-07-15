package Controllers;

import java.io.Serializable;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import Models.User;
import Models.Activity_log;
import Models.Host;
import Models.Reservation;
import java.util.ArrayList;
import persistencia.exceptions.NonexistentEntityException;

public class UserJpaController implements Serializable {

    public UserJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManagerFactory emf = null;

    public UserJpaController() {
        emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(User user) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            // Asociaciones bidireccionales
            if (user.getListActivity_log() != null) {
                for (Activity_log log : user.getListActivity_log()) {
                    log.setUser_id(user);
                    em.merge(log);
                }
            }

            if (user.getReservationList() != null) {
                for (Reservation reservation : user.getReservationList()) {
                    reservation.setUserId(user);
                    em.merge(reservation);
                }
            }


            em.persist(user);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(User user) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            User persistentUser = em.find(User.class, user.getId_users());

            // Actualiza relaciones si cambiaron
            if (user.getListActivity_log() != null) {
                for (Activity_log log : user.getListActivity_log()) {
                    log.setUser_id(user);
                    em.merge(log);
                }
            }

            if (user.getReservationList() != null) {
                for (Reservation reservation : user.getReservationList()) {
                    reservation.setUserId(user);
                    em.merge(reservation);
                }
            }

            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = user.getId_users();
            if (findUser(id) == null) {
                throw new NonexistentEntityException("The user with id " + id + " no longer exists.");
            }
            throw ex;
        } finally {
            if (em != null) em.close();
        }
    }


public void destroy(int id) throws NonexistentEntityException {
    EntityManager em = null;
    try {
        em = getEntityManager();
        em.getTransaction().begin();
        User user;

        try {
            user = em.getReference(User.class, id);
            user.getId_users();
        } catch (EntityNotFoundException enfe) {
            throw new NonexistentEntityException("The user with id " + id + " no longer exists.", enfe);
        }

        // Elimina referencias de entidades relacionadas
        if (user.getListActivity_log() != null) {
            for (Activity_log log : user.getListActivity_log()) {
                log.setUser_id(null);
                em.merge(log);
            }
        }
if (user.getReservationList() != null) {
    for (Reservation reservation : new ArrayList<>(user.getReservationList())) {
        em.remove(em.contains(reservation) ? reservation : em.merge(reservation));
    }
}
       
                // 🛠️ Romper relación con Host si existe
        Query query = em.createQuery("SELECT h FROM Host h WHERE h.id_user = :user");
        query.setParameter("user", user);
        List<Host> hostList = query.getResultList();

        for (Host host : hostList) {
            em.remove(host); // Elimina el Host asociado
        }

        em.remove(user); // Ahora puedes eliminar el usuario sin error
        em.getTransaction().commit();
    } finally {
        if (em != null) em.close();
    }
}

    public List<User> findUserEntities() {
        return findUserEntities(true, -1, -1);
    }

    public List<User> findUserEntities(int maxResults, int firstResult) {
        return findUserEntities(false, maxResults, firstResult);
    }

    private List<User> findUserEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<User> cq = em.getCriteriaBuilder().createQuery(User.class);
            cq.select(cq.from(User.class));
            TypedQuery<User> q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public User findUser(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    public int getUserCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<User> rt = cq.from(User.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            return em.createQuery(cq).getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}
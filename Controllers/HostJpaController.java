package Controllers;

import java.io.Serializable;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import Models.Host;
import Models.Housing;
import Models.Message;
import Models.User;
import persistencia.exceptions.NonexistentEntityException;

public class HostJpaController implements Serializable {

    public HostJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManagerFactory emf = null;

    public HostJpaController() {
        emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Host host) {
        if (host.getHousings() == null) {
            host.setHousings(new java.util.ArrayList<>());
        }

        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            // Referenciar el usuario
            User user = host.getId_user();
            if (user != null) {
                user = em.getReference(user.getClass(), user.getId_users());
                host.setId_user(user);
            }

            // Referenciar viviendas (Housing)
            List<Housing> attachedHousing = new java.util.ArrayList<>();
            for (Housing housing : host.getHousings()) {
                housing = em.getReference(housing.getClass(), housing.getHousingId());
                attachedHousing.add(housing);
            }
            host.setHousings(attachedHousing);

            em.persist(host);

            // Mantener bidirección con User
            if (user != null) {
                user.setHost_id(host); // suponer que User tiene un atributo Host
                em.merge(user);
            }

            // Mantener bidirección con mensajes
            for (Message msg : host.getId_user().getReceiverMessages()) {
                msg.setReceiver(host.getId_user());
                em.merge(msg);
            }

            // Mantener bidirección con housing
            for (Housing housing : host.getHousings()) {
                housing.setHostId(host);
                em.merge(housing);
            }

            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    public void edit(Host host) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Host persistentHost = em.find(Host.class, host.getId_Host());

            User oldUser = persistentHost.getId_user();
            User newUser = host.getId_user();

            if (newUser != null) {
                newUser = em.getReference(newUser.getClass(), newUser.getId_users());
                host.setId_user(newUser);
            }

            host = em.merge(host);

            // Romper la relación anterior si cambia de usuario
            if (oldUser != null && !oldUser.equals(newUser)) {
                oldUser.setHost_id(null);
                em.merge(oldUser);
            }

            // Romper relación previa del nuevo usuario, si ya tenía un host
            if (newUser != null && !newUser.equals(oldUser)) {
                Host existingHost = newUser.getHost_id();
                if (existingHost != null && !existingHost.equals(host)) {
                    em.remove(existingHost);  // ← lo eliminamos completamente si no se necesita
                }

                newUser.setHost_id(host);
                em.merge(newUser);
            }

            // Actualizar relaciones de housing
            for (Housing housing : host.getHousings()) {
                housing.setHostId(host);
                em.merge(housing);
            }

            // Actualizar relaciones de mensaje
            for (Message msg : host.getId_user().getReceiverMessages()) {
                msg.setReceiver(host.getId_user());
                em.merge(msg);
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = host.getId_Host();
            if (findHost(id) == null) {
                throw new NonexistentEntityException("The host with id " + id + " no longer exists.");
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

            Host host;
            try {
                host = em.getReference(Host.class, id);
                host.getId_Host();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The host with id " + id + " no longer exists.", enfe);
            }

            // Remover relación con user
            User user = host.getId_user();
            if (user != null) {
                user.setHost_id(null);
                em.merge(user);
            }

            // Remover relación con housing
            for (Housing housing : host.getHousings()) {
                em.remove(em.contains(housing) ? housing : em.merge(housing));
            }

            // Remover relación con mensajes
            for (Message msg : host.getId_user().getReceiverMessages()) {
                msg.setReceiver(null);
                em.merge(msg);
            }

            em.remove(host);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Host> findHostEntities() {
        return findHostEntities(true, -1, -1);
    }

    public List<Host> findHostEntities(int maxResults, int firstResult) {
        return findHostEntities(false, maxResults, firstResult);
    }

    private List<Host> findHostEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Host.class));
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

    public Host findHost(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Host.class, id);
        } finally {
            em.close();
        }
    }

    public int getHostCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Host> rt = cq.from(Host.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}


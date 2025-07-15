package Controllers;

import java.io.Serializable;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import Models.Address;
import Models.User;
import persistencia.exceptions.NonexistentEntityException;

public class AddressJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public AddressJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public AddressJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Address address) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            User user = address.getUser();
            if (user != null) {
                user = em.getReference(user.getClass(), user.getId_users());
                address.setUser(user);
            }
            em.persist(address);
            if (user != null) {
                user.setAddress_id(address); // conexión bidireccional
                em.merge(user);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(Address address) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Address persistentAddress = em.find(Address.class, address.getId_address());
            User userOld = persistentAddress.getUser();
            User userNew = address.getUser();

            if (userNew != null) {
                userNew = em.getReference(userNew.getClass(), userNew.getId_users());
                address.setUser(userNew);
            }

            address = em.merge(address);

            if (userOld != null && !userOld.equals(userNew)) {
                userOld.setAddress_id(null);
                em.merge(userOld);
            }

            if (userNew != null && !userNew.equals(userOld)) {
                userNew.setAddress_id(address);
                em.merge(userNew);
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = address.getId_address();
            if (findAddress(id) == null) {
                throw new NonexistentEntityException("The address with id " + id + " no longer exists.");
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
            Address address;
            try {
                address = em.getReference(Address.class, id);
                address.getId_address();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The address with id " + id + " no longer exists.", enfe);
            }

            User user = address.getUser();
            if (user != null) {
                user.setAddress_id(null);
                em.merge(user);
            }

            em.remove(address);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public List<Address> findAddressEntities() {
        return findAddressEntities(true, -1, -1);
    }

    public List<Address> findAddressEntities(int maxResults, int firstResult) {
        return findAddressEntities(false, maxResults, firstResult);
    }

    private List<Address> findAddressEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Address> cq = em.getCriteriaBuilder().createQuery(Address.class);
            cq.select(cq.from(Address.class));
            TypedQuery<Address> q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Address findAddress(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Address.class, id);
        } finally {
            em.close();
        }
    }

    public int getAddressCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<Address> rt = cq.from(Address.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            return em.createQuery(cq).getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}
package Controllers;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Models.Housing;
import Models.Host;
import Models.HousingCategory;
import Models.HousingImage;
import persistencia.exceptions.NonexistentEntityException;

public class HousingJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public HousingJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public HousingJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public int createAndReturnId(Housing housing) {
          EntityManager em = null;
          try {
              em = getEntityManager();
              em.getTransaction().begin();

              Host hostId = housing.getHostId();
              if (hostId != null) {
                  hostId = em.getReference(hostId.getClass(), hostId.getId_Host());
                  housing.setHostId(hostId);
              }

              HousingCategory housingCategory = housing.getId_housingcategory();
              if (housingCategory != null) {
                  housingCategory = em.getReference(housingCategory.getClass(), housingCategory.getCategoryId());
                  housing.setId_housingcategory(housingCategory);
              }

              em.persist(housing); // aquí se genera el ID si está anotado con @GeneratedValue
              em.getTransaction().commit();

              return housing.getHousingId(); // ID generado automáticamente
          } finally {
              if (em != null) em.close();
          }
      }

    public void edit(Housing housing) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Housing persistentHousing = em.find(Housing.class, housing.getHousingId());
            Host oldHostId = persistentHousing.getHostId();
            Host newHostId = housing.getHostId();
            if (newHostId != null) {
                newHostId = em.getReference(newHostId.getClass(), newHostId.getId_Host());
                housing.setHostId(newHostId);
            }
            HousingCategory oldHousingCategory = persistentHousing.getId_housingcategory();
            HousingCategory newHousingCategory = housing.getId_housingcategory();
            if (newHousingCategory != null) {
                newHousingCategory = em.getReference(newHousingCategory.getClass(), newHousingCategory.getCategoryId());
                housing.setId_housingcategory(newHousingCategory);
            }
            housing = em.merge(housing);
            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = housing.getHousingId();
            if (findHousing(id) == null) {
                throw new NonexistentEntityException("The housing with id " + id + " no longer exists.");
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
            Housing housing;
            try {
                housing = em.getReference(Housing.class, id);
                housing.getHousingId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The housing with id " + id + " no longer exists.", enfe);
            }
            em.remove(housing);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public List<Housing> findHousingEntities() {
        return findHousingEntities(true, -1, -1);
    }

    public List<Housing> findHousingEntities(int maxResults, int firstResult) {
        return findHousingEntities(false, maxResults, firstResult);
    }

    private List<Housing> findHousingEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Housing> cq = em.getCriteriaBuilder().createQuery(Housing.class);
            cq.select(cq.from(Housing.class));
            TypedQuery<Housing> q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Housing findHousing(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Housing.class, id);
        } finally {
            em.close();
        }
    }

    public int getHousingCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<Housing> rt = cq.from(Housing.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            return em.createQuery(cq).getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
    public List<Housing> findHousingsByHostId(int hostId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Housing> query = em.createQuery(
                "SELECT h FROM Housing h WHERE h.hostId.id_Host = :hostId", Housing.class);
            query.setParameter("hostId", hostId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
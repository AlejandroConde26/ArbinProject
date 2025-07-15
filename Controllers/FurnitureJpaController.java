package Controllers;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Models.Furniture;
import Models.Housing;
import persistencia.exceptions.NonexistentEntityException;

public class FurnitureJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public FurnitureJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public FurnitureJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Furniture furniture) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Housing housing = furniture.getId_housing();
            if (housing != null) {
                housing = em.getReference(housing.getClass(), housing.getHousingId());
                furniture.setId_housing(housing);
            }

            em.persist(furniture);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(Furniture furniture) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Furniture persistentFurniture = em.find(Furniture.class, furniture.getIdFurniture());
            Housing oldHousing = persistentFurniture.getId_housing();
            Housing newHousing = furniture.getId_housing();

            if (newHousing != null) {
                newHousing = em.getReference(newHousing.getClass(), newHousing.getHousingId());
                furniture.setId_housing(newHousing);
            }

            furniture = em.merge(furniture);
            em.getTransaction().commit();
        } catch (Exception ex) {
            Integer id = furniture.getIdFurniture();
            if (findFurniture(id) == null) {
                throw new NonexistentEntityException("The furniture with id " + id + " no longer exists.");
            }
            throw ex;
        } finally {
            if (em != null) em.close();
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Furniture furniture;
            try {
                furniture = em.getReference(Furniture.class, id);
                furniture.getIdFurniture();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The furniture with id " + id + " no longer exists.", enfe);
            }

            em.remove(furniture);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public List<Furniture> findFurnitureEntities() {
        return findFurnitureEntities(true, -1, -1);
    }

    public List<Furniture> findFurnitureEntities(int maxResults, int firstResult) {
        return findFurnitureEntities(false, maxResults, firstResult);
    }

    private List<Furniture> findFurnitureEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Furniture> cq = em.getCriteriaBuilder().createQuery(Furniture.class);
            cq.select(cq.from(Furniture.class));
            TypedQuery<Furniture> q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Furniture findFurniture(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Furniture.class, id);
        } finally {
            em.close();
        }
    }

    public int getFurnitureCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Long> cq = em.getCriteriaBuilder().createQuery(Long.class);
            Root<Furniture> rt = cq.from(Furniture.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            return em.createQuery(cq).getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}
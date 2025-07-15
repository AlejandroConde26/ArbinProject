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
import Models.HousingImage;
import Models.Housing;
import persistencia.exceptions.NonexistentEntityException;

public class HousingImageJpaController implements Serializable {

    public HousingImageJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public HousingImageJpaController() {
        emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public void create(HousingImage housingImage) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Housing housingId = housingImage.getHousingId();
            if (housingId != null) {
                housingId = em.getReference(housingId.getClass(), housingId.getHousingId());
                housingImage.setHousingId(housingId);
            }
            em.persist(housingImage);
            if (housingId != null) {
                housingId.getHousingImages().add(housingImage);
                housingId = em.merge(housingId);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(HousingImage housingImage) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            HousingImage persistentHousingImage = em.find(HousingImage.class, housingImage.getHousingImageId());
            Housing housingIdOld = persistentHousingImage.getHousingId();
            Housing housingIdNew = housingImage.getHousingId();
            if (housingIdNew != null) {
                housingIdNew = em.getReference(housingIdNew.getClass(), housingIdNew.getHousingId());
                housingImage.setHousingId(housingIdNew);
            }
            housingImage = em.merge(housingImage);
            if (housingIdOld != null && !housingIdOld.equals(housingIdNew)) {
                housingIdOld.getHousingImages().remove(housingImage);
                housingIdOld = em.merge(housingIdOld);
            }
            if (housingIdNew != null && !housingIdNew.equals(housingIdOld)) {
                housingIdNew.getHousingImages().add(housingImage);
                housingIdNew = em.merge(housingIdNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = housingImage.getHousingImageId();
                if (findHousingImage(id) == null) {
                    throw new NonexistentEntityException("The HousingImage with id " + id + " no longer exists.");
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
            HousingImage housingImage;
            try {
                housingImage = em.getReference(HousingImage.class, id);
                housingImage.getHousingImageId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The HousingImage with id " + id + " no longer exists.", enfe);
            }
            Housing housingId = housingImage.getHousingId();
            if (housingId != null) {
                housingId.getHousingImages().remove(housingImage);
                housingId = em.merge(housingId);
            }
            em.remove(housingImage);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<HousingImage> findHousingImageEntities() {
        return findHousingImageEntities(true, -1, -1);
    }

    public List<HousingImage> findHousingImageEntities(int maxResults, int firstResult) {
        return findHousingImageEntities(false, maxResults, firstResult);
    }

    private List<HousingImage> findHousingImageEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(HousingImage.class));
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

    public HousingImage findHousingImage(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(HousingImage.class, id);
        } finally {
            em.close();
        }
    }

    public int getHousingImageCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<HousingImage> rt = cq.from(HousingImage.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
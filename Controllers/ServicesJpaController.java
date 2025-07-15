package Controllers;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Models.Services;
import Models.Housing;
import java.util.ArrayList;
import persistencia.exceptions.NonexistentEntityException;

public class ServicesJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public ServicesJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public ServicesJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Services services) {
        if (services.getHousings() == null) {
            services.setHousings(new java.util.ArrayList<>());
        }

        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            List<Housing> attachedHousings = new java.util.ArrayList<>();
            for (Housing housing : services.getHousings()) {
                housing = em.getReference(housing.getClass(), housing.getHostId());
                attachedHousings.add(housing);
            }
            services.setHousings(attachedHousings);
            em.persist(services);
            for (Housing housing : services.getHousings()) {
                housing.getListservices().add(services);
                em.merge(housing);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

 public void edit(Services services) throws NonexistentEntityException, Exception {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Services persistentServices = em.find(Services.class, services.getId_service());
            List<Housing> oldHousings = persistentServices.getHousings();
            List<Housing> newHousings = services.getHousings();

            List<Housing> attachedNewHousings = new java.util.ArrayList<>();
            for (Housing housing : newHousings) {
                housing = em.getReference(housing.getClass(), housing.getHostId());
                attachedNewHousings.add(housing);
            }
            newHousings = attachedNewHousings;
            services.setHousings(newHousings);
            services = em.merge(services);

            for (Housing oldHousing : oldHousings) {
                if (!newHousings.contains(oldHousing)) {
                    oldHousing.getListservices().remove(services);
                    em.merge(oldHousing);
                }
            }
            for (Housing newHousing : newHousings) {
                if (!oldHousings.contains(newHousing)) {
                    newHousing.getListservices().add(services);
                    em.merge(newHousing);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = services.getId_service();
            if (findServices(id) == null) {
                throw new NonexistentEntityException("The services with id " + id + " no longer exists.");
            }
            throw ex;
        } finally {
            em.close();
        }
    }
    public void destroy(int id) throws NonexistentEntityException {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Services services;
            try {
                services = em.getReference(Services.class, id);
                services.getId_service();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The services with id " + id + " no longer exists.", enfe);
            }
            List<Housing> housings = services.getHousings();
            for (Housing housing : housings) {
                housing.getListservices().remove(services);
                em.merge(housing);
            }
            em.remove(services);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
 // NEW HELPER METHOD: To get services for a specific housing
    public List<Services> findServicesForHousing(int housingId) {
        EntityManager em = emf.createEntityManager(); // Get a fresh EntityManager
        List<Services> services = new ArrayList<>();
        try {
            // This query fetches Services that have the given Housing in their 'housings' list
            TypedQuery<Services> query = em.createQuery(
                "SELECT s FROM Services s JOIN s.housings h WHERE h.housingId = :housingId", Services.class);
            query.setParameter("housingId", housingId);
            services = query.getResultList();
            
            System.out.println(services);

            // Eagerly load the housings for each service if needed (important for `updateHousingServices` later)
            for (Services s : services) {
                if (s.getHousings() != null) {
                    s.getHousings().size();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return services;
    }
    public void insertarServiciosParaHousing(int housingId, List<Integer> serviceIds) {
    EntityManager em = emf.createEntityManager();
    EntityTransaction tx = em.getTransaction();

    try {
        tx.begin();

        // 1. Primero eliminamos los registros anteriores (para actualizar la relación)
        em.createNativeQuery("DELETE FROM housing_services WHERE housing_id = ?")
          .setParameter(1, housingId)
          .executeUpdate();

        // 2. Insertamos los nuevos servicios seleccionados
        for (Integer serviceId : serviceIds) {
            em.createNativeQuery("INSERT INTO housing_services (housing_id, service_id) VALUES (?, ?)")
              .setParameter(1, housingId)
              .setParameter(2, serviceId)
              .executeUpdate();
        }

        tx.commit();
        System.out.println("Servicios actualizados correctamente para el housing ID " + housingId);
    } catch (Exception e) {
        if (tx.isActive()) {
            tx.rollback();
        }
        System.err.println("Error al insertar servicios en housing_services");
        e.printStackTrace();
    } finally {
        em.close();
    }
}

    public List<Services> findServicesEntities() {
        return findServicesEntities(true, -1, -1);
    }

    public List<Services> findServicesEntities(int maxResults, int firstResult) {
        return findServicesEntities(false, maxResults, firstResult);
    }

    private List<Services> findServicesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Services.class));
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

    public Services findServices(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Services.class, id);
        } finally {
            em.close();
        }
    }

    public int getServicesCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Services> rt = cq.from(Services.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
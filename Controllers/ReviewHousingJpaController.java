package Controllers;

import Models.ReviewHousing;
import Models.Reservation;
import persistencia.exceptions.NonexistentEntityException;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.io.Serializable;
import java.util.List;

public class ReviewHousingJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public ReviewHousingJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public ReviewHousingJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(ReviewHousing reviewHousing) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Reservation reservation = reviewHousing.getReservation();
            if (reservation != null) {
                reservation = em.getReference(reservation.getClass(), reservation.getReservationId());
                reviewHousing.setReservation(reservation);
                reservation.setReviewHousing(reviewHousing); // asegurar bidireccionalidad
                em.merge(reservation);
            }

            em.persist(reviewHousing);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(ReviewHousing reviewHousing) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            ReviewHousing persistent = em.find(ReviewHousing.class, reviewHousing.getId_reviewHousing());
            Reservation oldReservation = persistent.getReservation();
            Reservation newReservation = reviewHousing.getReservation();

            if (newReservation != null) {
                newReservation = em.getReference(newReservation.getClass(), newReservation.getReservationId());
                reviewHousing.setReservation(newReservation);
            }

            reviewHousing = em.merge(reviewHousing);

            if (oldReservation != null && !oldReservation.equals(newReservation)) {
                oldReservation.setReviewHousing(null);
                em.merge(oldReservation);
            }

            if (newReservation != null && !newReservation.equals(oldReservation)) {
                newReservation.setReviewHousing(reviewHousing);
                em.merge(newReservation);
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = reviewHousing.getId_reviewHousing();
            if (findReviewHousing(id) == null) {
                throw new NonexistentEntityException("The reviewHousing with id " + id + " no longer exists.");
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
            ReviewHousing reviewHousing;

            try {
                reviewHousing = em.getReference(ReviewHousing.class, id);
                reviewHousing.getId_reviewHousing();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The reviewHousing with id " + id + " no longer exists.", enfe);
            }

            Reservation reservation = reviewHousing.getReservation();
            if (reservation != null) {
                reservation.setReviewHousing(null);
                em.merge(reservation);
            }

            em.remove(reviewHousing);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public List<ReviewHousing> findReviewHousingEntities() {
        return findReviewHousingEntities(true, -1, -1);
    }

    public List<ReviewHousing> findReviewHousingEntities(int maxResults, int firstResult) {
        return findReviewHousingEntities(false, maxResults, firstResult);
    }

    private List<ReviewHousing> findReviewHousingEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(ReviewHousing.class));
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

    public ReviewHousing findReviewHousing(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ReviewHousing.class, id);
        } finally {
            em.close();
        }
    }

    public int getReviewHousingCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<ReviewHousing> rt = cq.from(ReviewHousing.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
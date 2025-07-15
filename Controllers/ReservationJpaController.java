package Controllers;

import java.io.Serializable;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import Models.Reservation;
import Models.User;
import Models.Housing;
import Models.ReservationStatus;
import Models.Payment;
import persistencia.exceptions.NonexistentEntityException;

public class ReservationJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public ReservationJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public ReservationJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Reservation reservation) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            // Relaciones
            User user = reservation.getUserId();
            if (user != null) {
                user = em.getReference(user.getClass(), user.getId_users());
                reservation.setUserId(user);
            }

            Housing housing = reservation.getHousingId();
            if (housing != null) {
                housing = em.getReference(housing.getClass(), housing.getHousingId());
                reservation.setHousingId(housing);
            }

            ReservationStatus status = reservation.getReservationStatusId();
            if (status != null) {
                status = em.getReference(status.getClass(), status.getReservationStatusId());
                reservation.setReservationStatusId(status);
            }

            // Persistencia
            em.persist(reservation);

            // Bidireccionalidad
            if (user != null) {
                user.getReservationList().add(reservation);
                em.merge(user);
            }

            if (housing != null) {
                housing.getReservations().add(reservation);
                em.merge(housing);
            }

            if (status != null) {
                status.getReservationList().add(reservation);
                em.merge(status);
            }

            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(Reservation reservation) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Reservation persistentReservation = em.find(Reservation.class, reservation.getReservationId());

            User oldUser = persistentReservation.getUserId();
            User newUser = reservation.getUserId();

            Housing oldHousing = persistentReservation.getHousingId();
            Housing newHousing = reservation.getHousingId();

            ReservationStatus oldStatus = persistentReservation.getReservationStatusId();
            ReservationStatus newStatus = reservation.getReservationStatusId();

            if (newUser != null) {
                newUser = em.getReference(newUser.getClass(), newUser.getId_users());
                reservation.setUserId(newUser);
            }

            if (newHousing != null) {
                newHousing = em.getReference(newHousing.getClass(), newHousing.getHousingId());
                reservation.setHousingId(newHousing);
            }

            if (newStatus != null) {
                newStatus = em.getReference(newStatus.getClass(), newStatus.getReservationStatusId());
                reservation.setReservationStatusId(newStatus);
            }

            reservation = em.merge(reservation);

            if (oldUser != null && !oldUser.equals(newUser)) {
                oldUser.getReservationList().remove(reservation);
                em.merge(oldUser);
            }
            if (newUser != null && !newUser.equals(oldUser)) {
                newUser.getReservationList().add(reservation);
                em.merge(newUser);
            }

            if (oldHousing != null && !oldHousing.equals(newHousing)) {
                oldHousing.getReservations().remove(reservation);
                em.merge(oldHousing);
            }
            if (newHousing != null && !newHousing.equals(oldHousing)) {
                newHousing.getReservations().add(reservation);
                em.merge(newHousing);
            }

            if (oldStatus != null && !oldStatus.equals(newStatus)) {
                oldStatus.getReservationList().remove(reservation);
                em.merge(oldStatus);
            }
            if (newStatus != null && !newStatus.equals(oldStatus)) {
                newStatus.getReservationList().add(reservation);
                em.merge(newStatus);
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            if (reservation.getReservationId() == 0 || findReservation(reservation.getReservationId()) == null) {
                throw new NonexistentEntityException("The reservation with id " + reservation.getReservationId() + " no longer exists.");
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

            Reservation reservation;
            try {
                reservation = em.getReference(Reservation.class, id);
                reservation.getReservationId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The reservation with id " + id + " no longer exists.", enfe);
            }

            User user = reservation.getUserId();
            if (user != null) {
                user.getReservationList().remove(reservation);
                em.merge(user);
            }

            Housing housing = reservation.getHousingId();
            if (housing != null) {
                housing.getReservations().remove(reservation);
                em.merge(housing);
            }

            ReservationStatus status = reservation.getReservationStatusId();
            if (status != null) {
                status.getReservationList().remove(reservation);
                em.merge(status);
            }

            em.remove(reservation);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public List<Reservation> findReservationEntities() {
        return findReservationEntities(true, -1, -1);
    }

    public List<Reservation> findReservationEntities(int maxResults, int firstResult) {
        return findReservationEntities(false, maxResults, firstResult);
    }

    private List<Reservation> findReservationEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Reservation.class));
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

    public Reservation findReservation(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Reservation.class, id);
        } finally {
            em.close();
        }
    }

    public int getReservationCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Reservation> rt = cq.from(Reservation.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
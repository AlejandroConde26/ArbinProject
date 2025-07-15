package Controllers;

import Models.ReservationStatus;
import Models.Reservation;
import persistencia.exceptions.NonexistentEntityException;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ReservationStatusJpaController implements Serializable {

    public ReservationStatusJpaController() {
        emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public ReservationStatusJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(ReservationStatus reservationStatus) {
        if (reservationStatus.getReservationList() == null) {
            reservationStatus.setReservationList(new ArrayList<Reservation>());
        }

        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            List<Reservation> attachedReservations = new ArrayList<>();
            for (Reservation reservation : reservationStatus.getReservationList()) {
                reservation = em.getReference(reservation.getClass(), reservation.getReservationId());
                attachedReservations.add(reservation);
            }
            reservationStatus.setReservationList(attachedReservations);

            em.persist(reservationStatus);

            for (Reservation reservation : reservationStatus.getReservationList()) {
                ReservationStatus oldStatus = reservation.getReservationStatusId();
                reservation.setReservationStatusId(reservationStatus);
                reservation = em.merge(reservation);
                if (oldStatus != null) {
                    oldStatus.getReservationList().remove(reservation);
                    em.merge(oldStatus);
                }
            }

            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(ReservationStatus reservationStatus) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            ReservationStatus persistentStatus = em.find(ReservationStatus.class, reservationStatus.getReservationStatusId());
            List<Reservation> oldList = persistentStatus.getReservationList();
            List<Reservation> newList = reservationStatus.getReservationList();

            List<Reservation> attachedNewList = new ArrayList<>();
            for (Reservation reservation : newList) {
                reservation = em.getReference(reservation.getClass(), reservation.getReservationId());
                attachedNewList.add(reservation);
            }
            newList = attachedNewList;
            reservationStatus.setReservationList(newList);
            reservationStatus = em.merge(reservationStatus);

            for (Reservation oldReservation : oldList) {
                if (!newList.contains(oldReservation)) {
                    oldReservation.setReservationStatusId(null);
                    em.merge(oldReservation);
                }
            }

            for (Reservation newReservation : newList) {
                if (!oldList.contains(newReservation)) {
                    ReservationStatus oldStatus = newReservation.getReservationStatusId();
                    newReservation.setReservationStatusId(reservationStatus);
                    newReservation = em.merge(newReservation);
                    if (oldStatus != null && !oldStatus.equals(reservationStatus)) {
                        oldStatus.getReservationList().remove(newReservation);
                        em.merge(oldStatus);
                    }
                }
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            int id = reservationStatus.getReservationStatusId();
            if (findReservationStatus(id) == null) {
                throw new NonexistentEntityException("The reservationStatus with id " + id + " no longer exists.");
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

            ReservationStatus reservationStatus;
            try {
                reservationStatus = em.getReference(ReservationStatus.class, id);
                reservationStatus.getReservationStatusId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The reservationStatus with id " + id + " no longer exists.", enfe);
            }

            List<Reservation> reservations = reservationStatus.getReservationList();
            for (Reservation reservation : reservations) {
                reservation.setReservationStatusId(null);
                em.merge(reservation);
            }

            em.remove(reservationStatus);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public List<ReservationStatus> findReservationStatusEntities() {
        return findReservationStatusEntities(true, -1, -1);
    }

    public List<ReservationStatus> findReservationStatusEntities(int maxResults, int firstResult) {
        return findReservationStatusEntities(false, maxResults, firstResult);
    }

    private List<ReservationStatus> findReservationStatusEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(ReservationStatus.class));
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

    public ReservationStatus findReservationStatus(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ReservationStatus.class, id);
        } finally {
            em.close();
        }
    }

    public int getReservationStatusCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<ReservationStatus> rt = cq.from(ReservationStatus.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
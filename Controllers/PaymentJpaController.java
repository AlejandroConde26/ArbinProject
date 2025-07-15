package Controllers;

import java.io.Serializable;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import Models.Payment;
import Models.Reservation;
import Models.PaymentMethod;

import java.util.List;

public class PaymentJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public PaymentJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public PaymentJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Payment payment) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            Reservation reservation = payment.getReservation();
            if (reservation != null) {
                reservation = em.getReference(reservation.getClass(), reservation.getReservationId());
                payment.setReservation(reservation);
            }

            PaymentMethod paymentMethod = payment.getPaymentMethod();
            if (paymentMethod != null) {
                paymentMethod = em.getReference(paymentMethod.getClass(), paymentMethod.getPaymentMethodId());
                payment.setPaymentMethod(paymentMethod);
            }

            em.persist(payment);

            if (reservation != null) {
                reservation.getListPayment().add(payment);
                em.merge(reservation);
            }

            if (paymentMethod != null) {
                paymentMethod.getListPayment().add(payment);
                em.merge(paymentMethod);
            }

            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(Payment payment) throws Exception {
    EntityManager em = getEntityManager();
    try {
        em.getTransaction().begin();
        Query query = em.createNativeQuery("CALL sp_editar_pago(?, ?, ?, ?, ?, ?, ?)");
        query.setParameter(1, payment.getPaymentId()); // id_pago
        query.setParameter(2, payment.getAmount()); // nuevo_monto
        query.setParameter(3, payment.getEndDate()); // nueva_fecha_fin
        query.setParameter(4, payment.getPaymentDate()); // nueva_fecha_pago
        query.setParameter(5, payment.getPaymentStatus()); // nuevo_estado
        query.setParameter(6, payment.getUpdatedDate()); // nueva_fecha_actualizacion
        query.setParameter(7, payment.getPaymentMethod().getPaymentMethodId()); // nuevo_metodo
        query.executeUpdate();
        em.getTransaction().commit();
    } finally {
        em.close();
    }
}
    public void destroy(int id) throws Exception {
            EntityManager em = getEntityManager();
            try {
                em.getTransaction().begin();
                Query query = em.createNativeQuery("CALL sp_eliminar_pago(?)");
                query.setParameter(1, id);
                query.executeUpdate();
                em.getTransaction().commit();
            } finally {
                em.close();
            }
    }
    

    public List<Payment> findPaymentEntities() {
        EntityManager em = getEntityManager();
        try {
            Query query = em.createNativeQuery("CALL sp_listar_pagos()", Payment.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Payment> findPaymentEntities(int maxResults, int firstResult) {
        return findPaymentEntities(false, maxResults, firstResult);
    }

    private List<Payment> findPaymentEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Payment.class));
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

    public Payment findPayment(int id) {
         EntityManager em = getEntityManager();
         try {
             Query query = em.createNativeQuery("CALL sp_buscar_pago_por_id(?)", Payment.class);
             query.setParameter(1, id);
             List<Payment> result = query.getResultList();
             return result.isEmpty() ? null : result.get(0);
         } finally {
             em.close();
         }
     }

    public int getPaymentCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Payment> rt = cq.from(Payment.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
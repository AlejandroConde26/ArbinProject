package Controllers;

import Models.PaymentMethod;
import Models.Payment;
import persistencia.exceptions.NonexistentEntityException;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.io.Serializable;
import java.util.List;

public class PaymentMethodJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public PaymentMethodJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public PaymentMethodJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(PaymentMethod paymentMethod) {
        if (paymentMethod.getListPayment() == null) {
            paymentMethod.setListPayment(new java.util.ArrayList<>());
        }

        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            List<Payment> attachedPayments = new java.util.ArrayList<>();
            for (Payment payment : paymentMethod.getListPayment()) {
                payment = em.getReference(payment.getClass(), payment.getPaymentId());
                attachedPayments.add(payment);
            }
            paymentMethod.setListPayment(attachedPayments);
            em.persist(paymentMethod);

            for (Payment payment : paymentMethod.getListPayment()) {
                PaymentMethod oldPaymentMethod = payment.getPaymentMethod();
                payment.setPaymentMethod(paymentMethod);
                payment = em.merge(payment);
                if (oldPaymentMethod != null) {
                    oldPaymentMethod.getListPayment().remove(payment);
                    em.merge(oldPaymentMethod);
                }
            }

            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(PaymentMethod paymentMethod) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            PaymentMethod persistentPM = em.find(PaymentMethod.class, paymentMethod.getPaymentMethodId());
            List<Payment> oldPayments = persistentPM.getListPayment();
            List<Payment> newPayments = paymentMethod.getListPayment();

            List<Payment> attachedNewPayments = new java.util.ArrayList<>();
            for (Payment payment : newPayments) {
                payment = em.getReference(payment.getClass(), payment.getPaymentId());
                attachedNewPayments.add(payment);
            }
            newPayments = attachedNewPayments;
            paymentMethod.setListPayment(newPayments);
            paymentMethod = em.merge(paymentMethod);

            for (Payment oldPayment : oldPayments) {
                if (!newPayments.contains(oldPayment)) {
                    oldPayment.setPaymentMethod(null);
                    em.merge(oldPayment);
                }
            }

            for (Payment newPayment : newPayments) {
                if (!oldPayments.contains(newPayment)) {
                    PaymentMethod oldPM = newPayment.getPaymentMethod();
                    newPayment.setPaymentMethod(paymentMethod);
                    em.merge(newPayment);
                    if (oldPM != null && !oldPM.equals(paymentMethod)) {
                        oldPM.getListPayment().remove(newPayment);
                        em.merge(oldPM);
                    }
                }
            }

            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findPaymentMethod(paymentMethod.getPaymentMethodId()) == null) {
                throw new NonexistentEntityException("The payment method with id " + paymentMethod.getPaymentMethodId() + " no longer exists.");
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
            PaymentMethod paymentMethod;
            try {
                paymentMethod = em.getReference(PaymentMethod.class, id);
                paymentMethod.getPaymentMethodId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The payment method with id " + id + " no longer exists.", enfe);
            }

            List<Payment> payments = paymentMethod.getListPayment();
            for (Payment payment : payments) {
                payment.setPaymentMethod(null);
                em.merge(payment);
            }

            em.remove(paymentMethod);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<PaymentMethod> findPaymentMethodEntities() {
        return findPaymentMethodEntities(true, -1, -1);
    }

    public List<PaymentMethod> findPaymentMethodEntities(int maxResults, int firstResult) {
        return findPaymentMethodEntities(false, maxResults, firstResult);
    }

    private List<PaymentMethod> findPaymentMethodEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(PaymentMethod.class));
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

    public PaymentMethod findPaymentMethod(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(PaymentMethod.class, id);
        } finally {
            em.close();
        }
    }

    public int getPaymentMethodCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<PaymentMethod> rt = cq.from(PaymentMethod.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Models.User;
import java.util.ArrayList;
import java.util.List;
import Models.Document_type;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author USER
 */
public class Document_typeJpaController implements Serializable {

    public Document_typeJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
     public Document_typeJpaController(){
        emf =Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public void create(Document_type document_type) {
        if (document_type.getListUsers() == null) {
            document_type.setListUsers(new ArrayList<User>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<User> attachedListUsers = new ArrayList<User>();
            for (User listUsersUserToAttach : document_type.getListUsers()) {
                listUsersUserToAttach = em.getReference(listUsersUserToAttach.getClass(), listUsersUserToAttach.getId_users());
                attachedListUsers.add(listUsersUserToAttach);
            }
            document_type.setListUsers(attachedListUsers);
            em.persist(document_type);
            for (User listUsersUser : document_type.getListUsers()) {
                Document_type oldDocument_type_idOfListUsersUser = listUsersUser.getDocument_type_id();
                listUsersUser.setDocument_type_id(document_type);
                listUsersUser = em.merge(listUsersUser);
                if (oldDocument_type_idOfListUsersUser != null) {
                    oldDocument_type_idOfListUsersUser.getListUsers().remove(listUsersUser);
                    oldDocument_type_idOfListUsersUser = em.merge(oldDocument_type_idOfListUsersUser);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Document_type document_type) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Document_type persistentDocument_type = em.find(Document_type.class, document_type.getDocument_type());
            List<User> listUsersOld = persistentDocument_type.getListUsers();
            List<User> listUsersNew = document_type.getListUsers();
            List<User> attachedListUsersNew = new ArrayList<User>();
            for (User listUsersNewUserToAttach : listUsersNew) {
                listUsersNewUserToAttach = em.getReference(listUsersNewUserToAttach.getClass(), listUsersNewUserToAttach.getId_users());
                attachedListUsersNew.add(listUsersNewUserToAttach);
            }
            listUsersNew = attachedListUsersNew;
            document_type.setListUsers(listUsersNew);
            document_type = em.merge(document_type);
            for (User listUsersOldUser : listUsersOld) {
                if (!listUsersNew.contains(listUsersOldUser)) {
                    listUsersOldUser.setDocument_type_id(null);
                    listUsersOldUser = em.merge(listUsersOldUser);
                }
            }
            for (User listUsersNewUser : listUsersNew) {
                if (!listUsersOld.contains(listUsersNewUser)) {
                    Document_type oldDocument_type_idOfListUsersNewUser = listUsersNewUser.getDocument_type_id();
                    listUsersNewUser.setDocument_type_id(document_type);
                    listUsersNewUser = em.merge(listUsersNewUser);
                    if (oldDocument_type_idOfListUsersNewUser != null && !oldDocument_type_idOfListUsersNewUser.equals(document_type)) {
                        oldDocument_type_idOfListUsersNewUser.getListUsers().remove(listUsersNewUser);
                        oldDocument_type_idOfListUsersNewUser = em.merge(oldDocument_type_idOfListUsersNewUser);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = document_type.getDocument_type();
                if (findDocument_type(id) == null) {
                    throw new NonexistentEntityException("The document_type with id " + id + " no longer exists.");
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
            Document_type document_type;
            try {
                document_type = em.getReference(Document_type.class, id);
                document_type.getDocument_type();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The document_type with id " + id + " no longer exists.", enfe);
            }
            List<User> listUsers = document_type.getListUsers();
            for (User listUsersUser : listUsers) {
                listUsersUser.setDocument_type_id(null);
                listUsersUser = em.merge(listUsersUser);
            }
            em.remove(document_type);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Document_type> findDocument_typeEntities() {
        return findDocument_typeEntities(true, -1, -1);
    }

    public List<Document_type> findDocument_typeEntities(int maxResults, int firstResult) {
        return findDocument_typeEntities(false, maxResults, firstResult);
    }

    private List<Document_type> findDocument_typeEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Document_type.class));
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

    public Document_type findDocument_type(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Document_type.class, id);
        } finally {
            em.close();
        }
    }

    public int getDocument_typeCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Document_type> rt = cq.from(Document_type.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

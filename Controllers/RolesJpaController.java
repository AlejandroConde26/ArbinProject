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
import Models.Roles;
import persistencia.exceptions.NonexistentEntityException;

/**
 *
 * @author USER
 */
public class RolesJpaController implements Serializable {

    public RolesJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    public RolesJpaController(){
        emf =Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public void create(Roles roles) {
        if (roles.getListUsers() == null) {
            roles.setListUsers(new ArrayList<User>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<User> attachedListUsers = new ArrayList<User>();
            for (User listUsersUserToAttach : roles.getListUsers()) {
                listUsersUserToAttach = em.getReference(listUsersUserToAttach.getClass(), listUsersUserToAttach.getId_users());
                attachedListUsers.add(listUsersUserToAttach);
            }
            roles.setListUsers(attachedListUsers);
            em.persist(roles);
            for (User listUsersUser : roles.getListUsers()) {
                Roles oldRole_idOfListUsersUser = listUsersUser.getRole_id();
                listUsersUser.setRole_id(roles);
                listUsersUser = em.merge(listUsersUser);
                if (oldRole_idOfListUsersUser != null) {
                    oldRole_idOfListUsersUser.getListUsers().remove(listUsersUser);
                    oldRole_idOfListUsersUser = em.merge(oldRole_idOfListUsersUser);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Roles roles) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Roles persistentRoles = em.find(Roles.class, roles.getRole_id());
            List<User> listUsersOld = persistentRoles.getListUsers();
            List<User> listUsersNew = roles.getListUsers();
            List<User> attachedListUsersNew = new ArrayList<User>();
            for (User listUsersNewUserToAttach : listUsersNew) {
                listUsersNewUserToAttach = em.getReference(listUsersNewUserToAttach.getClass(), listUsersNewUserToAttach.getId_users());
                attachedListUsersNew.add(listUsersNewUserToAttach);
            }
            listUsersNew = attachedListUsersNew;
            roles.setListUsers(listUsersNew);
            roles = em.merge(roles);
            for (User listUsersOldUser : listUsersOld) {
                if (!listUsersNew.contains(listUsersOldUser)) {
                    listUsersOldUser.setRole_id(null);
                    listUsersOldUser = em.merge(listUsersOldUser);
                }
            }
            for (User listUsersNewUser : listUsersNew) {
                if (!listUsersOld.contains(listUsersNewUser)) {
                    Roles oldRole_idOfListUsersNewUser = listUsersNewUser.getRole_id();
                    listUsersNewUser.setRole_id(roles);
                    listUsersNewUser = em.merge(listUsersNewUser);
                    if (oldRole_idOfListUsersNewUser != null && !oldRole_idOfListUsersNewUser.equals(roles)) {
                        oldRole_idOfListUsersNewUser.getListUsers().remove(listUsersNewUser);
                        oldRole_idOfListUsersNewUser = em.merge(oldRole_idOfListUsersNewUser);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = roles.getRole_id();
                if (findRoles(id) == null) {
                    throw new NonexistentEntityException("The roles with id " + id + " no longer exists.");
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
            Roles roles;
            try {
                roles = em.getReference(Roles.class, id);
                roles.getRole_id();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The roles with id " + id + " no longer exists.", enfe);
            }
            List<User> listUsers = roles.getListUsers();
            for (User listUsersUser : listUsers) {
                listUsersUser.setRole_id(null);
                listUsersUser = em.merge(listUsersUser);
            }
            em.remove(roles);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Roles> findRolesEntities() {
        return findRolesEntities(true, -1, -1);
    }

    public List<Roles> findRolesEntities(int maxResults, int firstResult) {
        return findRolesEntities(false, maxResults, firstResult);
    }

    private List<Roles> findRolesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Roles.class));
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

    public Roles findRoles(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Roles.class, id);
        } finally {
            em.close();
        }
    }

    public int getRolesCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Roles> rt = cq.from(Roles.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}

package Controllers;

import Models.Message;
import Models.User;
import Models.MessageStatus;
import persistencia.exceptions.NonexistentEntityException;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class MessageJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public MessageJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public MessageJpaController() {
        emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // 1. Crear mensaje
    public void create(Message message) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            if (message.getStatus() == null) {
                message.setStatus(MessageStatus.UNREAD);
            }
            em.persist(message);
            em.getTransaction().commit();
            System.out.println("✅ Mensaje enviado");
        } catch (Exception e) {
            System.out.println("❌ Error al guardar el mensaje:");
            e.printStackTrace();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    // 2. Obtener mensajes entre dos usuarios
    public List<Message> findMessagesBetween(User user1, User user2) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Message> query = em.createQuery(
                    "SELECT m FROM Message m WHERE "
                    + "(m.sender = :user1 AND m.receiver = :user2) OR "
                    + "(m.sender = :user2 AND m.receiver = :user1) "
                    + "ORDER BY m.sentDate ASC", Message.class);
            query.setParameter("user1", user1);
            query.setParameter("user2", user2);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // 3. Marcar como leídos todos los mensajes de user2 a user1
    public void markMessagesAsRead(User receptor, User emisor) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery(
                    "UPDATE Message m SET m.status = :readStatus "
                    + "WHERE m.receiver = :receptor AND m.sender = :emisor AND m.status = :unreadStatus");
            query.setParameter("readStatus", MessageStatus.READ);
            query.setParameter("unreadStatus", MessageStatus.UNREAD);
            query.setParameter("receptor", receptor);
            query.setParameter("emisor", emisor);
            query.executeUpdate();
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    // 4. Eliminar mensaje por ID (física)
    public void destroy(int id) throws NonexistentEntityException {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Message message = em.find(Message.class, id);
            if (message == null) {
                throw new NonexistentEntityException("El mensaje con id " + id + " no existe.");
            }
            em.remove(message);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    // 5. Eliminar toda la conversación entre dos usuarios
    public void deleteConversation(User user1, User user2) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery(
                    "DELETE FROM Message m WHERE "
                    + "(m.sender = :user1 AND m.receiver = :user2) OR "
                    + "(m.sender = :user2 AND m.receiver = :user1)");
            query.setParameter("user1", user1);
            query.setParameter("user2", user2);
            int deletedCount = query.executeUpdate();
            em.getTransaction().commit();
            System.out.println("🗑️ Conversación eliminada (" + deletedCount + " mensajes)");
        } catch (Exception e) {
            System.out.println("❌ Error al eliminar la conversación:");
            e.printStackTrace();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    // 6. Buscar un mensaje por ID
    public Message findMessage(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Message.class, id);
        } finally {
            em.close();
        }
    }

    // 7. Obtener lista de usuarios únicos que me han enviado mensajes
    public List<User> findUsersWhoMessaged(User user) {
        EntityManager em = getEntityManager();
    try {
        System.out.println("Buscando conversaciones para el usuario: " + user.getId_users());

        List<User> enviados = em.createQuery(
            "SELECT DISTINCT m.receiver FROM Message m WHERE m.sender = :user", User.class)
            .setParameter("user", user)
            .getResultList();
        System.out.println("Usuarios a los que se enviaron mensajes: " + enviados.size());

        List<User> recibidos = em.createQuery(
            "SELECT DISTINCT m.sender FROM Message m WHERE m.receiver = :user", User.class)
            .setParameter("user", user)
            .getResultList();
        System.out.println("Usuarios que enviaron mensajes: " + recibidos.size());

        Set<User> conversaciones = new LinkedHashSet<>();
        conversaciones.addAll(enviados);
        conversaciones.addAll(recibidos);

        System.out.println("Conversaciones únicas encontradas: " + conversaciones.size());

        return new ArrayList<>(conversaciones);
    } finally {
        em.close();
    }
    }

    // 8. Obtener mensajes no leídos
    public List<Message> getUnreadMessages(User user) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<Message> query = em.createQuery(
                    "SELECT m FROM Message m WHERE m.receiver = :user AND m.status = :unreadStatus", Message.class);
            query.setParameter("user", user);
            query.setParameter("unreadStatus", MessageStatus.UNREAD);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void deleteConversationAll(User user1, User user2) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery(
                    "DELETE FROM Message m WHERE "
                    + "(m.sender = :user1 AND m.receiver = :user2) OR "
                    + "(m.sender = :user2 AND m.receiver = :user1)");
            query.setParameter("user1", user1);
            query.setParameter("user2", user2);
            query.executeUpdate();
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
    
    public User getUserById(int id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }
}

package Controllers;

import Models.HousingCategory;
import persistencia.exceptions.NonexistentEntityException;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class HousingCategoryJpaController implements Serializable {

    private EntityManagerFactory emf = null;

    public HousingCategoryJpaController() {
        this.emf = Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }

    public HousingCategoryJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // CREATE
    public void create(HousingCategory housingCategory) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query q = em.createNativeQuery("CALL sp_create_housing_category(?, ?)");
            q.setParameter(1, housingCategory.getCategoryName());
            q.setParameter(2, housingCategory.getCategoryDescription());
            q.executeUpdate();
            em.getTransaction().commit();
            System.out.println("Categoría creada correctamente.");
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.err.println("Error al crear categoría: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // UPDATE
    public void edit(HousingCategory housingCategory) throws NonexistentEntityException {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query q = em.createNativeQuery("CALL sp_update_housing_category(?, ?, ?)");
            q.setParameter(1, housingCategory.getCategoryId());
            q.setParameter(2, housingCategory.getCategoryName());
            q.setParameter(3, housingCategory.getCategoryDescription());
            int updated = q.executeUpdate();
            em.getTransaction().commit();
            if (updated == 0) {
                throw new NonexistentEntityException("La categoría con ID " + housingCategory.getCategoryId() + " no existe.");
            }
            System.out.println("Categoría actualizada correctamente.");
        } catch (NonexistentEntityException e) {
            em.getTransaction().rollback();
            throw e;
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.err.println("Error al actualizar categoría: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // DELETE
    public void destroy(int id) throws NonexistentEntityException {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Query q = em.createNativeQuery("CALL sp_delete_housing_category(?)");
            q.setParameter(1, id);
            int deleted = q.executeUpdate();
            em.getTransaction().commit();
            if (deleted == 0) {
                throw new NonexistentEntityException("La categoría con ID " + id + " no existe.");
            }
            System.out.println("Categoría eliminada correctamente.");
        } catch (NonexistentEntityException e) {
            em.getTransaction().rollback();
            throw e;
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.err.println("Error al eliminar categoría: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // LIST ALL
    public List<HousingCategory> findHousingCategoryEntities() {
        EntityManager em = getEntityManager();
        List<HousingCategory> list = new ArrayList<>();
        try {
            List<Object[]> results = em.createNativeQuery("CALL sp_get_all_housing_categories()").getResultList();
            for (Object[] row : results) {
                HousingCategory hc = new HousingCategory();
                hc.setCategoryId((Integer) row[0]);
                hc.setCategoryName((String) row[1]);
                hc.setCategoryDescription((String) row[2]);
                list.add(hc);
            }
            System.out.println("Categorías listadas: " + list.size());
        } catch (Exception e) {
            System.err.println("Error al listar categorías: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
        return list;
    }

    // FIND BY ID
    public HousingCategory findHousingCategory(int id) {
        EntityManager em = getEntityManager();
        HousingCategory hc = null;
        try {
            Query q = em.createNativeQuery("CALL sp_get_housing_category_by_id(?)");
            q.setParameter(1, id);
            List<Object[]> result = q.getResultList();
            if (!result.isEmpty()) {
                Object[] row = result.get(0);
                hc = new HousingCategory();
                hc.setCategoryId((Integer) row[0]);
                hc.setCategoryName((String) row[1]);
                hc.setCategoryDescription((String) row[2]);
            }
        } catch (Exception e) {
            System.err.println("Error al buscar categoría por ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
        return hc;
    }

    // FIND BY NAME
    public HousingCategory getHousingCategoryByName(String categoryName) {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            System.out.println(" Nombre de categoría es nulo o vacío.");
            return null;
        }

        EntityManager em = getEntityManager();
        HousingCategory hc = null;
        try {
            Query q = em.createNativeQuery("CALL sp_get_housing_category_by_name(?)");
            q.setParameter(1, categoryName.trim());
            List<Object[]> result = q.getResultList();
            if (!result.isEmpty()) {
                Object[] row = result.get(0);
                hc = new HousingCategory();
                hc.setCategoryId((Integer) row[0]);
                hc.setCategoryName((String) row[1]);
                hc.setCategoryDescription((String) row[2]);
            } else {
                System.out.println(" No se encontró categoría con nombre: " + categoryName);
            }
        } catch (Exception e) {
            System.err.println("Error al buscar categoría por nombre: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }

        return hc;
    }

    // COUNT
    public int getHousingCategoryCount() {
        return findHousingCategoryEntities().size();
    }
}

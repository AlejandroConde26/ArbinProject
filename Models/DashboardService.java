package Models;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

public class DashboardService {
    private EntityManagerFactory emf;

    public DashboardService(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public List<TopHousingReservation> getTopHousingReservations(int year) {
        EntityManager em = emf.createEntityManager();
        List<TopHousingReservation> reservations = new ArrayList<>();

        try {
            Query query = em.createNativeQuery(
                "CALL sp_get_top_housing_reservations(?1)"
            );
            query.setParameter(1, year);
            List<Object[]> results = query.getResultList();

            for (Object[] row : results) {
                int month = ((Number) row[0]).intValue();
                int housingId = ((Number) row[1]).intValue();
                int totalReservations = ((Number) row[2]).intValue();

                String housingName = getHousingName(housingId, em);

                reservations.add(new TopHousingReservation(month, housingId, housingName, totalReservations));
            }
        } finally {
            if (em != null) em.close();
        }
        return reservations;
    }

    public HousingMetrics getHousingMetrics(int housingId, int month, int year) {
        EntityManager em = emf.createEntityManager();
        try {
            Query query = em.createNativeQuery(
                "CALL sp_get_housing_metrics(?1, ?2, ?3)"
            );
            query.setParameter(1, housingId);
            query.setParameter(2, month);
            query.setParameter(3, year);
            Object[] result = (Object[]) query.getSingleResult();

            double totalRevenue = ((Number) result[0]).doubleValue();
            double averageOccupancy = ((Number) result[1]).doubleValue();
            int totalGuests = ((Number) result[2]).intValue();
            int stars = ((Number) result[3]).intValue();
            String city = (String) result[4];
            String country = (String) result[5];
            String housingName = (String) result[6];
            String hostName = (String) result[7];

            return new HousingMetrics(housingName, hostName, city, country, totalRevenue, totalGuests, stars, averageOccupancy);
        } catch (Exception e) {
            return null; // Manejar error en el servlet
        } finally {
            if (em != null) em.close();
        }
    }

    private String getHousingName(int housingId, EntityManager em) {
        Query query = em.createNativeQuery(
            "SELECT h.commercialName FROM housing h WHERE h.housingId = ?1"
        );
        query.setParameter(1, housingId);
        try {
            return (String) query.getSingleResult();
        } catch (Exception e) {
            return "Unknown";
        }
    }
}

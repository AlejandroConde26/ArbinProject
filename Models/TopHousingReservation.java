package Models;

import java.io.Serializable;

public class TopHousingReservation implements Serializable {
    private int reservationMonth;
    private int housingId;
    private String housingName;
    private int totalReservations;

    public TopHousingReservation(){}
    
    public TopHousingReservation(int reservationMonth, int housingId, String housingName, int totalReservations) {
        this.reservationMonth = reservationMonth;
        this.housingId = housingId;
        this.housingName = housingName;
        this.totalReservations = totalReservations;
    }

    public int getReservationMonth() {
        return reservationMonth;
    }

    public int getHousingId() {
        return housingId;
    }

    public String getHousingName() {
        return housingName;
    }

    public int getTotalReservations() {
        return totalReservations;
    }
}

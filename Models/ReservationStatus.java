package Models;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
public class ReservationStatus implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int reservationStatusId;

    @Column(nullable = false, length = 100)
    private String statusName;
    
     @OneToMany(mappedBy = "reservationStatusId", cascade = CascadeType.ALL)
    private List<Reservation> reservationList;


    // Constructor vacío
    public ReservationStatus() {
    }

    public ReservationStatus(int reservationStatusId, String statusName, List<Reservation> reservationList) {
        this.reservationStatusId = reservationStatusId;
        this.statusName = statusName;
        this.reservationList = reservationList;
    }

    public List<Reservation> getReservationList() {
        return reservationList;
    }

    public void setReservationList(List<Reservation> reservationList) {
        this.reservationList = reservationList;
    }

  
    // Getters y Setters
    public int getReservationStatusId() {
        return reservationStatusId;
    }

    public void setReservationStatusId(int reservationStatusId) {
        this.reservationStatusId = reservationStatusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    
}

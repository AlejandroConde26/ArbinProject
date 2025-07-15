package Models;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
public class ReviewHousing implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_reviewHousing;

    private String description;
    private int score;
    private String stadia_des;

    @Column(nullable = false)
    private LocalDate createdDate;

    private LocalDate updatedDate;


    @OneToOne
    @JoinColumn(name = "reservation_id", nullable = false, unique = true)
    private Reservation reservation;

    public ReviewHousing() {
    }

    public ReviewHousing(int id_reviewHousing, String description, int score, String stadia_des,
                         LocalDate createdDate, LocalDate updatedDate, Reservation reservation) {
        this.id_reviewHousing = id_reviewHousing;
        this.description = description;
        this.score = score;
        this.stadia_des = stadia_des;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.reservation = reservation;
    }

    public int getId_reviewHousing() {
        return id_reviewHousing;
    }

    public void setId_reviewHousing(int id_reviewHousing) {
        this.id_reviewHousing = id_reviewHousing;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getStadia_des() {
        return stadia_des;
    }

    public void setStadia_des(String stadia_des) {
        this.stadia_des = stadia_des;
    }

    public LocalDate getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }

    public LocalDate getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDate updatedDate) {
        this.updatedDate = updatedDate;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    @PrePersist
    protected void onCreate() {
        this.createdDate = LocalDate.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedDate = LocalDate.now();
    }
}

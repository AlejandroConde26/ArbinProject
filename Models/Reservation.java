package Models;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Reservation implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int reservationId;

    @Column(nullable = false)
    private LocalDate startDate;

    @Column(nullable = false)
    private LocalDate endDate;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User userId;

    @ManyToOne
    @JoinColumn(name = "housing_id", nullable = false)
    private Housing housingId;

    @Column(nullable = false)
    private float totalPrice;

    @Column(nullable = false)
    private float tax;

    @Column(nullable = false)
    private int numberOfAdults;

    @Column(nullable = false)
    private int numberOfChildren;

    @ManyToOne
    @JoinColumn(name = "reservation_status_id", nullable = false)
    private ReservationStatus reservationStatusId;

    @Column(nullable = false)
    private LocalDate createdDate;

    private LocalDate updatedDate;

    @OneToMany(mappedBy = "reservation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Payment> listPayment = new ArrayList<>();

    @OneToOne(mappedBy = "reservation", cascade = CascadeType.ALL, orphanRemoval = true)
    private ReviewHousing reviewHousing;

    // Constructor vacío
    public Reservation() {
    }

    public Reservation(int reservationId, LocalDate startDate, LocalDate endDate, User userId,
                       Housing housingId, float totalPrice, float tax, int numberOfAdults,
                       int numberOfChildren, ReservationStatus reservationStatusId,
                       LocalDate createdDate, LocalDate updatedDate) {
        this.reservationId = reservationId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.housingId = housingId;
        this.totalPrice = totalPrice;
        this.tax = tax;
        this.numberOfAdults = numberOfAdults;
        this.numberOfChildren = numberOfChildren;
        this.reservationStatusId = reservationStatusId;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Housing getHousingId() {
        return housingId;
    }

    public void setHousingId(Housing housingId) {
        this.housingId = housingId;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public float getTax() {
        return tax;
    }

    public void setTax(float tax) {
        this.tax = tax;
    }

    public int getNumberOfAdults() {
        return numberOfAdults;
    }

    public void setNumberOfAdults(int numberOfAdults) {
        this.numberOfAdults = numberOfAdults;
    }

    public int getNumberOfChildren() {
        return numberOfChildren;
    }

    public void setNumberOfChildren(int numberOfChildren) {
        this.numberOfChildren = numberOfChildren;
    }

    public ReservationStatus getReservationStatusId() {
        return reservationStatusId;
    }

    public void setReservationStatusId(ReservationStatus reservationStatusId) {
        this.reservationStatusId = reservationStatusId;
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

    public List<Payment> getListPayment() {
        return listPayment;
    }

    public void setListPayment(List<Payment> listPayment) {
        this.listPayment = listPayment;
    }

    public ReviewHousing getReviewHousing() {
        return reviewHousing;
    }

    public void setReviewHousing(ReviewHousing reviewHousing) {
        this.reviewHousing = reviewHousing;
        if (reviewHousing != null) {
            reviewHousing.setReservation(this);
        }
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

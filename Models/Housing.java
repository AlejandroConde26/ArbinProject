package Models;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Housing implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int housingId;

    @ManyToOne
    @JoinColumn(name = "host_id", nullable = false)
    private Host hostId;

    @Column(nullable = false)
    private String commercialName;

    private String description;
    private String characteristics;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String city;

    private int num_room;
    private String country;
    private int stars;
    private int numHabitaciones;
    private float priceNight;

    @ManyToOne
    @JoinColumn(name = "id_housingcategory", nullable = false)
    private HousingCategory id_housingcategory;

    @OneToMany(mappedBy = "housingId", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<HousingImage> housingImages;

    private String latitude;
    private String longitude;
    private String status;

    @OneToMany(mappedBy = "housingId", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Reservation> reservations = new ArrayList<>();

    @Column(nullable = false)
    private LocalDate createdDate;

    private LocalDate updatedDate;

    @ManyToMany(mappedBy = "housings")
    private List<Services> listservices = new ArrayList<>();

    @OneToMany(mappedBy = "id_housing", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Furniture> furnitures = new ArrayList<>();

    // Constructor con todos los parámetros
    public Housing(Host hostId, String commercialName, String description, String characteristics, String address, String city,
                   int num_room, String country, int stars, int numHabitaciones, float priceNight, HousingCategory id_housingcategory,
                   List<HousingImage> housingImages, String latitude, String longitude, String status,
                   List<Reservation> reservations, List<Services> listservices, List<Furniture> furnitures) {
        this.hostId = hostId;
        this.commercialName = commercialName;
        this.description = description;
        this.characteristics = characteristics;
        this.address = address;
        this.city = city;
        this.num_room = num_room;
        this.country = country;
        this.stars = stars;
        this.numHabitaciones = numHabitaciones;
        this.priceNight = priceNight;
        this.id_housingcategory = id_housingcategory;
        this.housingImages = housingImages;
        this.latitude = latitude;
        this.longitude = longitude;
        this.status = status;
        this.reservations = reservations;
        this.listservices = listservices;
        this.furnitures = furnitures;
    }

    // Constructor sin parámetros (útil para JPA)
    public Housing() {
        this.housingImages = new ArrayList<>();
        this.reservations = new ArrayList<>();
        this.listservices = new ArrayList<>();
        this.furnitures = new ArrayList<>();
    }

    // Métodos getter y setter
    public int getHousingId() {
        return housingId;
    }

    public void setHousingId(int housingId) {
        this.housingId = housingId;
    }

    public Host getHostId() {
        return hostId;
    }

    public void setHostId(Host hostId) {
        this.hostId = hostId;
    }

    public String getCommercialName() {
        return commercialName;
    }

    public void setCommercialName(String commercialName) {
        this.commercialName = commercialName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCharacteristics() {
        return characteristics;
    }

    public void setCharacteristics(String characteristics) {
        this.characteristics = characteristics;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getNum_room() {
        return num_room;
    }

    public void setNum_room(int num_room) {
        this.num_room = num_room;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public int getStars() {
        return stars;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }

    public int getNumHabitaciones() {
        return numHabitaciones;
    }

    public void setNumHabitaciones(int numHabitaciones) {
        this.numHabitaciones = numHabitaciones;
    }

    public float getPriceNight() {
        return priceNight;
    }

    public void setPriceNight(float priceNight) {
        this.priceNight = priceNight;
    }

    public HousingCategory getId_housingcategory() {
        return id_housingcategory;
    }

    public void setId_housingcategory(HousingCategory id_housingcategory) {
        this.id_housingcategory = id_housingcategory;
    }

    public List<HousingImage> getHousingImages() {
        return housingImages;
    }

    public void setHousingImages(List<HousingImage> housingImages) {
        this.housingImages = housingImages;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
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

    public List<Services> getListservices() {
        return listservices;
    }

    public void setListservices(List<Services> listservices) {
        this.listservices = listservices;
    }

    public List<Furniture> getFurnitures() {
        return furnitures;
    }

    public void setFurnitures(List<Furniture> furnitures) {
        this.furnitures = furnitures;
    }
}
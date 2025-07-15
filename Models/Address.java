package Models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.OneToOne;
import java.io.Serializable;

@Entity
public class Address implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_address;

    @OneToOne(mappedBy = "address_id")
    private User user;

    private String address_postal;
    private String apartment_n;
    private String country;
    private String ciudad;
    private String departament;
    private String code_postal;

    public Address() {
    }

    public Address(int id_address, User user, String address_postal, String apartment_n, String country, String ciudad, String departament, String code_postal) {
        this.id_address = id_address;
        this.user = user;
        this.address_postal = address_postal;
        this.apartment_n = apartment_n;
        this.country = country;
        this.ciudad = ciudad;
        this.departament = departament;
        this.code_postal = code_postal;
    }

    public int getId_address() {
        return id_address;
    }

    public void setId_address(int id_address) {
        this.id_address = id_address;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAddress_postal() {
        return address_postal;
    }

    public void setAddress_postal(String address_postal) {
        this.address_postal = address_postal;
    }

    public String getApartment_n() {
        return apartment_n;
    }

    public void setApartment_n(String apartment_n) {
        this.apartment_n = apartment_n;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getDepartament() {
        return departament;
    }

    public void setDepartament(String departament) {
        this.departament = departament;
    }

    public String getCode_postal() {
        return code_postal;
    }

    public void setCode_postal(String code_postal) {
        this.code_postal = code_postal;
    }
}
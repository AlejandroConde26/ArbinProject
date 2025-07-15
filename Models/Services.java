package Models;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
public class Services implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_service;
    private String name_service;
    private String description;
    private boolean status;

   
  // Relación bidireccional Many-to-Many con Housing
    @ManyToMany
    @JoinTable(
        name = "housing_services",  // Nombre de la tabla intermedia
        joinColumns = @JoinColumn(name = "service_id"),  // Columna que referencia a Services
        inverseJoinColumns = @JoinColumn(name = "housing_id") // Columna que referencia a Housing
    )
    private List<Housing> housings;
    // Constructor vacío
    public Services() {}

    public Services(int id_service, String name_service, String description, boolean status) {
        this.id_service = id_service;
        this.name_service = name_service;
        this.description = description;
        this.status = status;
    }

    // Getters y Setters
    public List<Housing> getHousings() {
        return housings;
    }

    public void setHousings(List<Housing> housings) {
        this.housings = housings;
    }

    public int getId_service() {
        return id_service;
    }

    public void setId_service(int id_service) {
        this.id_service = id_service;
    }

    public String getName_service() {
        return name_service;
    }

    public void setName_service(String name_service) {
        this.name_service = name_service;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
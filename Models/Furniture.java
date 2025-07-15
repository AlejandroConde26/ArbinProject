package Models;
import java.time.LocalDate;
import javax.persistence.*;

@Entity
@Table(name = "furniture")
public class Furniture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_furniture")
    private Integer idFurniture;

    @Column(name = "furniture_type", nullable = false)
    private String furnitureType;
    
    @ManyToOne
    @JoinColumn(name = "id_housing", nullable = false)
    private Housing id_housing;
    
    @Column(name = "quantity", nullable = false)
    private Integer quantity;  // Cantidad de muebles

    @Column(name = "description")
    private String description;  // Descripción adicional

  
     @Column(nullable = false)
    private LocalDate createdDate;

    private LocalDate updatedDate;

    public Furniture() {
    }

    public Furniture(Integer idFurniture, String furnitureType, Housing id_housing, Integer quantity, String description, LocalDate createdDate, LocalDate updatedDate) {
        this.idFurniture = idFurniture;
        this.furnitureType = furnitureType;
        this.id_housing = id_housing;
        this.quantity = quantity;
        this.description = description;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public Integer getIdFurniture() {
        return idFurniture;
    }

    public void setIdFurniture(Integer idFurniture) {
        this.idFurniture = idFurniture;
    }

    public String getFurnitureType() {
        return furnitureType;
    }

    public void setFurnitureType(String furnitureType) {
        this.furnitureType = furnitureType;
    }

    public Housing getId_housing() {
        return id_housing;
    }

    public void setId_housing(Housing id_housing) {
        this.id_housing = id_housing;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

   
    @PrePersist
    protected void onCreate() {
        this.createdDate = LocalDate.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedDate = LocalDate.now();
    }
}
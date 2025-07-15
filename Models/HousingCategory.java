package Models;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
public class HousingCategory implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int categoryId;

    @Column(nullable = false)
    private String categoryName;

    private String categoryDescription;

    @OneToMany(mappedBy = "id_housingcategory", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Housing> housing;

    // Constructor vacío
    public HousingCategory() {
    }

    public HousingCategory(int categoryId, String categoryName, String categoryDescription, List<Housing> housing) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryDescription = categoryDescription;
        this.housing = housing;
    }

    public List<Housing> getHousing() {
        return housing;
    }

    public void setHousing(List<Housing> housing) {
        this.housing = housing;
    }

   

    // Getters y Setters
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDescription() {
        return categoryDescription;
    }

    public void setCategoryDescription(String categoryDescription) {
        this.categoryDescription = categoryDescription;
    }
}

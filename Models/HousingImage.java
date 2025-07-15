package Models;

import javax.persistence.*;
import java.io.Serializable;

@Entity
public class HousingImage implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int housingImageId;

    @ManyToOne
    @JoinColumn(name = "housing_id", nullable = false)
    private Housing housingId;

    @Column(nullable = false)
    private String imageUrl;

    private String caption;

    // Constructor vacío
    public HousingImage() {
    }

    public HousingImage(int housingImageId, Housing housingId, String imageUrl, String caption) {
        this.housingImageId = housingImageId;
        this.housingId = housingId;
        this.imageUrl = imageUrl;
        this.caption = caption;
    }

    public int getHousingImageId() {
        return housingImageId;
    }

    public void setHousingImageId(int housingImageId) {
        this.housingImageId = housingImageId;
    }

    public Housing getHousingId() {
        return housingId;
    }

    public void setHousingId(Housing housingId) {
        this.housingId = housingId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

   
}

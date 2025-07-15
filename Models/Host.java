package Models;

import java.time.LocalDate;
import java.util.ArrayList;
import javax.persistence.*;
import java.util.List;

@Entity
public class Host {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_Host;
    
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id_users", nullable = false)
    private User id_user;


    @Column(nullable = false)
    private LocalDate createdDate;

    private LocalDate updatedDate;
    
    @OneToMany(mappedBy = "hostId", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Housing> housings = new ArrayList<>();

    
    public Host() {}

    public Host(int id_Host, User id_user, LocalDate createdDate, LocalDate updatedDate) {
        this.id_Host = id_Host;
        this.id_user = id_user;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }

    public List<Housing> getHousings() {
        return housings;
    }

    public void setHousings(List<Housing> housings) {
        this.housings = housings;
    }

  

    public int getId_Host() {
        return id_Host;
    }

    public void setId_Host(int id_Host) {
        this.id_Host = id_Host;
    }

    public User getId_user() {
        return id_user;
    }

    public void setId_user(User id_user) {
        this.id_user = id_user;
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

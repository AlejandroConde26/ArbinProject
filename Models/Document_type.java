package Models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.util.List;

@Entity
public class Document_type implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int document_type;

    private String name;
    private String description;

    @OneToMany(mappedBy = "document_type_id")
    private List<User> listUsers;

    public Document_type() {
    }

    public Document_type(int document_type, String name, String description, List<User> listUsers) {
        this.document_type = document_type;
        this.name = name;
        this.description = description;
        this.listUsers = listUsers;
    }

    public int getDocument_type() {
        return document_type;
    }

    public void setDocument_type(int document_type) {
        this.document_type = document_type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<User> getListUsers() {
        return listUsers;
    }

    public void setListUsers(List<User> listUsers) {
        this.listUsers = listUsers;
    }
}

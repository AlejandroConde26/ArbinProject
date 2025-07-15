
package Models;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
@Entity
public class User implements Serializable {
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_users;

    private String full_name;
    private String last_name;
    private String email;
    private String num_document;

    @ManyToOne
    @JoinColumn(name = "document_type_id")
    private Document_type document_type_id;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Roles role_id;

    private String password;
    private String phone;
    private boolean is_active;
    private String url_img_perfile;

     @Column(nullable = false)
    private LocalDate createdDate;

    private LocalDate updatedDate;

    
    @OneToMany(mappedBy = "user_id")
    private List<Sessions> listSessiones;


    @OneToMany(mappedBy = "user_id")
    private List<Activity_log> listActivity_log;
    
    @OneToMany(mappedBy = "userId", cascade = CascadeType.ALL)
    private List<Reservation> reservationList;
    
    @OneToOne
    @JoinColumn(name = "address_id")
    private Address address_id;
   
//    
//    //222222222
//    @OneToOne(mappedBy = "id_user", cascade = CascadeType.ALL, orphanRemoval = true)
//    private Host host_id;
//    
    @OneToOne(mappedBy = "id_user")
    private Host host_id;
   
    
    private String emergency_contact;

    @OneToMany(mappedBy = "sender")
    private List<Message> sentMessages;
    @OneToMany(mappedBy = "receiver")
    private List<Message> receiverMessages;
    
    public User(){ 
    }

    public User(int id_users, String full_name, String last_name, String email, String num_document, Document_type document_type_id, Roles role_id, String password, String phone, boolean is_active, LocalDate createdDate, LocalDate updatedDate, List<Sessions> listSessiones, List<Activity_log> listActivity_log, List<Reservation> reservationList, Address address_id, Host host_id, String emergency_contact, List<Message> sentMessages,String url_img_perfile) {
        this.id_users = id_users;
        this.full_name = full_name;
        this.last_name = last_name;
        this.email = email;
        this.num_document = num_document;
        this.document_type_id = document_type_id;
        this.role_id = role_id;
        this.password = password;
        this.phone = phone;
        this.is_active = is_active;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.listSessiones = listSessiones;
        this.listActivity_log = listActivity_log;
        this.reservationList = reservationList;
        this.address_id = address_id;
        this.host_id = host_id;
        this.emergency_contact = emergency_contact;
        this.sentMessages = sentMessages;
        this.url_img_perfile = url_img_perfile;
    }

    public int getId_users() {
        return id_users;
    }

    public void setId_users(int id_users) {
        this.id_users = id_users;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNum_document() {
        return num_document;
    }

    public void setNum_document(String num_document) {
        this.num_document = num_document;
    }

    public Document_type getDocument_type_id() {
        return document_type_id;
    }

    public void setDocument_type_id(Document_type document_type_id) {
        this.document_type_id = document_type_id;
    }

    public Roles getRole_id() {
        return role_id;
    }

    public void setRole_id(Roles role_id) {
        this.role_id = role_id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isIs_active() {
        return is_active;
    }

    public void setIs_active(boolean is_active) {
        this.is_active = is_active;
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

    public List<Sessions> getListSessiones() {
        return listSessiones;
    }

    public void setListSessiones(List<Sessions> listSessiones) {
        this.listSessiones = listSessiones;
    }

    public List<Activity_log> getListActivity_log() {
        return listActivity_log;
    }

    public void setListActivity_log(List<Activity_log> listActivity_log) {
        this.listActivity_log = listActivity_log;
    }

    public List<Reservation> getReservationList() {
        return reservationList;
    }

    public void setReservationList(List<Reservation> reservationList) {
        this.reservationList = reservationList;
    }
    public Address getAddress_id() {
        return address_id;
    }

    public void setAddress_id(Address address_id) {
        this.address_id = address_id;
    }

    public Host getHost_id() {
        return host_id;
    }

    public void setHost_id(Host host_id) {
        this.host_id = host_id;
    }

    public String getEmergency_contact() {
        return emergency_contact;
    }

    public void setEmergency_contact(String emergency_contact) {
        this.emergency_contact = emergency_contact;
    }

    public List<Message> getSentMessages() {
        return sentMessages;
    }

    public void setSentMessages(List<Message> sentMessages) {
        this.sentMessages = sentMessages;
    }

    public String getUrl_img_perfile() {
        return url_img_perfile;
    }

    public void setUrl_img_perfile(String url_img_perfile) {
        this.url_img_perfile = url_img_perfile;
    }

    @PrePersist
    protected void onCreate() {
        this.createdDate = LocalDate.now();
    }

    public List<Message> getReceiverMessages() {
        return receiverMessages;
    }

    public void setReceiverMessages(List<Message> receiverMessages) {
        this.receiverMessages = receiverMessages;
    }
    
    @PreUpdate
    protected void onUpdate() {
        this.updatedDate = LocalDate.now();
    }
  
}

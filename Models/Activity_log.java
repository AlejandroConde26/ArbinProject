package Models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;

@Entity
public class Activity_log implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int activity_log_id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user_id;

    private String action;
    private String ip_adress;
    private String user_agent;

    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;

    public Activity_log() {
    }

    public Activity_log(int activity_log_id, User user_id, String action, String ip_adress, String user_agent, Date timestamp) {
        this.activity_log_id = activity_log_id;
        this.user_id = user_id;
        this.action = action;
        this.ip_adress = ip_adress;
        this.user_agent = user_agent;
        this.timestamp = timestamp;
    }

    public int getActivity_log_id() {
        return activity_log_id;
    }

    public void setActivity_log_id(int activity_log_id) {
        this.activity_log_id = activity_log_id;
    }

    public User getUser_id() {
        return user_id;
    }

    public void setUser_id(User user_id) {
        this.user_id = user_id;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getIp_adress() {
        return ip_adress;
    }

    public void setIp_adress(String ip_adress) {
        this.ip_adress = ip_adress;
    }

    public String getUser_agent() {
        return user_agent;
    }

    public void setUser_agent(String user_agent) {
        this.user_agent = user_agent;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
    
}


/*    public Activity_logJpaController(){
        emf =Persistence.createEntityManagerFactory("BookingSystemWeb_PU");
    }*/
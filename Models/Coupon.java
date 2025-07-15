package Models;
import java.math.BigDecimal;
import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "code", unique = true, nullable = false, length = 50)
    private String code;

    @Column(name = "description", length = 255)
    private String description;

    @Column(name = "discount_type", length = 20)
    private String discountType;

    @Column(name = "discount_value", precision = 10, scale = 2)
    private BigDecimal discountValue;

    @Column(name = "min_stay_nights")
    private Integer minStayNights;

    @Column(name = "valid_from")
    private LocalDate validFrom;

    @Column(name = "valid_until")
    private LocalDate validUntil;

    @Column(name = "usage_limit_per_coupon")
    private Integer usageLimitPerCoupon;

    @Column(name = "usage_limit_per_user")
    private Integer usageLimitPerUser;

    @Column(name = "active")
    private boolean active;

    public Coupon() {
    }

    public Coupon(String code, String description, String discountType, BigDecimal discountValue, Integer minStayNights, LocalDate validFrom, LocalDate validUntil, Integer usageLimitPerCoupon, Integer usageLimitPerUser, boolean active) {
        this.code = code;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minStayNights = minStayNights;
        this.validFrom = validFrom;
        this.validUntil = validUntil;
        this.usageLimitPerCoupon = usageLimitPerCoupon;
        this.usageLimitPerUser = usageLimitPerUser;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public Integer getMinStayNights() {
        return minStayNights;
    }

    public void setMinStayNights(Integer minStayNights) {
        this.minStayNights = minStayNights;
    }

    public LocalDate getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(LocalDate validFrom) {
        this.validFrom = validFrom;
    }

    public LocalDate getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(LocalDate validUntil) {
        this.validUntil = validUntil;
    }

    public Integer getUsageLimitPerCoupon() {
        return usageLimitPerCoupon;
    }

    public void setUsageLimitPerCoupon(Integer usageLimitPerCoupon) {
        this.usageLimitPerCoupon = usageLimitPerCoupon;
    }

    public Integer getUsageLimitPerUser() {
        return usageLimitPerUser;
    }

    public void setUsageLimitPerUser(Integer usageLimitPerUser) {
        this.usageLimitPerUser = usageLimitPerUser;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return "Coupon{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", description='" + description + '\'' +
                ", discountType='" + discountType + '\'' +
                ", discountValue=" + discountValue +
                ", minStayNights=" + minStayNights +
                ", validFrom=" + validFrom +
                ", validUntil=" + validUntil +
                ", usageLimitPerCoupon=" + usageLimitPerCoupon +
                ", usageLimitPerUser=" + usageLimitPerUser +
                ", active=" + active +
                '}';
    }
}
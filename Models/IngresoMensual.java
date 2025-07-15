package Models;
import java.io.Serializable;
public class IngresoMensual implements Serializable {

    private int mes;
    private double ingresoTotal;

    private int idHost;
    private String nombreHost;
    private int idHousing;
    private String nombreHousing;

    public IngresoMensual() {
    }

    public IngresoMensual(int mes, double ingresoTotal, int idHost, String nombreHost, int idHousing, String nombreHousing) {
        this.mes = mes;
        this.ingresoTotal = ingresoTotal;
        this.idHost = idHost;
        this.nombreHost = nombreHost;
        this.idHousing = idHousing;
        this.nombreHousing = nombreHousing;
    }

    public IngresoMensual(int mes, double ingresoTotal) {
        this.mes = mes;
        this.ingresoTotal = ingresoTotal;
    }

    public int getMes() {
        return mes;
    }

    public void setMes(int mes) {
        this.mes = mes;
    }

    public double getIngresoTotal() {
        return ingresoTotal;
    }

    public void setIngresoTotal(double ingresoTotal) {
        this.ingresoTotal = ingresoTotal;
    }

    public int getIdHost() {
        return idHost;
    }

    public void setIdHost(int idHost) {
        this.idHost = idHost;
    }

    public String getNombreHost() {
        return nombreHost;
    }

    public void setNombreHost(String nombreHost) {
        this.nombreHost = nombreHost;
    }

    public int getIdHousing() {
        return idHousing;
    }

    public void setIdHousing(int idHousing) {
        this.idHousing = idHousing;
    }

    public String getNombreHousing() {
        return nombreHousing;
    }

    public void setNombreHousing(String nombreHousing) {
        this.nombreHousing = nombreHousing;
    }
}
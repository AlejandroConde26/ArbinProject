/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.io.Serializable;
import java.util.Date;

public class HostReportes implements Serializable {
    private String nombre;
    private String correo;
    private String telefono;
    private int total;
    private double precioPromedio;
    private int cantidadCiudades;
    private int alojamientosActivos;
    private Date ultimaPublicacion;

    public HostReportes(String nombre, String correo, String telefono,
                        int total, double precioPromedio,
                        int cantidadCiudades, int alojamientosActivos,
                        Date ultimaPublicacion) {
        this.nombre = nombre;
        this.correo = correo;
        this.telefono = telefono;
        this.total = total;
        this.precioPromedio = precioPromedio;
        this.cantidadCiudades = cantidadCiudades;
        this.alojamientosActivos = alojamientosActivos;
        this.ultimaPublicacion = ultimaPublicacion;
    }

    public String getNombre() { return nombre; }
    public String getCorreo() { return correo; }
    public String getTelefono() { return telefono; }
    public int getTotal() { return total; }
    public double getPrecioPromedio() { return precioPromedio; }
    public int getCantidadCiudades() { return cantidadCiudades; }
    public int getAlojamientosActivos() { return alojamientosActivos; }
    public Date getUltimaPublicacion() { return ultimaPublicacion; }
}
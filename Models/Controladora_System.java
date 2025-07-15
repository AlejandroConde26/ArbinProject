package Models; // Assuming this is the correct package for Controladora_System

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import Controllers.Controladora_SystemPersistencia; // Correct import
import persistencia.exceptions.PreexistingEntityException;
import persistencia.exceptions.NonexistentEntityException; // Import if not already present

public class Controladora_System {
    Controladora_SystemPersistencia conPers = new Controladora_SystemPersistencia();

    // ---------------- USER ----------------
    public void crearUsuario(User usu) {
        conPers.crearUsuario(usu);
    }

    public List<User> getUsers() {
        return conPers.getUsers();
    }

    public User getUser(int id) {
        return conPers.getUser(id);
    }

    public void editarUsuario(User user) throws Exception {
        conPers.editarUsuario(user);
    }

    public void eliminarUsuario(int id) throws Exception {
        conPers.eliminarUsuario(id);
    }

    public User buscarUsuarioPorEmail(String email) {
        return conPers.buscarUsuarioPorEmail(email);
    }

    public User comprobarLogin(String email, String password) {
        List<User> listUsers = conPers.getUsers();
        for (User us : listUsers) {
            if (us.getEmail() != null && us.getPassword() != null) {
                if (us.getEmail().equals(email) && us.getPassword().equals(password)) {
                    return us;
                }
            }
        }
        return null;
    }

    public List<Housing> getHousingsByUser(int userId) {
        User user = conPers.getUser(userId);
        if (user != null && user.getHost_id() != null) {
            Host host = user.getHost_id();
            // This assumes that the relationship is well mapped and updated in the database
            return new ArrayList<>(host.getHousings());
        }
        return new ArrayList<>(); // Return empty list if not found
    }
     public List<Services> getHousingsServicios(int id) {
      return conPers.findServicesForHousing(id);
    }
     
     public void updateHousingServices(int housingId, List<Integer> selectedServiceIds) {
         conPers.updateHousingServices(housingId,selectedServiceIds);
     }
    // ---------------- ROLES ----------------
    public void crearRol(Roles rol) {
        conPers.crearRol(rol);
    }

    public List<Roles> getRoles() {
        return conPers.getRoles();
    }

    public Roles getRol(int id) {
        return conPers.getRol(id);
    }

    public void editarRol(Roles rol) throws Exception {
        conPers.editarRol(rol);
    }

    public void eliminarRol(int id) throws Exception {
        conPers.eliminarRol(id);
    }

    // ---------------- SESSIONS ----------------
    public void crearSesion(Sessions sesion) {
        conPers.crearSesion(sesion);
    }

    public List<Sessions> getSesiones() {
        return conPers.getSesiones();
    }

    public Sessions getSesion(int id) {
        return conPers.getSesion(id);
    }

    public void editarSesion(Sessions sesion) throws Exception {
        conPers.editarSesion(sesion);
    }

    public void eliminarSesion(int id) throws Exception {
        conPers.eliminarSesion(id);
    }

    // ---------------- ACTIVITY LOG ----------------
    public void crearActividad(Activity_log act) {
        conPers.crearActividad(act);
    }

    public List<Activity_log> getActividades() {
        return conPers.getActividades();
    }

    public Activity_log getActividad(int id) {
        return conPers.getActividad(id);
    }

    public void editarActividad(Activity_log act) throws Exception {
        conPers.editarActividad(act);
    }

    public void eliminarActividad(int id) throws Exception {
        conPers.eliminarActividad(id);
    }

    // ---------------- DOCUMENT TYPE ----------------
    public void crearTipoDocumento(Document_type doc) {
        conPers.crearTipoDocumento(doc);
    }

    public List<Document_type> getTiposDocumento() {
        return conPers.getTiposDocumento();
    }

    public Document_type getTipoDocumento(int id) {
        return conPers.getTipoDocumento(id);
    }

    public void editarTipoDocumento(Document_type doc) throws Exception {
        conPers.editarTipoDocumento(doc);
    }

    public void eliminarTipoDocumento(int id) throws Exception {
        conPers.eliminarTipoDocumento(id);
    }

    // ---------------- RESERVATION ----------------
    public void crearReserva(Reservation reserva) {
        conPers.crearReserva(reserva);
    }

    public List<Reservation> getReservas() {
        return conPers.getReservas();
    }

    public Reservation getReserva(int id) {
        return conPers.getReserva(id);
    }

    public void editarReserva(Reservation reserva) throws Exception {
        conPers.editarReserva(reserva);
    }

    public void eliminarReserva(int id) throws Exception {
        conPers.eliminarReserva(id);
    }

    public List<Reservation> traerReservacionUser(int id) {
        List<Reservation> todasLasReservas = conPers.getReservas();
        List<Reservation> reservasDelUsuario = new ArrayList<>();
        for (Reservation r : todasLasReservas) {
            if (r.getUserId().getId_users() == id) {
                reservasDelUsuario.add(r);
            }
        }
        return reservasDelUsuario;
    }

    // ---------------- RESERVATION STATUS ----------------
    public void crearReservationStatus(ReservationStatus status) {
        conPers.crearReservationStatus(status);
    }

    public List<ReservationStatus> getReservationStatuses() {
        return conPers.getReservationStatuses();
    }

    public ReservationStatus getReservationStatus(int id) {
        return conPers.getReservationStatus(id);
    }

    public void editarReservationStatus(ReservationStatus status) throws Exception {
        conPers.editarReservationStatus(status);
    }

    public void eliminarReservationStatus(int id) throws Exception {
        conPers.eliminarReservationStatus(id);
    }

    // ---------------- PAYMENT ----------------
    public void crearPago(Payment payment) {
        conPers.crearPayment(payment);
    }

    public List<Payment> getPagos() {
        return conPers.getPayments();
    }

    public Payment getPago(int id) {
        return conPers.getPayment(id);
    }

    public void editarPago(Payment payment) throws Exception {
        conPers.editarPayment(payment);
    }

    public void eliminarPago(int id) throws Exception {
        conPers.eliminarPayment(id);
    }

    // ---------------- PAYMENT METHOD ----------------
    public void crearMetodoPago(PaymentMethod paymentMethod) {
        conPers.crearPaymentMethod(paymentMethod);
    }

    public List<PaymentMethod> getMetodosPago() {
        return conPers.getPaymentMethods();
    }

    public PaymentMethod getMetodoPago(int id) {
        return conPers.getPaymentMethod(id);
    }

    public void editarMetodoPago(PaymentMethod paymentMethod) throws Exception {
        conPers.editarPaymentMethod(paymentMethod);
    }

    public void eliminarMetodoPago(int id) throws Exception {
        conPers.eliminarPaymentMethod(id);
    }

    // ---------------- REVIEW HOUSING ----------------
    public void crearReviewHousing(ReviewHousing reviewHousing) {
        conPers.crearReviewHousing(reviewHousing);
    }

    public List<ReviewHousing> getReviewHousings() {
        return conPers.getReviewHousings();
    }

    public ReviewHousing getReviewHousing(int id) {
        return conPers.getReviewHousing(id);
    }

    public void editarReviewHousing(ReviewHousing reviewHousing) throws Exception {
        conPers.editarReviewHousing(reviewHousing);
    }

    public void eliminarReviewHousing(int id) throws Exception {
        conPers.eliminarReviewHousing(id);
    }

    // ---------------- HOUSING ----------------
    public int crearyRetornarId(Housing housing) throws PreexistingEntityException {
        return conPers.crearyRetornarId(housing);
    }

    public List<Housing> getHousings() {
        return conPers.getHousings();
    }

    public Housing getHousing(int id) {
        return conPers.getHousing(id);
    }

    public void editarHousing(Housing housing) throws Exception {
        conPers.editarHousing(housing);
    }

    public void eliminarHousing(int id) throws Exception {
        conPers.eliminarHousing(id);
    }

    public List<Housing> findHousingsByHostId(int id) {
        return conPers.findHousingsByHostId(id);
    }

    public List<Housing> buscarHousingPorCiudad(String ciudad) {
        List<Housing> resultado = new ArrayList<>();
        for (Housing housing : getHousings()) {
            if (housing.getCity() != null && housing.getCity().toLowerCase().contains(ciudad.toLowerCase())) {
                resultado.add(housing);
            }
        }
        return resultado;
    }

    // ---------------- HOUSING CATEGORY ----------------
    public void crearHousingCategory(HousingCategory category) throws PreexistingEntityException {
        conPers.crearHousingCategory(category);
    }

    public List<HousingCategory> getHousingCategories() {
        return conPers.getHousingCategories();
    }

    public HousingCategory getHousingCategory(int id) {
        return conPers.getHousingCategory(id);
    }

    public void editarHousingCategory(HousingCategory category) throws Exception {
        conPers.editarHousingCategory(category);
    }

    public void eliminarHousingCategory(int id) throws Exception {
        conPers.eliminarHousingCategory(id);
    }
    
    public HousingCategory getHousingCategoryByName(String category) {
        return conPers.getHousingCategoryByName(category);
    }


    // ---------------- HOUSING IMAGE ----------------
    public void crearHousingImage(HousingImage image) throws PreexistingEntityException {
        conPers.crearHousingImage(image);
    }

    public List<HousingImage> getHousingImages() {
        return conPers.getHousingImages();
    }

    public HousingImage getHousingImage(int id) {
        return conPers.getHousingImage(id);
    }

    public void editarHousingImage(HousingImage image) throws Exception {
        conPers.editarHousingImage(image);
    }

    public void eliminarHousingImage(int id) throws Exception {
        conPers.eliminarHousingImage(id);
    }

    public List<Housing> buscarHousingPorFiltros(String ciudad, LocalDate llegada, LocalDate salida) {
        List<Housing> resultado = getHousings().stream()
            .filter(h -> h.getCity() != null && h.getCity().toLowerCase().contains(ciudad.toLowerCase()))
            .filter(h -> {
                List<Reservation> reservas = h.getReservations();
                if (reservas == null || reservas.isEmpty()) return true; // If no reservations, it's available
                return reservas.stream().noneMatch(res -> {
                    LocalDate checkIn = res.getStartDate();
                    LocalDate checkOut = res.getEndDate();
                    if (checkIn == null || checkOut == null) return false;
                    // If it overlaps, it's not valid
                    return !(salida.isBefore(checkIn) || llegada.isAfter(checkOut));
                });
            }).collect(Collectors.toList());
        return resultado;
    }

    // ---------------- HOST ----------------
    public void crearHost(Host host) throws PreexistingEntityException { // Added PreexistingEntityException if hostJPA.create can throw it
        conPers.crearHost(host);
    }

    public List<Host> getHosts() {
        return conPers.getHosts();
    }

    public Host getHost(int id) {
        return conPers.getHost(id);
    }

    public void editarHost(Host host) throws Exception {
        conPers.editarHost(host);
    }

    public void eliminarHost(int id) throws Exception {
        conPers.eliminarHost(id);
    }

    public Host buscarHostPorIdUser(int idUser) {
        List<Host> lista = getHosts();
        for (Host h : lista) {
            if (h.getId_user().getId_users() == idUser) {
                return h;
            }
        }
        return null;
    }

    public List<Housing> obtenerHousingPorCategoria(int categoryId) {
        List<Housing> todos = getHousings();
        List<Housing> filtrados = new ArrayList<>();
        for (Housing h : todos) {
            if (h.getId_housingcategory() != null && h.getId_housingcategory().getCategoryId() == categoryId) {
                filtrados.add(h);
            }
        }
        return filtrados;
    }

    // ---------------- ADDRESS ---------------- (Assuming Address methods are needed in Controladora_System)
    public List<Address> getAddress() {
        return conPers.getAddress();
    }

    public Address getAddre(int id) { // Consider renaming to getAddressById for clarity
        return conPers.getAddre(id);
    }

    // ---------------- USER COUNT ----------------
    public int getCountUser() {
        return conPers.getCountUsers();
    }

    // ---------------- SERVICES ---------------- (New methods for Services)
    public void crearServicio(Services service) {
        conPers.crearServicioPers(service);
    }

    public List<Services> getListaServicios() {
        return conPers.getListaServiciosPers();
    }

    public Services getServicio(int id) {
        return conPers.getServicioPers(id);
    }

    public void editarServicio(Services service) throws NonexistentEntityException, Exception {
        conPers.editarServicioPers(service);
    }

    public void eliminarServicio(int id) throws NonexistentEntityException, Exception {
        conPers.eliminarServicioPers(id);
    }
     public void crearMensaje(Message message) {
        conPers.crearMensaje(message);
    }

    public void eliminarMensaje(int id) throws NonexistentEntityException{
        conPers.eliminarMensaje(id);
    }
    
    public List<Message> getConversacion(User user1, User user2) {
        return conPers.getConversacion(user1, user2);
    }

    public void marcarComoLeido(User user1, User user2) {
        conPers.marcarComoLeido(user1, user2);
    }
    
    public Message getMensajes(int id) {
        return conPers.getMensajes(id);
    }
    
    public List<User> obtenerChatUser(User user){
        return conPers.obtenerChatUser(user);
    }
    
    public void eliminarConversacion(User user1, User user2){
        conPers.eliminarConversacion(user1, user2);
    }
    
    public List<Message> mensajeNoLeidos(User user){
        return conPers.mensajeNoLeidos(user);
    }
    
    public void eliminarConversacionEntera(User user1, User user2){
        conPers.eliminarConversacionEntera(user1, user2);
    }
    
    public User encontrarUser(int id){
        return conPers.encontrarUser(id);
    }

}

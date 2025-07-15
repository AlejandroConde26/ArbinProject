package Controllers; // Assuming this is the correct package for Controladora_SystemPersistencia

import java.util.List;
import Models.*; // Assuming your models (Services, Housing, etc.) are here
import java.util.ArrayList;
import persistencia.exceptions.PreexistingEntityException;
import persistencia.exceptions.NonexistentEntityException; // Import if not already present

public class Controladora_SystemPersistencia {
    UserJpaController userJPA = new UserJpaController();
    RolesJpaController rolJPA = new RolesJpaController();
    SessionsJpaController sessionJPA = new SessionsJpaController();
    Activity_logJpaController activJPA = new Activity_logJpaController();
    Document_typeJpaController documJPA = new Document_typeJpaController();
    HousingJpaController housingJPA = new HousingJpaController();
    HousingImageJpaController housingImageJPA = new HousingImageJpaController();
    HousingCategoryJpaController housingCategoryJPA = new HousingCategoryJpaController();
    ReviewHousingJpaController reviewHousingJPA = new ReviewHousingJpaController();
    ReservationJpaController reservationJPA = new ReservationJpaController();
    ReservationStatusJpaController reservationStatusJPA = new ReservationStatusJpaController();
    PaymentMethodJpaController paymentMethodJPA = new PaymentMethodJpaController();
    PaymentJpaController paymentJPA = new PaymentJpaController();
    HostJpaController hostJPA = new HostJpaController();
    AddressJpaController addressJPA = new AddressJpaController();
    ServicesJpaController servicesJPA = new ServicesJpaController(); // Add ServicesJPAController instance
    
MessageJpaController messageJPA = new MessageJpaController();

    // ---------------- USER ----------------
    public void crearUsuario(User user) {
        userJPA.create(user);
    }

    public List<User> getUsers() {
        return userJPA.findUserEntities();
    }

    public User getUser(int id) {
        return userJPA.findUser(id);
    }

    public void editarUsuario(User user) throws Exception {
        userJPA.edit(user);
    }

    public void eliminarUsuario(int id) throws Exception {
        userJPA.destroy(id);
    }

    public User buscarUsuarioPorEmail(String email) {
        for (User user : userJPA.findUserEntities()) {
            if (user.getEmail().equals(email)) {
                return user; // Retorna directamente si encuentra
            }
        }
        return null; // Mejor retornar null si no encuentra nada
    }
 
public void updateHousingServices(int housingId, List<Integer> selectedServiceIds) {
    
    
   servicesJPA.insertarServiciosParaHousing(housingId, selectedServiceIds);
}

    public List<Services> findServicesForHousing(int id){
        return servicesJPA.findServicesForHousing(id);
    }
    // ---------------- ROLES ----------------
    public void crearRol(Roles rol) {
        rolJPA.create(rol);
    }

    public List<Roles> getRoles() {
        return rolJPA.findRolesEntities();
    }

    public Roles getRol(int id) {
        return rolJPA.findRoles(id);
    }

    public void editarRol(Roles rol) throws Exception {
        rolJPA.edit(rol);
    }
    public void eliminarRol(int id) throws Exception {
        rolJPA.destroy(id);
    }

    // ---------------- SESSIONS ----------------
    public void crearSesion(Sessions sesion) {
        sessionJPA.create(sesion);
    }

    public List<Sessions> getSesiones() {
        return sessionJPA.findsessionsEntities();
    }

    public Sessions getSesion(int id) {
        return sessionJPA.findsessions(id);
    }

    public void editarSesion(Sessions sesion) throws Exception {
        sessionJPA.edit(sesion);
    }

    public void eliminarSesion(int id) throws Exception {
        sessionJPA.destroy(id);
    }

    // ---------------- ACTIVITY LOG ----------------
    public void crearActividad(Activity_log act) {
        activJPA.create(act);
    }

    public List<Activity_log> getActividades() {
        return activJPA.findActivity_logEntities();
    }

    public Activity_log getActividad(int id) {
        return activJPA.findActivity_log(id);
    }

    public void editarActividad(Activity_log act) throws Exception {
        activJPA.edit(act);
    }

    public void eliminarActividad(int id) throws Exception {
        activJPA.destroy(id);
    }

    // ---------------- DOCUMENT TYPE ----------------
    public void crearTipoDocumento(Document_type doc) {
        documJPA.create(doc);
    }

    public List<Document_type> getTiposDocumento() {
        return documJPA.findDocument_typeEntities();
    }

    public Document_type getTipoDocumento(int id) {
        return documJPA.findDocument_type(id);
    }

    public void editarTipoDocumento(Document_type doc) throws Exception {
        documJPA.edit(doc);
    }

    public void eliminarTipoDocumento(int id) throws Exception {
        documJPA.destroy(id);
    }

    // ---------------- RESERVATION ----------------
    public void crearReserva(Reservation reserva) {
        reservationJPA.create(reserva);
    }

    public List<Reservation> getReservas() {
        return reservationJPA.findReservationEntities();
    }

    public Reservation getReserva(int id) {
        return reservationJPA.findReservation(id);
    }

    public void editarReserva(Reservation reserva) throws Exception {
        reservationJPA.edit(reserva);
    }

    public void eliminarReserva(int id) throws Exception {
        reservationJPA.destroy(id);
    }

    // ---------------- RESERVATION STATUS ----------------
    public void crearReservationStatus(ReservationStatus status) {
        reservationStatusJPA.create(status);
    }

    public List<ReservationStatus> getReservationStatuses() {
        return reservationStatusJPA.findReservationStatusEntities();
    }

    public ReservationStatus getReservationStatus(int id) {
        return reservationStatusJPA.findReservationStatus(id);
    }

    public void editarReservationStatus(ReservationStatus status) throws Exception {
        reservationStatusJPA.edit(status);
    }

    public void eliminarReservationStatus(int id) throws Exception {
        reservationStatusJPA.destroy(id);
    }

    // ---------------- PAYMENT METHOD ----------------
    public void crearPaymentMethod(PaymentMethod paymentMethod) {
        paymentMethodJPA.create(paymentMethod);
    }

    public List<PaymentMethod> getPaymentMethods() {
        return paymentMethodJPA.findPaymentMethodEntities();
    }

    public PaymentMethod getPaymentMethod(int id) {
        return paymentMethodJPA.findPaymentMethod(id);
    }

    public void editarPaymentMethod(PaymentMethod paymentMethod) throws Exception {
        paymentMethodJPA.edit(paymentMethod);
    }

    public void eliminarPaymentMethod(int id) throws Exception {
        paymentMethodJPA.destroy(id);
    }

    // ---------------- PAYMENT ----------------
    public void crearPayment(Payment payment) {
        paymentJPA.create(payment);
    }

    public List<Payment> getPayments() {
        return paymentJPA.findPaymentEntities();
    }

    public Payment getPayment(int id) {
        return paymentJPA.findPayment(id);
    }

    public void editarPayment(Payment payment) throws Exception {
        paymentJPA.edit(payment);
    }

    public void eliminarPayment(int id) throws Exception {
        paymentJPA.destroy(id);
    }

    // ---------------- HOUSING ---------------- (Moved related methods together)
    public int crearyRetornarId(Housing housing) throws PreexistingEntityException {
        return housingJPA.createAndReturnId(housing); // Assuming createAndReturnId exists in HousingJpaController
    }

    public List<Housing> getHousings() {
        return housingJPA.findHousingEntities();
    }

    public Housing getHousing(int id) {
        return housingJPA.findHousing(id);
    }

    public void editarHousing(Housing housing) throws Exception {
        housingJPA.edit(housing);
    }

    public void eliminarHousing(int id) throws Exception {
        housingJPA.destroy(id);
    }
    
    public List<Housing> findHousingsByHostId(int id) {
        return housingJPA.findHousingsByHostId(id); // Assuming this method exists in HousingJpaController
    }

    // ---------------- HOUSING IMAGE ----------------
    public void crearHousingImage(HousingImage housingImage) throws PreexistingEntityException {
        housingImageJPA.create(housingImage);
    }

    public List<HousingImage> getHousingImages() {
        return housingImageJPA.findHousingImageEntities();
    }

    public HousingImage getHousingImage(int id) {
        return housingImageJPA.findHousingImage(id);
    }

    public void editarHousingImage(HousingImage housingImage) throws Exception {
        housingImageJPA.edit(housingImage);
    }

    public void eliminarHousingImage(int id) throws Exception {
        housingImageJPA.destroy(id);
    }

    // ---------------- HOUSING CATEGORY ----------------
    public void crearHousingCategory(HousingCategory housingCategory) throws PreexistingEntityException {
        housingCategoryJPA.create(housingCategory);
    }

    public List<HousingCategory> getHousingCategories() {
        return housingCategoryJPA.findHousingCategoryEntities();
    }

    public HousingCategory getHousingCategory(int id) {
        return housingCategoryJPA.findHousingCategory(id);
    }

    public void editarHousingCategory(HousingCategory housingCategory) throws Exception {
        housingCategoryJPA.edit(housingCategory);
    }

    public void eliminarHousingCategory(int id) throws Exception {
        housingCategoryJPA.destroy(id);
    }
    
    public HousingCategory getHousingCategoryByName(String category) {
        return housingCategoryJPA.getHousingCategoryByName(category); // Assuming this method exists
    }

    // ---------------- REVIEW HOUSING ----------------
    public void crearReviewHousing(ReviewHousing reviewHousing) {
        reviewHousingJPA.create(reviewHousing);
    }

    public List<ReviewHousing> getReviewHousings() {
        return reviewHousingJPA.findReviewHousingEntities();
    }

    public ReviewHousing getReviewHousing(int id) {
        return reviewHousingJPA.findReviewHousing(id);
    }

    public void editarReviewHousing(ReviewHousing reviewHousing) throws Exception {
        reviewHousingJPA.edit(reviewHousing);
    }

    public void eliminarReviewHousing(int id) throws Exception {
        reviewHousingJPA.destroy(id);
    }

    // ---------------- HOST ----------------
    public void crearHost(Host host) { // Consider if PreexistingEntityException is needed
        hostJPA.create(host);
    }

    public List<Host> getHosts() {
        return hostJPA.findHostEntities();
    }

    public Host getHost(int id) {
        return hostJPA.findHost(id);
    }

    public void editarHost(Host host) throws Exception {
        hostJPA.edit(host);
    }

    public void eliminarHost(int id) throws Exception {
        hostJPA.destroy(id);
    }
    
    // ---------------- ADDRESS ----------------
    public List<Address> getAddress() {
        return addressJPA.findAddressEntities();
    }

    public Address getAddre(int id) {
        return addressJPA.findAddress(id);
    }
    
    // ---------------- USER COUNT ----------------
    public int getCountUsers() {
        return userJPA.getUserCount();
    }

    // ---------------- SERVICES ---------------- (New methods for Services)
    public void crearServicioPers(Services service) {
        servicesJPA.create(service);
    }

    public List<Services> getListaServiciosPers() {
        return servicesJPA.findServicesEntities();
    }

    public Services getServicioPers(int id) {
        return servicesJPA.findServices(id);
    }

    public void editarServicioPers(Services service) throws NonexistentEntityException, Exception {
        servicesJPA.edit(service);
    }

    public void eliminarServicioPers(int id) throws NonexistentEntityException, Exception {
        servicesJPA.destroy(id);
    }
    

// -------- MENSAJES --------
    public void crearMensaje(Message message) {
        messageJPA.create(message);
    }

    public void eliminarMensaje(int id) throws NonexistentEntityException{
        messageJPA.destroy(id);
    }
    
    public List<Message> getConversacion(User user1, User user2) {
        return messageJPA.findMessagesBetween(user1, user2);
    }

    public void marcarComoLeido(User user1, User user2) {
        messageJPA.markMessagesAsRead(user1, user2);
    }
    
    public Message getMensajes(int id) {
        return messageJPA.findMessage(id);
    }
    
    public List<User> obtenerChatUser(User user){
        return messageJPA.findUsersWhoMessaged(user);
    }
    
    public void eliminarConversacion(User user1, User user2){
        messageJPA.deleteConversation(user1, user2);
    }
    
    public List<Message> mensajeNoLeidos(User user){
        return messageJPA.getUnreadMessages(user);
    }
    
    public void eliminarConversacionEntera(User user1, User user2){
        messageJPA.deleteConversationAll(user1, user2);
    }
    
    public User encontrarUser(int id){
        return messageJPA.getUserById(id);
    }

}

<%-- 
    Document   : indexAdminReservations
    Created on : 26 may 2025, 19:07:10
    Author     : Alex
--%>

<%@page import="java.util.List"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Modernize Free</title>
  <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
   <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    </head>
  <body>
      <%
            HttpSession misession = request.getSession();
            User sessionUser =  (User)session.getAttribute("user");
            if(sessionUser==null){
            response.sendRedirect("login.jsp");
            }
        %>
 <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed">
        <aside class="left-sidebar">
            <div>
               <div class="brand-logo d-flex align-items-center justify-content-center">
          <a href="SvAdminIngresosxMes" class="text-nowrap logo-img">
            <img src="images/logo.png" width="120" alt="" />
          </a>
          <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
            <i class="ti ti-x fs-8"></i>
          </div>
        </div>
                <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
                    <ul id="sidebarnav">
                        <li class="nav-small-cap">
                            <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                            <span class="hide-menu">Home</span>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminIngresosxMes" aria-expanded="false">
                                <span>
                                    <i class="ti ti-layout-dashboard"></i>
                                </span>
                                <span class="hide-menu">Dashboard</span>
                            </a>
                        </li>
                        <li class="nav-small-cap">
                            <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                            <span class="hide-menu">UI COMPONENTS</span>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminHousings" aria-expanded="false">
                                <span>
                                    <i class="ti ti-article"></i>
                                </span>
                                <span class="hide-menu">Alojamientos</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminReservations" aria-expanded="false">
                                <span>
                                    <i class="ti ti-alert-circle"></i>
                                </span>
                                <span class="hide-menu">Reservaciones</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="./SvAdminUsers" aria-expanded="false">
                                <span>
                                    <i class="ti ti-alert-circle"></i>
                                </span>
                                <span class="hide-menu">Usuarios</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="./SvAdminHosts" aria-expanded="false">
                                <span>
                                    <i class="ti ti-cards"></i>
                                </span>
                                <span class="hide-menu">Host</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminServices" aria-expanded="false">
                                <span>
                                    <i class="ti ti-file-description"></i>
                                </span>
                                <span class="hide-menu">Services</span>
                            </a>
                        </li>
                       <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminPagos" aria-expanded="false">
                                <span>
                                    <i class="ti ti-file-description"></i>
                                </span>
                                <span class="hide-menu">Pagos</span>
                            </a>
                        </li>
                          <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminCategoryHousing" aria-expanded="false">
                                <span>
                                    <i class="ti ti-file-description"></i>
                                </span>
                                <span class="hide-menu">Categoría Alojamiento</span>
                            </a>
                        </li>
                          <li class="sidebar-item">
                            <a class="sidebar-link" href="SvCoupon" aria-expanded="false">
                                <span>
                                    <i class="ti ti-file-description"></i>
                                </span>
                                <span class="hide-menu">Gestionar Cupones</span>
                            </a>
                        </li>
                         <li class="nav-small-cap">
                            <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                            <span class="hide-menu">Reportes Estadíticos</span>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="dashboardReserva.jsp" aria-expanded="false">
                                <span>
                                    <i class="ti ti-article"></i>
                                </span>
                                <span class="hide-menu">Reservas por Mes</span>
                            </a>
                        </li>
                           <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminIngresosxMes" aria-expanded="false">
                                <span>
                                    <i class="ti ti-article"></i>
                                </span>
                                <span class="hide-menu">Ingresos por Mes</span>
                            </a>
                        </li>
                        
                           <li class="sidebar-item">
                            <a class="sidebar-link" href="SvAdminIngresos" aria-expanded="false">
                                <span>
                                    <i class="ti ti-article"></i>
                                </span>
                                <span class="hide-menu">Ingresos por Anfitriones</span>
                            </a>
                        </li>
                                                  <li class="sidebar-item">
                            <a class="sidebar-link" href="SvReporteGananciasPorHost" aria-expanded="false">
                                <span>
                                    <i class="ti ti-file-description"></i>
                                </span>
                                <span class="hide-menu">Ganancias anfitriones</span>
                            </a>
                        </li>

                        <li class="nav-small-cap">
                            <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                            <span class="hide-menu">AUTH</span>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="SvCerrarSesion" aria-expanded="false">
                                <span>
                                    <i class="ti ti-login"></i>
                                </span>
                                <span class="hide-menu">Login</span>
                            </a>
                        </li>
                        
                    </ul>
                    <div class="unlimited-access hide-menu bg-light-primary position-relative mb-7 mt-5 rounded">
                        <div class="d-flex">
                            
                            <div class="unlimited-access-img">
                                <img src="../assets/images/backgrounds/rocket.png" alt="" class="img-fluid">
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </aside>
        <div class="body-wrapper">
            <header class="app-header">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <ul class="navbar-nav">
                        <li class="nav-item d-block"> <%-- Removed d-xl-none to always show the toggle button --%>
                            <a class="nav-link sidebartoggler nav-icon-hover" id="sidebarToggleBtn" href="javascript:void(0)">
                                <i class="ti ti-menu-2"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-icon-hover" href="javascript:void(0)">
                                <i class="ti ti-bell-ringing"></i>
                                <div class="notification bg-primary rounded-circle"></div>
                            </a>
                        </li>
                    </ul>
                    <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
                        <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
                            <li class="nav-item dropdown">
                                <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    <%=sessionUser.getEmail().substring(0, 1).toUpperCase() %>  

                                </a>
                                <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                                    <div class="message-body">
                                        <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                            <i class="ti ti-user fs-6"></i>
                                            <p class="mb-0 fs-3">My Profile</p>
                                        </a>
                                        <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                            <i class="ti ti-mail fs-6"></i>
                                            <p class="mb-0 fs-3">My Account</p>
                                        </a>
                                        <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                            <i class="ti ti-list-check fs-6"></i>
                                            <p class="mb-0 fs-3">My Task</p>
                                        </a>
                                        <a href="./authentication-login.html" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            <div class="container-fluid mt-4">
               
<table id="table_id" class="display">
    <thead>
      <tr>
        <th>ID</th>
        <th>Cliente</th>
        <th>Correo Cliente</th>
        <th>Alojamiento</th>
        <th>Fecha Inicio</th>
        <th>Fecha Fin</th>
        <th>Precio Total</th>
        <th>Estado</th>
        <th>Fecha de Creación</th>
        <th>Última Actualización</th>
           <th>Eliminar</th>
              <th>Editar</th>
      </tr>
    </thead>
    <tbody>
    <%
      List<Models.Reservation> reservations = (List<Models.Reservation>) request.getAttribute("listReservations");
      if (reservations != null) {
        for (Models.Reservation r : reservations) {
    %>
    <tr>
      <td><%= r.getReservationId() %></td>
      <td><%= r.getUserId() != null ? r.getUserId().getFull_name() + " " + r.getUserId().getLast_name() : "N/A" %></td>
      <td><%= r.getUserId() != null ? r.getUserId().getEmail() : "N/A" %></td>
      <td><%= r.getHousingId() != null ? r.getHousingId().getCommercialName() : "N/A" %></td>
      <td><%= r.getStartDate() %></td>
      <td><%= r.getEndDate() %></td>
      <td><%= r.getTotalPrice() %></td>
      <td><%= r.getReservationStatusId() != null ? r.getReservationStatusId().getStatusName() : "N/A" %></td>
      <td><%= r.getCreatedDate() %></td>
      <td><%= r.getUpdatedDate() %></td>

      <!-- Botón Editar -->
      <td>
        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editarModal<%= r.getReservationId() %>">
          Editar
        </button>

        <!-- Modal Editar -->
        <div class="modal fade" id="editarModal<%= r.getReservationId() %>" tabindex="-1" aria-labelledby="editarModalLabel<%= r.getReservationId() %>" aria-hidden="true">
          <div class="modal-dialog">
            <form action="SvAdminEditarReservation" method="post" class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="editarModalLabel<%= r.getReservationId() %>">Editar Reservación</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">

                <div class="mb-3">
                  <label for="startDate<%= r.getReservationId() %>" class="form-label">Fecha Inicio</label>
                  <input type="date" class="form-control" id="startDate<%= r.getReservationId() %>" name="startDate" value="<%= r.getStartDate() %>" required>
                </div>

                <div class="mb-3">
                  <label for="endDate<%= r.getReservationId() %>" class="form-label">Fecha Fin</label>
                  <input type="date" class="form-control" id="endDate<%= r.getReservationId() %>" name="endDate" value="<%= r.getEndDate() %>" required>
                </div>

                <div class="mb-3">
                  <label for="totalPrice<%= r.getReservationId() %>" class="form-label">Precio Total</label>
                  <input type="number" step="0.01" class="form-control" id="totalPrice<%= r.getReservationId() %>" name="totalPrice" value="<%= r.getTotalPrice() %>" required>
                </div>

                <div class="mb-3">
                  <label for="statusId<%= r.getReservationId() %>" class="form-label">Estado</label>
                  <select class="form-select" id="statusId<%= r.getReservationId() %>" name="statusId" required>
                    <%-- Aquí deberías listar los estados disponibles --%>
                    <%-- Por ejemplo, si tienes lista de estados en request o los defines aquí --%>
                    <option value="1" <%= r.getReservationStatusId() != null && r.getReservationStatusId().getReservationStatusId()== 1 ? "selected" : "" %>>Pendiente</option>
                    <option value="2" <%= r.getReservationStatusId() != null && r.getReservationStatusId().getReservationStatusId() == 2 ? "selected" : "" %>>Confirmada</option>
                    <option value="3" <%= r.getReservationStatusId() != null && r.getReservationStatusId().getReservationStatusId() == 3 ? "selected" : "" %>>Cancelada</option>
                  </select>
                </div>

              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
              </div>
            </form>
          </div>
        </div>
      </td>

      <!-- Botón Eliminar -->
      <td>
        <form action="SvAdminEliminarReservation" method="post" onsubmit="return confirm('¿Estás seguro de eliminar esta reservación?');">
          <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
          <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
        </form>
      </td>
    </tr>
    <%
        }
      } else {
    %>
    <tr><td colspan="12">No hay reservaciones disponibles</td></tr>
    <%
      }
    %>
  </tbody>

  </table>
            </div>
            
        </div>
    </div>


    

  
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script>
  $(document).ready(function () {
    $('#table_id').DataTable();
  });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>"></script>
 <script src="js/indexAdminapp.min.js"></script>
  <script src="js/indexAdmindashboard.js"></script>
</body>
</html>

<%-- 
    Document   : indexAdminHousting
    Created on : 12 may 2025, 21:10:27
    Author     : Alex
--%>

<%@page import="java.util.List"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
  <!--  Body Wrapper -->
  
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
               
  <div>
      <table id="table_id" class="display">
    <thead>
        <tr>
            <th>ID</th>
            <th>Host</th>
            <th>Nombre Comercial</th>
            <th>Dirección</th>
            <th>Ciudad</th>
            <th>País</th>
            <th>Habitaciones</th>
            <th>Estrellas</th>
            <th>Precio/Noche</th>
            <th>Categoría</th>
            <th>Estado</th>
            <th>Fecha de Creación</th>
            <th>Última Actualización</th>
            <th>Eliminar</th>
            <th>Editar</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<Models.Housing> housings = (List<Models.Housing>) request.getAttribute("listhousings");
            if (housings != null) {
                for (Models.Housing h : housings) {
        %>
        <tr>
            <td><%= h.getHousingId() %></td>
            <td><%= h.getHostId() != null ? h.getHostId().getId_user().getFull_name() +  h.getHostId().getId_user().getLast_name(): "N/A" %></td>
            <td><%= h.getCommercialName() %></td>
            <td><%= h.getAddress() %></td>
            <td><%= h.getCity() %></td>
            <td><%= h.getCountry() %></td>
            <td><%= h.getNumHabitaciones() %></td>
            <td><%= h.getStars() %></td>
            <td><%= h.getPriceNight() %></td>
            <td><%= h.getId_housingcategory() != null ? h.getId_housingcategory().getCategoryName() : "N/A" %></td>
          
            <td><%= h.getStatus() %></td>
            <td><%= h.getCreatedDate() %></td>
            <td><%= h.getUpdatedDate() %></td>
           <td>
                <!-- Botón Eliminar -->
              <form action="SvAdminEliminarHousing" method="post" style="display:inline;">
                  <input type="hidden" name="id" value="<%= h.getHousingId() %>">
                  <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro que quieres eliminar este alojamiento?')">
                      Eliminar
                  </button>
              </form>

          </td>
          <td>
           <!-- Botón para abrir modal de edición -->
                <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditar<%= h.getHousingId() %>">
                  Editar
                </button>

          </td>

        </tr>
        <!-- Modal para editar alojamiento -->
<div class="modal fade" id="modalEditar<%= h.getHousingId() %>" tabindex="-1" aria-labelledby="modalLabel<%= h.getHousingId() %>" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="SvAdminEditarHousing" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="modalLabel<%= h.getHousingId() %>">Editar Alojamiento</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="housingId" value="<%= h.getHousingId() %>">

          <div class="row mb-3">
            <div class="col">
              <label>Nombre Comercial</label>
              <input type="text" name="commercialName" class="form-control" value="<%= h.getCommercialName() %>">
            </div>
            <div class="col">
              <label>Dirección</label>
              <input type="text" name="address" class="form-control" value="<%= h.getAddress() %>">
            </div>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label>Ciudad</label>
              <input type="text" name="city" class="form-control" value="<%= h.getCity() %>">
            </div>
            <div class="col">
              <label>País</label>
              <input type="text" name="country" class="form-control" value="<%= h.getCountry() %>">
            </div>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label>Habitaciones</label>
              <input type="number" name="numHabitaciones" class="form-control" value="<%= h.getNumHabitaciones() %>">
            </div>
            <div class="col">
              <label>Estrellas</label>
              <input type="number" name="stars" class="form-control" value="<%= h.getStars() %>">
            </div>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label>Precio por Noche</label>
              <input type="number" step="0.01" name="priceNight" class="form-control" value="<%= h.getPriceNight() %>">
            </div>
            <div class="col">
              <label>Estado</label>
              <input type="text" name="status" class="form-control" value="<%= h.getStatus() %>">
            </div>
          </div>

          <!-- Puedes agregar más campos si es necesario -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-success">Guardar Cambios</button>
        </div>
      </form>
    </div>
  </div>
</div>

        <%
                }
            } else {
        %>
        <tr><td colspan="20">No hay alojamientos disponibles</td></tr>
        <%
            }
        %>
    </tbody>
</table>       
  </div>
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




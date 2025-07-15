<%--
    Document    : indexAdminHousting
    Created on : 12 may 2025, 21:10:27
    Author      : Alex
--%>

<%@page import="Models.Coupon"%>
<%@page import="java.util.List"%>
<%@page import="Models.User"%>
<%@page import="Models.Host"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Modernize Free</title>
    <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
    <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.0/css/dataTables.dataTables.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.0/css/dataTables.dataTables.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        input[readonly] {
            background-color: #e9ecef; /* un gris claro */
            cursor: not-allowed;
            color: #6c757d;
        }
    </style>
    <style>
    #table_id th:first-child { width: 9px !important; } /* ID */
    #table_id th:last-child { width: 16px !important; } /* Acciones */
</style>

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
          <a href="indexAdmin.jsp" class="text-nowrap logo-img">
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
                <button class="btn btn-success mb-3" onclick="openCrearModal()">Crear Cupón</button>

                <table id="table_id" class="display table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Código</th>
                            <th>Descripción</th>
                            <th>Tipo de Descuento</th>
                            <th>Valor</th>
                            <th>Mín. Noches</th>
                            <th>Desde</th>
                            <th>Hasta</th>
                            <th>Límite por cupón</th>
                            <th>Límite por usuario</th>
                            <th>Activo</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Coupon> listCoupons = (List<Coupon>) request.getAttribute("listCoupons");
                        if (listCoupons != null) {
                            for (Coupon c : listCoupons) {
                    %>
                        <tr>
                            <td><%= c.getId() %></td>
                            <td><%= c.getCode() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= c.getDiscountType()%></td>
                            <td><%= c.getDiscountValue()%></td>
                            <td><%= c.getMinStayNights()%></td>
                            <td><%= c.getValidFrom()%></td>
                            <td><%= c.getValidUntil()%></td>
                            <td><%= c.getUsageLimitPerCoupon()%></td>
                            <td><%= c.getUsageLimitPerUser()%></td>
                            <td><%= c.isActive() ? "Sí" : "No" %></td>
                            <td>
                                <!-- Botón editar -->
                                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editarModal<%= c.getId() %>">Editar</button>

                                <!-- Modal editar -->
                                <div class="modal fade" id="editarModal<%= c.getId() %>" tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                        <form action="SvEditarCoupon" method="post" class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Editar Cupón</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body row g-3">
                                                <input type="hidden" name="id" value="<%= c.getId() %>">
                                                <div class="col-md-6">
                                                    <label class="form-label">Código</label>
                                                    <input type="text" class="form-control" name="code" value="<%= c.getCode() %>" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Descripción</label>
                                                    <input type="text" class="form-control" name="description" value="<%= c.getDescription() %>">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Tipo de Descuento</label>
                                                    <select class="form-select" name="discount_type">
                                                        <option value="Porcentaje" <%= "Porcentaje".equals(c.getDiscountType()) ? "selected" : "" %>>Porcentaje</option>
                                                        <option value="Fijo" <%= "Fijo".equals(c.getDiscountType()) ? "selected" : "" %>>Fijo</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Valor</label>
                                                    <input type="number" class="form-control" name="discount_value" value="<%= c.getDiscountValue() %>" step="0.01" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Mínimo de Noches</label>
                                                    <input type="number" class="form-control" name="min_stay_nights" value="<%= c.getMinStayNights()%>">
                                                </div>
                                                
                                                <div class="col-md-6">
                                                    <label class="form-label">Fecha Inicio</label>
                                                    <input type="date" class="form-control" name="valid_from" value="<%= c.getValidFrom()%>">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Fecha Fin</label>
                                                    <input type="date" class="form-control" name="valid_until" value="<%= c.getValidUntil()%>">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Límite por Cupón</label>
                                                    <input type="number" class="form-control" name="usage_limit_per_coupon" value="<%= c.getUsageLimitPerCoupon()%>">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Límite por Usuario</label>
                                                    <input type="number" class="form-control" name="usage_limit_per_user" value="<%= c.getUsageLimitPerUser()%>">
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label">Activo</label>
                                                    <select class="form-select" name="active">
                                                        <option value="true" <%= c.isActive() ? "selected" : "" %>>Sí</option>
                                                        <option value="false" <%= !c.isActive() ? "selected" : "" %>>No</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary">Guardar</button>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Botón eliminar -->
                                <form action="SvEliminarCoupon" method="post" class="d-inline" onsubmit="return confirm('¿Eliminar este cupón?');">
                                    <input type="hidden" name="id_coupon" value="<%= c.getId() %>">
                                    <button class="btn btn-sm btn-danger" type="submit">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>       
        </div>
    </div>
            

<!-- Modal crear cupón -->
<div class="modal fade" id="createModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <form action="SvCrearCoupon" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Crear Cupón</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body row g-3">
                <div class="col-md-6">
                    <label class="form-label">Código</label>
                    <input type="text" class="form-control" name="code" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Descripción</label>
                    <input type="text" class="form-control" name="description" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Tipo de Descuento</label>
                    <select class="form-select" name="discount_type">
                        <option value="percentage">Porcentaje</option>
                        <option value="fixed">Fijo</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Valor</label>
                    <input type="number" class="form-control" name="discount_value" step="0.01" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Mínimo de Noches</label>
                    <input type="number" class="form-control" name="min_stay_nights" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Fecha Inicio</label>
                    <input type="date" class="form-control" name="valid_from" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Fecha Fin</label>
                    <input type="date" class="form-control" name="valid_until" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Límite por Cupón</label>
                    <input type="number" class="form-control" name="usage_limit_per_coupon" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Límite por Usuario</label>
                    <input type="number" class="form-control" name="usage_limit_per_user" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Activo</label>
                    <select class="form-select" name="active">
                        <option value="true">Sí</option>
                        <option value="false">No</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success" type="submit">Crear</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $('#table_id').DataTable();
    });

    function openCrearModal() {
        new bootstrap.Modal(document.getElementById('createModal')).show();
    }
</script>                  
  
</body>
</html>
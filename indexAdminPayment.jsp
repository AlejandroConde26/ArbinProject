<%@page import="java.util.List"%>
<%@page import="Models.User"%>
<%@page import="Models.Payment"%>
<%@page import="Models.PaymentMethod"%>
<%@page import="Models.Reservation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Administración de Pagos</title>
    <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
    <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.0/css/dataTables.dataTables.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="css/indexPagos.css?v=<%= System.currentTimeMillis() %>"/>

</head>

<body>
    <%
        HttpSession misession = request.getSession();
        User sessionUser = (User)session.getAttribute("user");
        if(sessionUser == null){
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
                <table id="table_id" class="display table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>ID Pago</th>
                                        <th>Monto</th>
                                        <th>Fecha Creación</th>
                                        <th>Fecha Fin</th>
                                        <th>Fecha Pago</th>
                                        <th>Estado Pago</th>
                                        <th>Última Actualización</th>
                                        <th>Método de Pago</th>
                                        <th>ID Reservación</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Models.Payment> payments = (List<Models.Payment>) request.getAttribute("listapagos");
                                        if (payments != null && !payments.isEmpty()) {
                                            for (Models.Payment p : payments) {
                                    %>
                                    <tr>
                                        <td><%= p.getPaymentId() %></td>
                                        <td><%= String.format("%.2f", p.getAmount()) %></td>
                                        <td><%= p.getCreatedDate() != null ? p.getCreatedDate() : "-" %></td>
                                        <td><%= p.getEndDate() != null ? p.getEndDate() : "-" %></td>
                                        <td><%= p.getPaymentDate() != null ? p.getPaymentDate() : "-" %></td>
                                        <td><%= p.getPaymentStatus() != null ? p.getPaymentStatus() : "N/A" %></td>
                                        <td><%= p.getUpdatedDate() != null ? p.getUpdatedDate() : "-" %></td>
                                        <td><%= p.getPaymentMethod()!= null ? p.getPaymentMethod().getMethodName(): "Sin método" %></td>
                                        <td><%= p.getReservation()!= null ? p.getReservation().getReservationId(): "Sin reservación" %></td>
                                        <td>
                                            <button type="button" class="btn btn-link"
                                                     onclick="openEditModal(
                                                         '<%= p.getPaymentId() %>',
                                                         '<%= p.getAmount() %>',
                                                         '<%= p.getCreatedDate() %>',
                                                         '<%= p.getEndDate() %>',
                                                         '<%= p.getPaymentDate() %>',
                                                         '<%= p.getPaymentStatus() %>',
                                                         '<%= p.getUpdatedDate() %>',
                                                         '<%= p.getPaymentMethod() != null ? p.getPaymentMethod().getPaymentMethodId() : "" %>',
                                                         '<%= p.getReservation() != null ? p.getReservation().getReservationId() : "" %>'
                                                     )">
                                                <i class="fa fa-edit" style="color:blue;"></i>
                                            </button>

                                            <form action="SvPaymentEliminar" method="post" style="display:inline;"
                                                onsubmit="return confirm('¿Estás seguro de eliminar este pago?');">
                                                <input type="hidden" name="idPago" value="<%= p.getPaymentId() %>"/>
                                                <button type="submit" title="Eliminar"
                                                        style="border:none; background:none; cursor:pointer;">
                                                    <i class="fa fa-trash" style="color:red;"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                                }
                                            } else {
                                    %>
                                    <tr><td colspan="10">No hay pagos disponibles</td></tr>
                                    <%
                                            }
                                    %>
                                </tbody>
                            </table>
            </div>
           
        </div>
    </div>
             

   
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
    <script>
        $(document).ready(function () {
            $('#table_id').DataTable();
        });
    </script>
    <script>
        function openEditModal(
            paymentId, amount, createdDate, endDate, paymentDate, paymentStatus, updatedDate, paymentMethodId, reservationId
        ) {
            document.getElementById('paymentId').value = paymentId;
            document.getElementById('amount').value = amount;
            document.getElementById('createdDate').value = createdDate;
            document.getElementById('endDate').value = endDate;
            document.getElementById('paymentDate').value = paymentDate;
            document.getElementById('paymentStatus').value = paymentStatus;
            document.getElementById('updatedDate').value = updatedDate;
            
            // Seleccionar la opción correcta en el select de Método de Pago
            const paymentMethodSelect = document.getElementById('paymentMethodId');
            for (let i = 0; i < paymentMethodSelect.options.length; i++) {
                if (paymentMethodSelect.options[i].value === paymentMethodId) {
                    paymentMethodSelect.selectedIndex = i;
                    break;
                }
            }
            // Seleccionar la opción correcta en el select de ID Reservación
            const reservationSelect = document.getElementById('reservationId');
            for (let i = 0; i < reservationSelect.options.length; i++) {
                if (reservationSelect.options[i].value === reservationId) {
                    reservationSelect.selectedIndex = i;
                    break;
                }
            }

            var editModal = new bootstrap.Modal(document.getElementById('editModal'));
            editModal.show();
        }

    </script>
   <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>"></script>
    <script src="js/indexAdminapp.min.js"></script>
    <script src="js/indexAdmindashboard.js"></script>

    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <form id="editForm" method="post" action="SvPaymentEditar">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Editar Pago</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="paymentId" class="form-label">ID Pago</label>
                            <input type="text" class="form-control" id="paymentId" name="paymentId" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="amount" class="form-label">Monto</label>
                            <input type="number" step="0.01" class="form-control" id="amount" name="amount" required>
                        </div>

                        <div class="mb-3">
                            <label for="createdDate" class="form-label">Fecha de Creación</label>
                            <input type="date" class="form-control" id="createdDate" name="createdDate" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="endDate" class="form-label">Fecha Fin</label>
                            <input type="date" class="form-control" id="endDate" name="endDate">
                        </div>

                        <div class="mb-3">
                            <label for="paymentDate" class="form-label">Fecha de Pago</label>
                            <input type="date" class="form-control" id="paymentDate" name="paymentDate">
                        </div>

                        <div class="mb-3">
                            <label for="paymentStatus" class="form-label">Estado de Pago</label>
                            <input type="text" class="form-control" id="paymentStatus" name="paymentStatus">
                        </div>

                        <div class="mb-3">
                            <label for="updatedDate" class="form-label">Última Actualización</label>
                            <input type="date" class="form-control" id="updatedDate" name="updatedDate" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="paymentMethodId" class="form-label">Método de Pago</label>
                            <select class="form-select" id="paymentMethodId" name="paymentMethodId" required>
                                <%
                                    List<Models.PaymentMethod> paymentMethods = (List<Models.PaymentMethod>) request.getAttribute("listapagosmetodos");
                                    if (paymentMethods != null) {
                                        for (Models.PaymentMethod method : paymentMethods) {
                                %>
                                    <option value="<%= method.getPaymentMethodId() %>"><%= method.getMethodName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="reservationId" class="form-label">ID Reservación</label>
                             <select class="form-select" id="reservationId" name="reservationId" readonly>
                                <%
                                    List<Models.Reservation> reservations = (List<Models.Reservation>) request.getAttribute("listareservaciones");
                                    if (reservations != null) {
                                        for (Models.Reservation res : reservations) {
                                %>
                                    <option value="<%= res.getReservationId() %>"readonly><%= res.getReservationId() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</body>

</html>
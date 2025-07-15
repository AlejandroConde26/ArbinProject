<%--
    Document    : indexAdminHousting
    Created on : 12 may 2025, 21:10:27
    Author      : Alex
--%>

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
                <div class="d-flex justify-content-end mb-2">
                    <button type="button" 
                            class="btn btn-success" 
                            onclick="openCrearModal()">
                        <i class="fa fa-plus"></i> Crear Categoria
                    </button>
                </div>
                <table id="table_id" class="display">
                    
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Fecha Registro</th>
                            <th>Ultima Actualizacion</th>
                            <th>Contacto del Dueño</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Models.Host> hosts = (List<Models.Host>) request.getAttribute("listahosts");
                            if (hosts != null) {
                                for (Host h : hosts) {
                        %>
                                <tr>
                                    <td><%= h.getId_Host()%></td>
                                    <td><%= h.getCreatedDate()%></td>
                                    <td><%= h.getUpdatedDate()%></td>
                                    <td><%= h.getId_user() != null ? h.getId_user().getEmail():"N/A" %></td>
                                    <td>
                                        <button type="button" 
                                            class="btn btn-link" 
                                            onclick="openEditModal(
                                                '<%= h.getId_Host()%>', 
                                                '<%= h.getCreatedDate() %>',
                                                '<%= h.getUpdatedDate() %>',
                                                '<%= h.getId_user().getId_users() %>'
                                            )">
                                            <i class="fa fa-edit" style="color:blue;"></i>
                                        </button>
                                        <form action="SvHostEliminar" method="post" style="display:inline;" onsubmit="return confirm('¿Estás seguro de eliminar este Host?');">
                                            <input type="hidden" name="id" value="<%= h.getId_Host()%>"/>
                                            <button type="submit" title="Eliminar" style="border:none; background:none; cursor:pointer;">
                                                <i class="fa fa-trash" style="color:red;"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                        <%
                                }
                            } else {
                                %>
                                <tr><td colspan="18">No hay hosts disponibles</td></tr>
                                <%
                            }
                                %>
                    </tbody>
                </table>
            </div>
            
        </div>
    </div>
            
                    
    <script>
        function openCrearModal() {
        // Mostrar el modal
        var createModal = new bootstrap.Modal(document.getElementById('createModal'));
        
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('newCreatedDate').value = today;
        document.getElementById('newUpdatedDate').value = today;
        
        
        createModal.show();
      }
        
      function openEditModal(id, createdDate, updatedDate, id_user_to_select) {
        document.getElementById('id_Host').value = id;
        document.getElementById('createdDate').value = createdDate;
        document.getElementById('updatedDate').value = updatedDate;

        // Set the selected option in the dropdown for id_user
        const userSelect = document.getElementById('id_user');
        for (let i = 0; i < userSelect.options.length; i++) {
            // Compare as strings to ensure correct matching
            if (userSelect.options[i].value === String(id_user_to_select)) {
                userSelect.selectedIndex = i;
                break;
            }
        }

        // Mostrar el modal
        var editModal = new bootstrap.Modal(document.getElementById('editModal'));
        editModal.show();
      }
    </script>

    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#table_id').DataTable();
        });
    </script>


    <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>" ></script>
    <script src="js/indexAdminapp.min.js"></script>
    <script src="js/indexAdmindashboard.js"></script>

    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form id="editForm" method="post" action="SvHostEditar">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Editar Host</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        
                        <div class="mb-3">
                            <label for="id_Host" class="form-label">ID del Host</label>
                            <input type="text" class="form-control" id="id_Host" name="id_Host" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="id_user" class="form-label">Correo del Usuario</label>
                            <select class="form-select" id="id_user" name="id_user" required>
                                <%
                                    List<Models.User> listaUsuarios = (List<Models.User>) request.getAttribute("listausuarios");
                                    if (listaUsuarios != null) {
                                        for (Models.User usuario : listaUsuarios) {
                                %>
                                        <option value="<%= usuario.getId_users()%>"><%= usuario.getEmail() %></option>
                                <%  
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="createdDate" class="form-label">Fecha de Creación</label>
                            <input type="text" class="form-control" id="createdDate" name="createdDate" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="updatedDate" class="form-label">Última Actualización</label>
                            <input type="text" class="form-control" id="updatedDate" name="updatedDate" readonly>
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

    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createModalLabel">Crear Nuevo Host</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <form id="createForm" method="post" action="SvHostCrear">
                            <div class="mb-3">
                            <label for="id_user2" class="form-label">Correo del Usuario</label>
                            <select class="form-select" id="id_user2" name="id_user2" required>
                                <%
                                    listaUsuarios = (List<Models.User>) request.getAttribute("listausuarios");
                                    if (listaUsuarios != null) {
                                        for (Models.User usuario : listaUsuarios) {
                                %>
                                        <option value="<%= usuario.getId_users()%>"><%= usuario.getEmail() %></option>
                                <%  
                                        }
                                    }
                                %>
                            </select>
                        </div>
                            
                        <div class="mb-3">
                            <label for="newCreatedDate" class="form-label">Fecha de creación</label>
                            <input type="date" class="form-control" id="newCreatedDate" name="createdDate" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="newUpdatedDate" class="form-label">Fecha de actualización</label>
                            <input type="date" class="form-control" id="newUpdatedDate" name="updatedDate" readonly>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary" >Guardar</button>
                        </div>
                    </form>
                </div>
                
            </div>
        </div>
    </div>
</body>
</html>
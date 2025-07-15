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
     <link rel="stylesheet" href="https://cdn.datatables.net/2.3.0/css/dataTables.dataTables.css" />
 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- si usas jQuery -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
                            <a class="sidebar-link" href="SvAdminCategoryHousing" aria-expanded="false">
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
                        <li class="nav-item d-block"> 
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
            <div class="container-fluid">
               
                <div class="d-flex justify-content-end mb-2">
                  <button type="button" 
                          class="btn btn-success" 
                          onclick="openCrearModal()">
                    <i class="fa fa-plus"></i> Crear Usuario
                  </button>
                </div>
      <table id="table_id" class="display">
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Contacto</th>
            <th>Contacto Emergencia</th>
            <th>Num Doc</th>
            <th>Tipo Doc</th>
            <th>Dirección</th>
            <th>Rol</th>
            <th>Estado</th>
            <th>Fecha Registro</th>
            <th>Última Actualización</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Models.User> users = (List<Models.User>) request.getAttribute("listausuarios");
            if (users != null && !users.isEmpty()) {
              for (User u : users) {
          %>
          <tr>
            <td><%= u.getId_users() %></td>
            <td><%= u.getFull_name() != null ? u.getFull_name() : "No registrado" %></td>
            <td><%= u.getLast_name() != null ? u.getLast_name() : "No registrado" %></td>
            <td><%= u.getEmail() != null ? u.getEmail() : "No registrado" %></td>
            <td><%= u.getPhone() != null ? u.getPhone() : "No registrado" %></td>
            <td><%= u.getEmergency_contact() != null ? u.getEmergency_contact() : "No registrado" %></td>
            <td><%= u.getNum_document() != null ? u.getNum_document() : "No registrado" %></td>
            <td><%= u.getDocument_type_id() != null ? u.getDocument_type_id().getName() : "Sin Documento" %></td>,
            <td><%= u.getAddress_id() != null ? u.getAddress_id().getAddress_postal() : "Sin dirección" %></td>
            <td><%= u.getRole_id() != null ? u.getRole_id().getName() : "Sin rol" %></td>
            <td><%= u.isIs_active() ? "Activo" : "Inactivo" %></td>
            <td><%= u.getCreatedDate() != null ? u.getCreatedDate() : "-" %></td>
            <td><%= u.getUpdatedDate() != null ? u.getUpdatedDate() : "-" %></td>
            <td>
              <!-- Botón para Editar -->
              <button type="button" 
                      class="btn btn-link" 
                      onclick="openEditModal(
                          '<%= u.getId_users() %>', 
                          '<%= u.getFull_name() %>',
                          '<%= u.getLast_name() %>',
                          '<%= u.getEmail() %>',
                          '<%= u.getPhone() %>',
                          '<%= u.getEmergency_contact() %>',
                          '<%= u.getNum_document() %>',
                          '<%= u.getDocument_type_id() != null ? u.getDocument_type_id().getDocument_type() : "0" %>',
                          '<%= u.getRole_id() != null ? u.getRole_id().getRole_id() : "0" %>',
                          '<%= u.isIs_active() ? "Activo" : "Inactivo" %>',
                          '<%= u.getCreatedDate() %>',
                          '<%= u.getUpdatedDate() %>'
                      )">
                <i class="fa fa-edit" style="color:blue;"></i>
              </button>

              <!-- Botón para Eliminar -->
              <form action="SvUserEliminar" method="post" style="display:inline;" 
                    onsubmit="return confirm('¿Estás seguro de eliminar este usuario?');">
                <input type="hidden" name="id" value="<%= u.getId_users() %>"/>
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
          <tr><td colspan="14">No hay usuarios disponibles</td></tr>
          <%
            }
          %>
        </tbody>
      </table>

      </div>
          
          
   
            
        </div>
    </div>
            

   
  
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script>
  $(document).ready(function () {
    $('#table_id').DataTable();
  });
</script>
<script>
    function openCrearModal() {
    // Mostrar el modal
    var createModal = new bootstrap.Modal(document.getElementById('createModal'));
    
    const today = new Date().toISOString().split('T')[0];
    
    createModal.show();
  }

    
 function openEditModal(
  id, nombre, apellido, email, contacto, contacto_em, 
  num_doc, tip_doc, rol, status, 
  createdDate, updatedDate
) {
  document.getElementById('userId').value = id;
  document.getElementById('nombre').value = nombre;
  document.getElementById('apellido').value = apellido;
  document.getElementById('email').value = email;
  document.getElementById('contacto').value = contacto;
  document.getElementById('contacto_em').value = contacto_em;
  document.getElementById('num_doc').value = num_doc;
  document.getElementById('status').value = status;
  document.getElementById('createdDate').value = createdDate;
  document.getElementById('updatedDate').value = updatedDate;

  setSelectByValue('tip_doc', tip_doc);
  setSelectByValue('rol', rol);

  var editModal = new bootstrap.Modal(document.getElementById('editModal'));
  editModal.show();
}

function setSelectByValue(selectId, value) {
  const select = document.getElementById(selectId);
  for (let i = 0; i < select.options.length; i++) {
    if (select.options[i].value == value) {
      select.selectedIndex = i;
      break;
    }
  }
}

</script>

<script>
  function updateRolIndex() {
    const select = document.getElementById("rol");
    const index = select.selectedIndex;
    document.getElementById("rolIndex").value = index;
  }
  function updateTipDocIndex() {
    const select = document.getElementById("tip_doc");
    const index = select.selectedIndex;
    document.getElementById("tip_docIndex").value = index;
  }
  
  
    function updateRolIndex2() {
    const select = document.getElementById("rol2");
    const index = select.selectedIndex;
    document.getElementById("rolIndex2").value = index;
  }
  function updateTipDocIndex2() {
    const select = document.getElementById("tip_doc2");
    const index = select.selectedIndex;
    document.getElementById("tip_docIndex2").value = index;
  }


  // Ejecutar al cargar por si el valor ya viene seteado (al abrir modal con datos)
  window.addEventListener("load", updateRolIndex);
  window.addEventListener("load", updateTipDocIndex);

    window.addEventListener("load", updateRolIndex2);
  window.addEventListener("load", updateTipDocIndex2);
 
</script>
    <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>"></script>
  <script src="js/indexAdminapp.min.js"></script>
  <script src="js/indexAdmindashboard.js"></script>
  
  <!-- Modalitos Editar -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form id="editForm" method="post" action="SvUserEditar">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editModalLabel">Editar Usuario</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body">
          <!-- ID (readonly) -->
          <div class="mb-3">
            <label for="userId" class="form-label">ID</label>
            <input type="text" class="form-control" id="userId" name="userId" readonly>
          </div>

          <!-- Host (editable si quieres, o readonly si no) -->
          <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
          </div>

          <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" class="form-control" id="apellido" name="apellido" required>
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="text" class="form-control" id="email" name="email" required>
          </div>

          <div class="mb-3">
            <label for="contacto" class="form-label">Contacto</label>
            <input type="text" class="form-control" id="contacto" name="contacto" required>
          </div>

          <div class="mb-3">
            <label for="contacto_em" class="form-label">Contacto de Emergencia</label>
            <input type="text" class="form-control" id="contacto_em" name="contacto_em" required>
          </div>

          <div class="mb-3">
            <label for="num_doc" class="form-label">Numero de documento</label>
            <input type="text" class="form-control" id="num_doc" name="num_doc" min="1" required>
          </div>

          <div class="mb-3">
            <label for="tip_doc" class="form-label">Tipo de documento</label>
            <select class="form-select" id="tip_doc" name="tip_doc" required onchange="updateTipDocIndex()">
                <% 
                  List<Models.Document_type> tipos_doc = (List<Models.Document_type>) request.getAttribute("listatiposdocumento");
                  if (tipos_doc != null) {
                      for (Models.Document_type tipo_doc : tipos_doc) {
                %>
                  <option value="<%= tipo_doc.getDocument_type()%>"><%= tipo_doc.getName()%></option>
                <% 
                      }
                  }
                %>
            </select>
            <!-- Campo oculto para el índice -->
            <input type="hidden" id="tip_docIndex" name="tip_docIndex">
          </div>

      

          <div class="mb-3">
            <label for="rol" class="form-label">Rol</label>
            <select class="form-select" id="rol" name="rol" required onchange="updateRolIndex()">
                <% 
                  List<Models.Roles> roles = (List<Models.Roles>) request.getAttribute("listaroles");
                  if (roles != null) {
                      for (Models.Roles rol : roles) {
                %>
                  <option value="<%= rol.getRole_id()%>"><%= rol.getName()%></option>
                <% 
                      }
                  }
                %>
            </select>
            <!-- Campo oculto para el índice -->
            <input type="hidden" id="rolIndex" name="rolIndex">

          </div>

          <div class="mb-3">
            <label for="status" class="form-label">Estado</label>
            <input type="text" class="form-control" id="status" name="status" required>
          </div>

          <!-- Fecha Creación (readonly) -->
          <div class="mb-3">
            <label for="createdDate" class="form-label">Fecha de Creación</label>
            <input type="text" class="form-control" id="createdDate" name="createdDate" readonly>
          </div>

          <!-- Última Actualización (readonly) -->
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
            
            
<!-- Modal Crear Usuario -->
<div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form id="createForm" method="post" action="SvUserCrear">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="createModalLabel">Crear Usuario</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body">

          <div class="mb-3">
            <label for="nombreCreate" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombreCreate" name="nombre" required>
          </div>

          <div class="mb-3">
            <label for="apellidoCreate" class="form-label">Apellido</label>
            <input type="text" class="form-control" id="apellidoCreate" name="apellido" required>
          </div>

          <div class="mb-3">
            <label for="emailCreate" class="form-label">Email</label>
            <input type="email" class="form-control" id="emailCreate" name="email" required>
          </div>

          <div class="mb-3">
            <label for="contactoCreate" class="form-label">Contacto</label>
            <input type="text" class="form-control" id="contactoCreate" name="contacto">
          </div>

          <div class="mb-3">
            <label for="contacto_emCreate" class="form-label">Contacto de Emergencia</label>
            <input type="text" class="form-control" id="contacto_emCreate" name="contacto_em" >
          </div>

            
            <div class="mb-3">
            <label for="tip_doc2" class="form-label">Tipo de documento</label>
            <select class="form-select" id="tip_doc2" name="tip_doc2" required onchange="updateTipDocIndex2()">
              <%
                List<Models.Document_type> tipos_doc2 = (List<Models.Document_type>) request.getAttribute("listatiposdocumento");
                if (tipos_doc2 != null) {
                  for (Models.Document_type tipo_doc2 : tipos_doc2) {
              %>
                <option value="<%= tipo_doc2.getDocument_type() %>"><%= tipo_doc2.getName() %></option>
              <% 
                  }
                }
              %>
            </select>
            <input type="hidden" id="tip_docIndex2" name="tip_docIndex2">
          </div>
            
          <div class="mb-3">
            <label for="num_docCreate" class="form-label">Número de documento</label>
            <input type="text" class="form-control" id="num_docCreate" name="num_doc" min="1" required>
          </div>

          

       

          <div class="mb-3">
            <label for="rol2" class="form-label">Rol</label>
            <select class="form-select" id="rol2" name="rol2" required onchange="updateRolIndex2()">
              <% 
                List<Models.Roles> roles2 = (List<Models.Roles>) request.getAttribute("listaroles");
                if (roles2 != null) {
                  for (Models.Roles rol : roles2) {
              %>
                <option value="<%= rol.getRole_id() %>"><%= rol.getName() %></option>
              <% 
                  }
                }
              %>
            </select>
            <input type="hidden" id="rolIndex2" name="rolIndex2">
          </div>

          <div class="mb-3">
            <label for="statusCreate" class="form-label">Estado</label>
            <input type="text" class="form-control" id="statusCreate" name="status" required>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-success">Crear Usuario</button>
        </div>
      </div>
    </form>
  </div>
</div>
            
            

</body>

</html>
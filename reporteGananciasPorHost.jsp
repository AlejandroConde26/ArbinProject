<%@page import="Models.User"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Object[]> listaAnfitriones = (List<Object[]>) request.getAttribute("listaAnfitriones");
    List<Object[]> resumenReservas = (List<Object[]>) request.getAttribute("resumenReservas");
    Double gananciaTotal = (Double) request.getAttribute("gananciaTotal");
    Integer hostSeleccionado = (Integer) request.getAttribute("hostSeleccionado");
    List<Object[]> detalleReservas = (List<Object[]>) request.getAttribute("detalleReservas");

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ganancias por Anfitrión</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="js/graficohost.js"></script>
    <link rel="stylesheet" href="css/reportehost.css">
    <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
    <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.0/css/dataTables.dataTables.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
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
                            <a class="sidebar-link" href="indexAdmin.jsp" aria-expanded="false">
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
                    <div class="container-fluid">
                        <div class="card mt-4">
                            <div class="card-body">
                                <h4 class="card-title">Ganancias por Anfitrión</h4>
                                <form method="get" action="SvReporteGananciasPorHost" class="row g-3 align-items-center mb-3">
                                    <div class="col-auto">
                                        <label for="host_id" class="col-form-label">Seleccione un anfitrión:</label>
                                    </div>
                                    <div class="col-auto">
                                        <select class="form-select" name="host_id" required>
                                            <option value="">-- Seleccione --</option>
                                            <% for (Object[] row : listaAnfitriones) {
                                                int id = ((Number) row[0]).intValue();
                                                String nombre = (String) row[1];
                                            %>
                                                <option value="<%= id %>" <%= (hostSeleccionado != null && hostSeleccionado == id) ? "selected" : "" %>>
                                                    <%= nombre %>
                                                </option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-primary">Ver Reporte</button>
                                    </div>
                                </form>

                                <% if (resumenReservas != null && !resumenReservas.isEmpty()) { %>
                                    <h5>Total Ganado: <strong>S/ <%= String.format("%.2f", gananciaTotal) %></strong></h5>
                                    <div class="table-responsive mt-3">
                                        <table class="table table-bordered">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Nombre</th>
                                                    <th>Email</th>
                                                    <th>Cantidad de Reservas</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <% for (Object[] fila : resumenReservas) { %>
                                                <tr>
                                                    <td><%= fila[1] %></td>
                                                    <td><%= fila[2] %></td>
                                                    <td><%= fila[3] %></td>
                                                </tr>
                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                <% } %>

                                <% if (detalleReservas != null && !detalleReservas.isEmpty()) { %>
                                    <h5 class="mt-4">Detalle de Reservas</h5>
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Nombre</th>
                                                    <th>Email</th>
                                                    <th>Alojamiento</th>
                                                    <th>Inicio</th>
                                                    <th>Fin</th>
                                                    <th>Total Pagado</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <% for (Object[] fila : detalleReservas) { %>
                                                <tr>
                                                    <td><%= fila[1] %></td>
                                                    <td><%= fila[2] %></td>
                                                    <td><%= fila[3] %></td>
                                                    <td><%= fila[4] %></td>
                                                    <td><%= fila[5] %></td>
                                                    <td>S/ <%= fila[6] != null ? String.format("%.2f", ((Number) fila[6]).doubleValue()) : "0.00" %></td>
                                                </tr>
                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Contenedor para el gráfico -->
                                    <div class="mt-5">
                                        <canvas id="graficoReservas" height="100"></canvas>
                                    </div>
                                    <script>
                                        const detalleData = [
                                            <% for (Object[] fila : detalleReservas) { %>
                                                { usuario: "<%= fila[1] %>", total: <%= (fila[6] != null) ? ((Number) fila[6]).doubleValue() : 0.0 %> },
                                            <% } %>
                                        ];
                                        generarGrafico(detalleData);
                                    </script>
                                <% } %>
                            </div>
                        </div>
                    </div>    
                            
  
        
        
        
        
        <div class="d-flex gap-3 mt-4 align-items-center">
            <div class="col-auto">
                <button type="button" class="btn btn-secondary" onclick="imprimirReporteConGrafico()">
                    Imprimir Reporte (PDF)
                </button>
            </div>
            <form id="pdfForm" action="SvGenerarPdfReporte" method="post" target="_blank" style="display:none;">
                <input type="hidden" name="tipoReporte" value="reservas">
                <input type="hidden" name="hostId" value="<%= hostSeleccionado != null ? hostSeleccionado : "" %>">
                <input type="hidden" name="gananciaTotal" value="<%= gananciaTotal != null ? String.format("%.2f", gananciaTotal) : "" %>">
                <input type="hidden" name="resumenReservasData" id="pdfResumenData">
                <input type="hidden" name="detalleReservasData" id="pdfDetalleData">
                <input type="hidden" name="chartImage" id="chartImagePdf">
            </form>

            <form id="formExcel" action="SvGenerarExcelReporte" method="post" target="_blank">
                <input type="hidden" name="tipoReporte" value="reservas">
                <input type="hidden" name="chartImage" id="chartImageExcel">
                <input type="hidden" name="hostId" value="<%= hostSeleccionado != null ? hostSeleccionado : "" %>">
                <input type="hidden" name="gananciaTotal" value="<%= gananciaTotal != null ? String.format("%.2f", gananciaTotal) : "" %>">
                <input type="hidden" name="resumenReservasData" id="excelResumenData">
                <input type="hidden" name="detalleReservasData" id="excelDetalleData">

                <button type="submit" class="btn btn-success">Descargar Excel</button>
            </form>

        </div>
            <script>
                function imprimirReporteConGrafico() {
                    const hostId = "<%= hostSeleccionado != null ? hostSeleccionado : "" %>";
                    const gananciaTotal = "<%= gananciaTotal != null ? String.format("%.2f", gananciaTotal) : "" %>";

                    // Capturar datos de resumenReservas
                    const resumenReservasTable = document.querySelector('.table-bordered');
                    let resumenData = [];
                    if (resumenReservasTable) {
                        const rows = resumenReservasTable.querySelectorAll('tbody tr');
                        rows.forEach(row => {
                            const cols = row.querySelectorAll('td');
                            if (cols.length >= 3) {
                                resumenData.push({
                                    nombre: cols[0].innerText,
                                    email: cols[1].innerText,
                                    cantidadReservas: cols[2].innerText
                                });
                            }
                        });
                    }
                    const detalleReservasTable = document.querySelectorAll('.table-bordered')[1]; // Asumiendo que es la segunda tabla
                    let detalleData = [];
                    if (detalleReservasTable) {
                        const rows = detalleReservasTable.querySelectorAll('tbody tr');
                        rows.forEach(row => {
                            const cols = row.querySelectorAll('td');
                            if (cols.length >= 7) {
                                detalleData.push({
                                    nombre: cols[0].innerText,
                                    email: cols[1].innerText,
                                    alojamiento: cols[2].innerText,
                                    inicio: cols[3].innerText,
                                    fin: cols[4].innerText,
                                    totalPagado: cols[5].innerText
                                });
                            }
                        });
                    }

                    // Capturar la imagen del gráfico
                    const canvas = document.getElementById('graficoReservas');
                    let chartImage = '';
                    if (canvas) {
                        chartImage = canvas.toDataURL('image/png'); // Convierte el canvas a una imagen PNG en base64
                    }

                    // Asignar los valores a los campos ocultos del formulario
                    const form = document.getElementById('pdfForm');
                    form.hostId.value = hostId;
                    form.gananciaTotal.value = gananciaTotal;
                    form.resumenReservasData.value = JSON.stringify(resumenData);
                    form.detalleReservasData.value = JSON.stringify(detalleData);
                    form.chartImage.value = chartImage;

                    // Enviar el formulario
                    form.submit();
                }
            </script>
                <script>

        document.getElementById('formExcel').addEventListener('submit', function (e) {
            const canvas = document.getElementById('graficoReservas');
            if (canvas) {
                const chartImageBase64 = canvas.toDataURL('image/png');
                document.getElementById('chartImageExcel').value = chartImageBase64;
            }

            document.getElementById('excelResumenData').value = JSON.stringify(resumenReservasData);
            document.getElementById('excelDetalleData').value = JSON.stringify(detalleReservasData);
        });
        </script>
   </body>                            
</html>




<%@page import="java.util.Map"%>
<%@page import="Models.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard de Reservas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
           <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
        <style>
            canvas {
                max-width: 100%;
            }
            .metric-card {
                border-left: 5px solid #007bff;
                padding: 1rem;
                border-radius: 0.75rem;
                background: #f8f9fa;
                margin-bottom: 1rem;
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
          <div class="container mt-4">
            <h1 class="mb-4">Dashboard de Reservas por Mes</h1>

            <!-- Selector de año -->
            <form method="get" action="dashboard" class="mb-4">
                <div class="row">
                    <div class="col-md-3">
                        <label for="year" class="form-label">Seleccionar Año:</label>
                        <select name="year" id="year" class="form-select" onchange="this.form.submit()">
                            <c:forEach var="y" begin="2020" end="2025">
                                <option value="${y}" ${y == selectedYear ? 'selected' : ''}>${y}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </form>

            <!-- Depuración: Mostrar datos crudos -->
            <div class="alert alert-info">
                <h5>Datos recibidos:</h5>
                <c:if test="${empty reservations}">
                    <p>No hay datos para el año ${selectedYear}.</p>
                </c:if>
            </div>

            <!-- Gráfico de barras -->
            <div class="row mt-4">
                <div class="col-12">
                    <canvas id="reservationsChart"></canvas>
                </div>
            </div>

            <!-- Tarjetitas de métricas -->
            <div class="row mt-4" id="metricsContainer">
                <div class="col-12">
                    <div class="alert alert-secondary text-center" id="metricsPlaceholder">
                        Haz clic en una barra del gráfico para ver las métricas del hotel.
                    </div>
                </div>
            </div>
        </div>
            
        </div>
    </div>

        
       

        <script>
            // Verificar carga de Chart.js
            if (typeof Chart === 'undefined') {
                console.error('Chart.js no se cargó correctamente');
            } else {
                console.log('Chart.js cargado correctamente');
            }

            const ctx = document.getElementById('reservationsChart').getContext('2d');
            const months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];

            // Preparar datos para el gráfico
            const reservationsData = [
            <c:forEach var="reservation" items="${reservations}" varStatus="index">
            {
            month: ${reservation.reservationMonth},
                    housingId: ${reservation.housingId},
                    housingName: '${reservation.housingName.replaceAll("['\"]", "\\\\$0")}',
                    totalReservations: ${reservation.totalReservations}
            }${index.last ? '' : ','}
            </c:forEach>
            ];

            // Depuración
            console.log('Reservations Data:', reservationsData);

            // Preparar datos para el gráfico
            const data = Array(12).fill(0);
            const labels = Array(12).fill('');
            reservationsData.forEach(item => {
                if (item.month >= 1 && item.month <= 12) {
                    const monthIndex = item.month - 1;
                    data[monthIndex] = item.totalReservations;
                    labels[monthIndex] = item.housingName;
                } else {
                    console.warn('Mes inválido:', item.month);
                }
            });

            // Crear el gráfico
            const chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: months,
                    datasets: [{
                            label: 'Reservas del Hotel Top',
                            data: data,
                            backgroundColor: 'rgba(0, 123, 255, 0.7)',
                            borderColor: 'rgba(0, 123, 255, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        x: {title: {display: true, text: 'Mes'}},
                        y: {beginAtZero: true, title: {display: true, text: 'Número de Reservas'}}
                    },
                    plugins: {
                        legend: {display: true},
                        tooltip: {
                            callbacks: {
                                label: function (context) {
                                    const monthIndex = context.dataIndex;
                                    const hotel = reservationsData.find(item => item.month === monthIndex + 1);
                                    return hotel ? `${hotel.housingName}: ${context.raw} reservas` : '';
                                }
                            }
                        }
                    },
                    onClick: (event, elements) => {
                        if (elements.length > 0) {
                            const index = elements[0].index;
                            const month = index + 1;
                            const hotel = reservationsData.find(item => item.month === month);
                            const selectedYear = ${selectedYear};
                            if (hotel) {
                                fetchHotelMetrics(hotel.housingId, month, selectedYear);
                            }
                        }
                    }
                }
            });
            // Función para obtener métricas vía AJAX
            function fetchHotelMetrics(housingId, month, year) {
                fetch(`/BookingSystemWeb/dashboard/metrics?housingId=` + housingId + `&month=` + month + `&year=` + year)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.message) {
                                // Manejar error
                                document.getElementById('metricsContainer').innerHTML = `
                                <div class="col-12">
                                    <div class="alert alert-danger text-center">`
                                        + data.message +
                                        `</div>
                                </div>
                            `;
                            } else {
                                // Mostrar métricas en tarjetitas
                                document.getElementById('metricsContainer').innerHTML = `
                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #eaf5ff">
                                         <h5 class="card-title"><i class="bi bi-house-fill me-2 text-info fs-4"></i> Nombre del Alojamiento</h5>
                                         <p class="card-text">` + data.housingName + `</p>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #fff5cc">
                                        <h5 class="card-title"><i class="bi bi-person-fill me-2 text-warning fs-4"></i> Dueño</h5>
                                        <p class="card-text">` + data.hostName + `</p>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #d5f5e3">
                                        <h5 class="card-title"><i class="bi bi-geo-alt-fill me-2 text-success fs-4"></i> Ubicación</h5>
                                        <p class="card-text">` + data.city + `, ` + data.country + `</p>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #fce5e5">
                                        <h5 class="card-title"><i class="bi bi-cash-coin me-2 text-danger fs-4"></i> Ingresos Totales</h5>
                                        <p class="card-text">$` + data.totalRevenue.toFixed(2) + `</p>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #edf5d1">
                                        <h5 class="card-title"><i class="bi bi-people-fill me-2 text-primary fs-4"></i> Huéspedes Totales</h5>
                                        <p class="card-text">` + data.totalGuests + `</p>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #fff0cc">
                                        <h5 class="card-title"><i class="bi bi-star-fill me-2 text-warning fs-4"></i> Estrellas</h5>
                                        <p class="card-text">` + data.stars + ` ⭐</p>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card metric-card p-3 shadow rounded-3 border-0" style="background: #eaf5ff">
                                        <h5 class="card-title"><i class="bi bi-graph-up-arrow me-2 text-info fs-4"></i> Ocupación Promedio</h5>
                                        <p class="card-text">` + data.averageOccupancy.toFixed(2) + `%</p>
                                    </div>
                                </div>
                            `;
                            }
                        })
                        .catch(error => {
                            console.error('Error fetching metrics:', error);
                            document.getElementById('metricsContainer').innerHTML = `
                            <div class="col-12">
                                <div class="alert alert-danger text-center">
                                    Error al cargar las métricas:` + error.message + `
                                </div>
                            </div>
                        `;
                        });
            }
        </script>
        
        <div class="row mt-4 w-100">
            <div class="col-md-6 text-center">
                <form id="pdfForm" method="post" action="SvExportarDashboardPDF">
                    <input type="hidden" name="imageData" id="pdfImageData">
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-file-earmark-pdf-fill"></i> Exportar a PDF
                    </button>
                </form>
            </div>
            <div class="col-md-6 text-center">
                <form id="excelForm" method="post" action="SvExportarDashboardExcel">
                    <input type="hidden" name="excelYear" value="${selectedYear}">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-file-earmark-excel-fill"></i> Exportar a Excel
                    </button>
                </form>
            </div>
        </div>
        <script>
            setTimeout(() => {
                const chartCanvas = document.getElementById('reservationsChart');
                const imageData = chartCanvas.toDataURL('image/png');
                document.getElementById('pdfImageData').value = imageData;
            }, 1000); // esperar 1 segundo para asegurar que el gráfico esté listo
        </script>         
        <%
            Map<String, Integer> conteoMesHousing = (Map<String, Integer>) request.getAttribute("conteoMesHousing");
            Map<String, String> nombresHousing = (Map<String, String>) request.getAttribute("nombresHousing");

            if (conteoMesHousing != null && nombresHousing != null) {
                for (Map.Entry<String, Integer> entry : conteoMesHousing.entrySet()) {
                    String clave = entry.getKey(); // formato: mes-housingId
                    String[] partes = clave.split("-");
                    int mes = Integer.parseInt(partes[0]);
                    String nombre = nombresHousing.get(clave);
        %>
                    <tr>
                        <td><%= mes %></td>
                        <td><%= nombre %></td>
                        <td><%= entry.getValue() %></td>
                    </tr>
        <%
                }
            } else {
        %>
                <tr><td colspan="3">No hay datos disponibles para mostrar.</td></tr>
        <%
            }
        %>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>"></script>
        <script src="js/indexAdminapp.min.js"></script>
        <script src="js/indexAdmindashboard.js"></script>
    </body>
</html>


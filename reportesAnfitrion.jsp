<%@page import="Models.HostReportes"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@page import="Models.User"%>

<%
   
    List<HostReportes> lista = (List<HostReportes>) request.getAttribute("listaAnfitriones");
    if (lista != null) {
        session.setAttribute("listaAnfitriones", lista); 
    }  
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Anfitriones</title>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="css/reporte_ventas.css?v=<%= System.currentTimeMillis() %>"/>
    <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
    <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>"></script>

    <script>
        function renderGraficoAlojamientos(anfitriones) {
            const ctx = document.getElementById('graficoAlojamientos').getContext('2d');

            const labels = anfitriones.map(a => a.nombre);
            const datos = anfitriones.map(a => a.total);
            const colores = [
                '#4dc9f6', '#f67019', '#f53794', '#537bc4', '#acc236',
                '#166a8f', '#00a950', '#58595b', '#8549ba', '#66cc99', '#ffcc00', '#9933ff', '#ff6666'
            ];

            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: datos,
                        backgroundColor: colores,
                        borderColor: '#fff',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false, // Permite que el gráfico no sea cuadrado
                    cutout: '60%',
                    plugins: {
                        legend: {
                            position: 'right',
                            labels: {
                                boxWidth: 12,
                                padding: 15
                            }
                        },
                        title: {
                            display: true,
                            text: 'Distribución de Alojamientos por Anfitrión',
                            font: {
                                size: 18
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function (context) {
                                    const index = context.dataIndex;
                                    const a = anfitriones[index];
                                    return [
                                        `Anfitrión: ${a.nombre}`,
                                        `Alojamientos: ${a.total}`,
                                        `Precio prom.: S/ ${a.precio.toFixed(2)}`,
                                        `Ciudades: ${a.ciudades}`,
                                        `Activos: ${a.activos}`,
                                        `Última publicación: ${a.ultima}`
                                    ];
                                }
                            }
                        }
                    }
                }
            });
        }
    </script>
</head>
<body>
    <%
        HttpSession misession = request.getSession();
        User sessionUser = (User) misession.getAttribute("user");
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;         }
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

        <div class="body-wrapper" id="mainContentWrapper">
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
                                <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
                                    <%= (sessionUser != null && sessionUser.getEmail() != null && !sessionUser.getEmail().isEmpty())
                                        ? sessionUser.getEmail().substring(0, 1).toUpperCase() : "U" %>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                                    <div class="message-body">
                                        <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                            <i class="ti ti-user fs-6"></i>
                                            <p class="mb-0 fs-3">Mi Perfil</p>
                                        </a>
                                        <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                            <i class="ti ti-mail fs-6"></i>
                                            <p class="mb-0 fs-3">Mi Cuenta</p>
                                        </a>
                                        <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                                            <i class="ti ti-list-check fs-6"></i>
                                            <p class="mb-0 fs-3">Mis Tareas</p>
                                        </a>
                                        <a href="SvCerrarSesion" class="btn btn-outline-primary mx-3 mt-2 d-block">Cerrar Sesión</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>

             <div class="container-fluid mt-4" style="    display: flex
;
    padding: 0;
    flex-direction: column;
    align-items: center;
    justify-content: center;">
                <h1>Reporte: Anfitriones con más alojamientos</h1>

                <% if (lista == null || lista.isEmpty()) { %>
                    <p>No se encontraron datos.</p>
                <% } else { %>

                    <div class="chart-container" style="position: relative; height:40vh;">
                        <canvas id="graficoAlojamientos"></canvas>
                    </div>

                    <script>
                        const anfitriones = [
                        <% for (HostReportes h : lista) { %>
                            {
                                nombre: "<%= h.getNombre().replace("\"", "\\\"") %>",
                                total: <%= h.getTotal() %>,
                                precio: <%= h.getPrecioPromedio() %>,
                                ciudades: <%= h.getCantidadCiudades() %>,
                                activos: <%= h.getAlojamientosActivos() %>,
                                ultima: "<%= h.getUltimaPublicacion() != null ? h.getUltimaPublicacion() : "-" %>"
                            },
                        <% } %>
                        ];
                        // Llama a la función de renderizado después de definir los datos
                        renderGraficoAlojamientos(anfitriones);
                    </script>

                    <div class="table-responsive">
                        <table class="table table-striped table-bordered mt-4">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Correo</th>
                                    <th>Teléfono</th>
                                    <th>Total Alojamientos</th>
                                    <th>Precio&nbsp;Promedio</th>
                                    <th>Ciudades</th>
                                    <th>Alojamientos&nbsp;Activos</th>
                                    <th>Última&nbsp;Publicación</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (HostReportes h : lista) { %>
                                <tr>
                                    <td><%= h.getNombre() %></td>
                                    <td><%= h.getCorreo() %></td>
                                    <td><%= h.getTelefono() %></td>
                                    <td><%= h.getTotal() %></td>
                                    <td>S/ <%= String.format("%.2f", h.getPrecioPromedio()) %></td>
                                    <td><%= h.getCantidadCiudades() %></td>
                                    <td><%= h.getAlojamientosActivos() %></td>
                                    <td><%= h.getUltimaPublicacion() != null ? h.getUltimaPublicacion() : "-" %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
     <div class="w-100 d-flex align-items-center justify-content-center">
        <form id="formPdfAnfitriones" action="SvGenerarPdfAnfitriones" method="post" target="_blank" style="display: inline-block; margin-right: 10px;">
            <input type="hidden" name="chartImagePdf" id="chartImagePdf">
            <input type="hidden" name="tipoReporte" value="anfitriones">
            <button type="submit" class="btn btn-primary mt-4">
                <i class="ti ti-file-text"></i> Descargar Reporte PDF
            </button>
        </form>

        <form id="formExcelAnfitriones" action="SvGenerarExcelAnfitriones" method="post" target="_blank" style="display: inline-block;">
            <input type="hidden" name="chartImageExcel" id="chartImageExcel">
            <button type="submit" class="btn btn-success mt-4">
                <i class="ti ti-file-spreadsheet"></i> Descargar Reporte Excel
            </button>
        </form>
    </div>

      <script>
    document.addEventListener('DOMContentLoaded', function () {
        const canvas = document.getElementById('graficoAlojamientos');
        const chartPdfInput = document.getElementById('chartImagePdf');
        const chartExcelInput = document.getElementById('chartImageExcel');
        const pdfButton = document.querySelector('#formPdfAnfitriones button');
        const excelButton = document.querySelector('#formExcelAnfitriones button');

        if (typeof anfitriones !== 'undefined' && anfitriones.length > 0) {
            const chart = renderGraficoAlojamientos(anfitriones);

            // Esperamos 500ms a que se renderice el gráfico antes de capturar la imagen
            setTimeout(() => {
                if (canvas) {
                    const imageData = canvas.toDataURL('image/png');
                    chartPdfInput.value = imageData;
                    chartExcelInput.value = imageData;
                }
            }, 500);
        } else {
            if (pdfButton) {
                pdfButton.disabled = true;
                pdfButton.textContent = 'No hay datos para exportar a PDF';
            }
            if (excelButton) {
                excelButton.disabled = true;
                excelButton.textContent = 'No hay datos para exportar a Excel';
            }
        }

        // Captura imagen al enviar PDF
        document.getElementById('formPdfAnfitriones').addEventListener('submit', function (e) {
            if (canvas) {
                chartPdfInput.value = canvas.toDataURL('image/png');
            }
        });

        // Captura imagen al enviar Excel
        document.getElementById('formExcelAnfitriones').addEventListener('submit', function (e) {
            if (canvas) {
                chartExcelInput.value = canvas.toDataURL('image/png');
            }
        });
    });
</script>
</body>
</html>
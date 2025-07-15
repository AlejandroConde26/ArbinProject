<%@page import="Models.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.IngresoMensual" %>
<%
    List<IngresoMensual> ingresosPorHost = (List<IngresoMensual>) request.getAttribute("ingresosPorHost");
    List<IngresoMensual> ingresosGenerales = (List<IngresoMensual>) request.getAttribute("ingresosGenerales");
    int anio = (int) request.getAttribute("anioSeleccionado");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte de Ingresos Mensuales - <%= anio %></title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="css/indexAdmin.min.css?v=<%= System.currentTimeMillis() %>" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }
        h1, h2 {
            color: #333;
        }
        canvas {
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        th, td {
            padding: 10px 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        select {
            padding: 6px 12px;
            font-size: 16px;
            margin-bottom: 20px;
        }
        #contenedorGrafico {
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            gap: 20px;
            max-width: 100%;
        }
        #graficoHost {
            flex-grow: 1;
            max-width: 100%;
        }
        .report-buttons {
            margin-bottom: 20px;
        }
        .report-buttons button {
            padding: 10px 15px;
            margin-right: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .report-buttons button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%
        HttpSession misession = request.getSession();
        User sessionUser = (User) misession.getAttribute("user");
        if (sessionUser == null) {
            response.sendRedirect("login.jsp");
            return;
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
                            <span class="hide-menu">Reportes Estadísticos</span>
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
            <div class="container-fluid mt-4">

                <h1>Reporte de Ingresos Mensuales - <%= anio %></h1>

                <div class="report-buttons">
                    <button onclick="downloadPdf()">Descargar PDF (Reporte Completo)</button>
                    <button onclick="downloadExcel()">Descargar Excel</button>
                    <button onclick="downloadPdfTablesOnly()">Descargar PDF (Solo Tablas)</button>
                </div>

                <h2>Gráfico 1: Ingresos por Host y Housing</h2>
                <label for="selectorMes">Seleccionar mes:</label>
                <select id="selectorMes">
                    <option value="0">Todos</option>
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>">Mes <%= i %></option>
                    <% } %>
                </select>
                <div id="contenedorGrafico">
                    <canvas id="graficoHost"></canvas>
                </div>

                <script>
                    const ingresosRaw = [
                        <% for (IngresoMensual ingreso : ingresosPorHost) { %>
                            {
                                mes: <%= ingreso.getMes() %>,
                                host: "<%= ingreso.getNombreHost().replace("\"", "\\\"") %> - <%= ingreso.getNombreHousing().replace("\"", "\\\"") %>",
                                total: <%= ingreso.getIngresoTotal() %>
                            },
                        <% } %>
                    ];
                    const colores = ['#007bff', '#28a745', '#dc3545', '#ffc107', '#6610f2', '#17a2b8', '#e83e8c', '#fd7e14', '#20c997', '#6f42c1'];
                    let chartHost;

                    function agruparPorMes(mesSeleccionado) {
                        const datos = {};
                        for (const ingreso of ingresosRaw) {
                            if (mesSeleccionado === 0 || ingreso.mes === mesSeleccionado) {
                                if (!datos[ingreso.host]) {
                                    datos[ingreso.host] = Array(12).fill(0);
                                }
                                datos[ingreso.host][ingreso.mes - 1] = ingreso.total;
                            }
                        }
                        return datos;
                    }

                    function renderizarGrafico(mesSeleccionado) {
                        const datosAgrupados = agruparPorMes(mesSeleccionado);
                        const datasets = [];
                        let index = 0;
                        let etiquetas;

                        if (mesSeleccionado === 0) {
                            etiquetas = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
                        } else {
                            etiquetas = ["Mes " + mesSeleccionado];
                        }

                        for (const host in datosAgrupados) {
                            let data;
                            if (mesSeleccionado === 0) {
                                data = datosAgrupados[host];
                            } else {
                                data = [datosAgrupados[host][mesSeleccionado - 1]];
                            }

                            datasets.push({
                                label: host,
                                data: data,
                                backgroundColor: colores[index % colores.length],
                                borderRadius: 4
                            });
                            index++;
                        }

                        const ctx = document.getElementById('graficoHost').getContext('2d');
                        if (chartHost) chartHost.destroy();
                        chartHost = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: etiquetas,
                                datasets: datasets
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    tooltip: {
                                        callbacks: {
                                            label: function(context) {
                                                return 'S/ ' + context.parsed.y.toFixed(2);
                                            }
                                        }
                                    },
                                    legend: {
                                        position: 'right',
                                        align: 'center'
                                    }
                                },
                                animation: {
                                    duration: 1200,
                                    easing: 'easeOutBounce'
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            callback: function(value) {
                                                return 'S/ ' + value;
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    }

                    document.getElementById('selectorMes').addEventListener('change', function() {
                        const mes = parseInt(this.value);
                        renderizarGrafico(mes);

                        const filas = document.querySelectorAll('.fila-mes');
                        filas.forEach(fila => {
                            if (mes === 0) {
                                fila.style.display = '';
                            } else {
                                fila.style.display = fila.classList.contains('mes-' + mes) ? '' : 'none';
                            }
                        });
                    });

                    renderizarGrafico(0); // Mostrar todos por defecto
                </script>

                <table id="tablaHost">
                    <tr>
                        <th>Mes</th>
                        <th>Nombre Host</th>
                        <th>Nombre Housing</th>
                        <th>Ingreso Total (S/.)</th>
                    </tr>
                    <% for (IngresoMensual ingreso : ingresosPorHost) { %>
                        <tr class="fila-mes mes-<%= ingreso.getMes() %>">
                            <td><%= ingreso.getMes() %></td>
                            <td><%= ingreso.getNombreHost() %></td>
                            <td><%= ingreso.getNombreHousing() %></td>
                            <td>S/ <%= String.format("%.2f", ingreso.getIngresoTotal()) %></td>
                        </tr>
                    <% } %>
                </table>

                <h2>Gráfico 2: Ingresos Generales por Mes</h2>
                <canvas id="graficoGeneral"></canvas>
                <script>
                    const ingresosGeneralesData = [
                        <% for (int i = 1; i <= 12; i++) {
                            boolean encontrado = false;
                            for (IngresoMensual ing : ingresosGenerales) {
                                if (ing.getMes() == i) {
                                    out.print(ing.getIngresoTotal() + ",");
                                    encontrado = true;
                                    break;
                                }
                            }
                            if (!encontrado) out.print("0,");
                        } %>
                    ];
                    const ctxGeneral = document.getElementById('graficoGeneral').getContext('2d');
                    new Chart(ctxGeneral, {
                        type: 'line',
                        data: {
                            labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                            datasets: [{
                                label: 'Ingreso General S/.',
                                data: ingresosGeneralesData,
                                borderColor: '#17a2b8',
                                backgroundColor: 'rgba(23, 162, 184, 0.1)',
                                tension: 0.3,
                                fill: true,
                                pointRadius: 5,
                                pointHoverRadius: 7
                            }]
                        },
                        options: {
                            responsive: true,
                            animation: {
                                duration: 1200,
                                easing: 'easeInOutCubic'
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return 'S/ ' + value;
                                        }
                                    }
                                }
                            },
                            plugins: {
                                legend: {
                                    position: 'top'
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            return 'S/ ' + context.parsed.y.toFixed(2);
                                        }
                                    }
                                }
                            }
                        }
                    });
                </script>

                <table id="tablaGeneral">
                    <tr>
                        <th>Mes</th>
                        <th>Ingreso General (S/.)</th>
                    </tr>
                    <% for (int i = 1; i <= 12; i++) {
                        boolean encontrado = false;
                        for (IngresoMensual ing : ingresosGenerales) {
                            if (ing.getMes() == i) {
                    %>
                            <tr>
                                <td><%= i %></td>
                                <td>S/ <%= String.format("%.2f", ing.getIngresoTotal()) %></td>
                            </tr>
                    <%
                                encontrado = true;
                                break;
                            }
                        }
                        if (!encontrado) {
                    %>
                            <tr>
                                <td><%= i %></td>
                                <td>S/ 0.00</td>
                            </tr>
                    <% }
                    } %>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.8.2/jspdf.plugin.autotable.min.js"></script>
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

    <script>
        async function downloadPdf() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('p', 'pt', 'a4'); // 'p' for portrait, 'pt' for points, 'a4' for size
            const margin = 40;
            let y = margin;
            const pageWidth = doc.internal.pageSize.getWidth();

            doc.setFontSize(20);
            doc.text(`Reporte de Ingresos Mensuales - <%= anio %>`, pageWidth / 2, y, { align: 'center' });
            y += 30;

            // Capture Grafico 1: Ingresos por Host y Housing
            const graficoHostCanvas = document.getElementById('graficoHost');
            const imgDataHost = graficoHostCanvas.toDataURL('image/png');
            const imgWidthHost = pageWidth - 2 * margin;
            const imgHeightHost = (graficoHostCanvas.height * imgWidthHost) / graficoHostCanvas.width;

            if (y + imgHeightHost > doc.internal.pageSize.getHeight() - margin) {
                doc.addPage();
                y = margin;
            }
            doc.setFontSize(16);
            doc.text("Gráfico 1: Ingresos por Host y Housing", margin, y);
            y += 20;
            doc.addImage(imgDataHost, 'PNG', margin, y, imgWidthHost, imgHeightHost);
            y += imgHeightHost + 20;

            // Capture Tabla de detalle por host
            const tablaHost = document.getElementById('tablaHost');
            const tablaHostData = [];
            const tablaHostHeader = Array.from(tablaHost.querySelectorAll('th')).map(th => th.innerText);
            tablaHostData.push(tablaHostHeader);
            tablaHost.querySelectorAll('tbody tr').forEach(row => {
                // Only include visible rows (respecting the month filter)
                if (row.style.display !== 'none') {
                    tablaHostData.push(Array.from(row.querySelectorAll('td')).map(td => td.innerText));
                }
            });

            if (y + 20 + (tablaHostData.length * 15) > doc.internal.pageSize.getHeight() - margin) {
                doc.addPage();
                y = margin;
            }
            doc.setFontSize(16);
            doc.text("Tabla 1: Detalle por Host", margin, y);
            y += 20;
            doc.autoTable({
                startY: y,
                head: [tablaHostData[0]],
                body: tablaHostData.slice(1),
                theme: 'striped',
                margin: { left: margin, right: margin },
                styles: { fontSize: 10, cellPadding: 5 },
                headStyles: { fillColor: [0, 123, 255], textColor: [255, 255, 255] },
                didDrawPage: function(data) {
                    y = data.cursor.y; // Update y position after table
                }
            });
            y = doc.autoTable.previous.finalY + 20;

            // Capture Grafico 2: Ingresos Generales por Mes
            const graficoGeneralCanvas = document.getElementById('graficoGeneral');
            const imgDataGeneral = graficoGeneralCanvas.toDataURL('image/png');
            const imgWidthGeneral = pageWidth - 2 * margin;
            const imgHeightGeneral = (graficoGeneralCanvas.height * imgWidthGeneral) / graficoGeneralCanvas.width;

            if (y + imgHeightGeneral > doc.internal.pageSize.getHeight() - margin) {
                doc.addPage();
                y = margin;
            }
            doc.setFontSize(16);
            doc.text("Gráfico 2: Ingresos Generales por Mes", margin, y);
            y += 20;
            doc.addImage(imgDataGeneral, 'PNG', margin, y, imgWidthGeneral, imgHeightGeneral);
            y += imgHeightGeneral + 20;

            // Capture Tabla de resumen general
            const tablaGeneral = document.getElementById('tablaGeneral');
            const tablaGeneralData = [];
            const tablaGeneralHeader = Array.from(tablaGeneral.querySelectorAll('th')).map(th => th.innerText);
            tablaGeneralData.push(tablaGeneralHeader);
            tablaGeneral.querySelectorAll('tbody tr').forEach(row => {
                tablaGeneralData.push(Array.from(row.querySelectorAll('td')).map(td => td.innerText));
            });

            if (y + 20 + (tablaGeneralData.length * 15) > doc.internal.pageSize.getHeight() - margin) {
                doc.addPage();
                y = margin;
            }
            doc.setFontSize(16);
            doc.text("Tabla 2: Resumen General", margin, y);
            y += 20;
            doc.autoTable({
                startY: y,
                head: [tablaGeneralData[0]],
                body: tablaGeneralData.slice(1),
                theme: 'striped',
                margin: { left: margin, right: margin },
                styles: { fontSize: 10, cellPadding: 5 },
                headStyles: { fillColor: [0, 123, 255], textColor: [255, 255, 255] }
            });

            doc.save('Reporte_Ingresos_Mensuales_<%= anio %>.pdf');
        }

        async function downloadExcel() {
            const workbook = XLSX.utils.book_new();

            // Data for "Ingresos por Host" sheet
            const tablaHost = document.getElementById('tablaHost');
            const ws1_data = [];
            tablaHost.querySelectorAll('tr').forEach(row => {
                if (row.style.display !== 'none' || row.querySelector('th')) { // Include header row always
                    ws1_data.push(Array.from(row.children).map(cell => cell.innerText));
                }
            });
            const ws1 = XLSX.utils.aoa_to_sheet(ws1_data);
            XLSX.utils.book_append_sheet(workbook, ws1, "Ingresos por Host");

            // Data for "Ingresos Generales" sheet
            const tablaGeneral = document.getElementById('tablaGeneral');
            const ws2_data = [];
            tablaGeneral.querySelectorAll('tr').forEach(row => {
                ws2_data.push(Array.from(row.children).map(cell => cell.innerText));
            });
            const ws2 = XLSX.utils.aoa_to_sheet(ws2_data);
            XLSX.utils.book_append_sheet(workbook, ws2, "Ingresos Generales");

            XLSX.writeFile(workbook, 'Reporte_Ingresos_Mensuales_<%= anio %>.xlsx');
        }

        async function downloadPdfTablesOnly() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('p', 'pt', 'a4');
            const margin = 40;
            let y = margin;
            const pageWidth = doc.internal.pageSize.getWidth();

            doc.setFontSize(20);
            doc.text(`Reporte de Ingresos Mensuales (Tablas) - <%= anio %>`, pageWidth / 2, y, { align: 'center' });
            y += 30;

            // --- Tabla de detalle por host ---
            doc.setFontSize(16);
            doc.text("Tabla: Ingresos por Host y Alojamiento", margin, y);
            y += 20;

            const tablaHost = document.getElementById('tablaHost');
            const tablaHostData = [];
            const tablaHostHeader = Array.from(tablaHost.querySelectorAll('th')).map(th => th.innerText);
            tablaHostData.push(tablaHostHeader);
            tablaHost.querySelectorAll('tbody tr').forEach(row => {
                if (row.style.display !== 'none') {
                    tablaHostData.push(Array.from(row.querySelectorAll('td')).map(td => td.innerText));
                }
            });

            doc.autoTable({
                startY: y,
                head: [tablaHostData[0]],
                body: tablaHostData.slice(1),
                theme: 'striped',
                margin: { left: margin, right: margin },
                styles: { fontSize: 10, cellPadding: 5 },
                headStyles: { fillColor: [0, 123, 255], textColor: [255, 255, 255] },
                didDrawPage: function(data) {
                    y = data.cursor.y;
                }
            });
            y = doc.autoTable.previous.finalY + 30;

            // --- Tabla de resumen general ---
            doc.setFontSize(16);
            doc.text("Tabla: Ingresos Generales por Mes", margin, y);
            y += 20;

            const tablaGeneral = document.getElementById('tablaGeneral');
            const tablaGeneralData = [];
            const tablaGeneralHeader = Array.from(tablaGeneral.querySelectorAll('th')).map(th => th.innerText);
            tablaGeneralData.push(tablaGeneralHeader);
            tablaGeneral.querySelectorAll('tbody tr').forEach(row => {
                tablaGeneralData.push(Array.from(row.querySelectorAll('td')).map(td => td.innerText));
            });

            doc.autoTable({
                startY: y,
                head: [tablaGeneralData[0]],
                body: tablaGeneralData.slice(1),
                theme: 'striped',
                margin: { left: margin, right: margin },
                styles: { fontSize: 10, cellPadding: 5 },
                headStyles: { fillColor: [0, 123, 255], textColor: [255, 255, 255] }
            });

            doc.save('Reporte_Ingresos_Mensuales_Tablas_<%= anio %>.pdf');
        }
    </script>

    <script src="js/indexAdminsidebarmenu.js?v=<%= System.currentTimeMillis() %>"></script>
    <script src="js/indexAdminapp.min.js"></script>
    <script src="js/indexAdmindashboard.js"></script>
</body>
</html>
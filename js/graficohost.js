function generarGrafico(data) {
    const existingCanvas = document.getElementById('graficoReservas');
    if (existingCanvas) {
        existingCanvas.remove();
    }

    const canvas = document.createElement('canvas');
    canvas.id = 'graficoReservas';
    document.body.appendChild(canvas);

    const ctx = canvas.getContext('2d');

    const labels = data.map(d => d.usuario);       // Eje X con nombres de usuarios
    const valores = data.map(d => d.total);        // Eje Y con totales pagados

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total Pagado por Usuario',
                data: valores,
                fill: false,
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 1)',
                tension: 0.3, // suavizado de línea (0 = línea recta, >0 = curva)
                pointRadius: 6,
                pointHoverRadius: 8,
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Totales Pagados por Usuario (Gráfico de Línea)'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.label + ': S/ ' + context.formattedValue;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Total Pagado (S/.)'
                    },
                    ticks: {
                        callback: function(value) {
                            return 'S/ ' + value;
                        }
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Usuario'
                    }
                }
            }
        }
    });
}

const editarLink = document.querySelectorAll(".edit-link")[0];
const calendario = document.getElementById("calendario");
const rangoFechas = document.getElementById("rango-fechas");

let flatpickerInstancia;

editarLink.addEventListener("click", function (e) {
  e.preventDefault();
  calendario.style.display = "block";

  if (!flatpickerInstancia) {
    flatpickerInstancia = flatpickr(calendario, {
      mode: "range",
      dateFormat: "d/m/Y",
      onClose: function (selectedDates) {
        calendario.style.display = "none";
        if (selectedDates.length === 2) {
          const opciones = { day: 'numeric', month: 'long' };
          const desde = selectedDates[0].toLocaleDateString('es-ES', opciones);
          const hasta = selectedDates[1].toLocaleDateString('es-ES', opciones);
          rangoFechas.textContent = `${desde} – ${hasta}`;
        }
      }
    });
  }

  flatpickerInstancia.open();
});





const menu = document.getElementById('menu');
const menuToggle = document.getElementById('menu-toggle');
const buttonMenu = document.querySelector('.button-menu');

// Evento para abrir/cerrar menú
menuToggle.addEventListener('click', () => {
    menu.classList.toggle('open');
    buttonMenu.classList.toggle('open'); // Cambia animación del botón
});

// Cerrar menú al hacer clic en un enlace
document.querySelectorAll('.menu a').forEach(link => {
    link.addEventListener('click', () => {
        menu.classList.remove('open');
        buttonMenu.classList.remove('open'); // Restablecer botón
    });
});

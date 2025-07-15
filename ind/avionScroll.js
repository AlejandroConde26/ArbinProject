    // avioncitoScroll.js

gsap.registerPlugin(MotionPathPlugin, ScrollTrigger);

/**
 * Inicializa el avioncito animado dentro de un contenedor ACUERDATEE
 * Requisitos en el HTML:
 * - Contenedor con clase `.avion-section`
 * - Dentro, un `.scroll-viaje` que será pineado
 * - Un `<svg>` con:
 *   - ID de ruta: `#avion-path`
 *   - Grupo avión: `.avion`
 * RECUERDA PONER LAS LIBRERIAS QUE SIN ESO NO FUNCA Y MADRUGARAS VIENDO EL BUG
 */
function inicializarAvioncito() {
  const avionPath = document.querySelector("#avion-path");
  const avion = document.querySelector(".avion");
  const trigger = document.querySelector(".scroll-viaje");

  if (!avionPath || !avion || !trigger) {
    console.warn("Elementos del avioncito no encontrados pipip");
    return;
  }

  gsap.to(avion, {
    scrollTrigger: {
      trigger: trigger,
      start: "top top",
      end: "bottom bottom",
      scrub: 1,
      pin: true
    },
    motionPath: {
      path: avionPath,
      align: avionPath,
      autoRotate: true,
      alignOrigin: [0.5, 0.5]
    },
    ease: "none",
    rotation: 10
  });
}

// Ejecutar cuando DOM esté listo
document.addEventListener("DOMContentLoaded", inicializarAvioncito);

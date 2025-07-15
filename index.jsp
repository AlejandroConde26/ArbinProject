<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>соня</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.4/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-DQvkBjpPgn7RC31MCQoOeC9TI2kdqa4+BSgNMNj8v77fdC77Kj5zpWFTJaaAoMbC" crossorigin="anonymous">
    <link rel="stylesheet" href="css/indexReserva.css?v=<%= System.currentTimeMillis() %>"/>
    <link rel="stylesheet" href="ind/indexPRO.css?v=<%= System.currentTimeMillis() %>"/>
    <link rel="stylesheet" href="ind/estilos.css?v=<%= System.currentTimeMillis() %>"/>
    <link rel="stylesheet" href="ind/estiloBotonMagico.css?v=<%= System.currentTimeMillis() %>"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.4/dist/js/bootstrap.bundle.min.js" integrity="sha384-YUe2LzesAfftltw+PEaao2tjU/QATaW/rOitAq67e0CT0Zi2VVRL0oC4+gAaeBKu" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/gsap@3.12.2/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/typeit@8.7.1/dist/index.umd.js"></script>
    <script src="https://unpkg.com/gsap@3/dist/ScrollTrigger.min.js"></script>
    <script src="https://unpkg.com/gsap@3/dist/MotionPathPlugin.min.js"></script>

</head>
<body>
   
    <header class="header-container">
        
        
        
        <video id="headerVideo" autoplay muted loop playsinline preload="auto" class="header-video-bg">
            <source src="videos/capri2.mp4" type="video/webm">
        </video>
        <div class="video-overlay"></div>
        
        
        
        
        <nav class="navbar  py-4 ">
            <div class="container-fluid d-flex align-items-center justify-content-between w-100">
                <div class="container-box-button">
                    <div class="magic-container">
                        <a class="magic-button text-uppercase" href="login.jsp">Empieza la Búsqueda</a>
                        <div id="type-target"></div>
                    </div>
                    <div class="magic-container">
                        <a class="magic-button text-uppercase" href="#">Per</a>
                        <div id="type-target"></div>
                    </div>
                    <div class="magic-container">
                        <a class="magic-button text-uppercase" href="#">En</a>
                        <div id="type-target"></div>
                    </div>
                </div>
                <a class="navbar-brand mx-auto fw-bold text-uppercase text-light" href="index.jsp"> 
                    <img src="images/logo.png" height="110" width="110"> 
                </a>
                <div class="button-menu left-0">
                    <div class="container-button-menu">
                         <button id="menu-toggle">
                            <div></div>
                            <div></div>
                            <div></div>
                         </button>
                    </div>
                </div>    
            </div>
        </nav>
        
        <div class="banner-text-main">
            <div id="fraseX" class="text-uppercase">
                xd
            </div>
        </div>
        
    </header>


 
    <section class="seccion-avion">
        <div class="contenido-central">
          <img
            src="https://a0.muscache.com/im/pictures/airbnb-platform-assets/AirbnbPlatformAssets-GuestFavorite/original/78b7687c-5acf-4ef8-a5ea-eda732ae3b2f.png"
            alt="Ala izquierda"
            class="ala"
          />

          <h2 class="texto-centrado">Reserva en cualquier parte del mundo.</h2>

          <img
            src="https://a0.muscache.com/im/pictures/airbnb-platform-assets/AirbnbPlatformAssets-GuestFavorite/original/78b7687c-5acf-4ef8-a5ea-eda732ae3b2f.png"
            alt="Ala derecha"
            class="ala invertida"
          />
        </div>

        <div class="scroll-viaje">
            <!-- Avión y trayectoria -->
            <svg class="avion-svg" viewBox="-40 -180 1250 1100">
              <path id="avion-path" class="avion-trayectoria"
              d="M -692 -149 c 386.3482 413.7024 808 908 1276 753 c 190 -58 325 -177 231 -373 c -77 -116 -294 -204 -597 -56 C 88 241 -43 423 59 629 c 78 115 433 177 623 -16 C 1022 360 1218 360 1922 845"
              />
              <g class="avion">
                <path opacity="" d="m82.8 35 215.9 94.6L79 92l3.8-57Z" />
                <path d="m82.8 35 52-23.5 163.9 118.1-216-94.5Z" />
                <path opacity="0.1" d="m76.8 107.1 214.4 19.6L74.7 131l2.1-23.9Z" />
                <path d="M298.8 130.4 1.9 103.3l54-45 242.9 72.1Z" />
              </g>
            </svg>
         </div>
     </section>




      <!-- Sección con scroll sincronizado -->
  <section class="section scroll-section">
    <div class="video-wrapper">
      <div class="video-block">
        <video class="fade-video" src="videos/video1.mp4" autoplay muted loop playsinline></video>
        <div class="texto-video" id="frase1"></div>
        
      </div>
      <div class="video-block">
        <video class="fade-video" src="videos/capri2.mp4" autoplay muted loop playsinline></video>
        <div class="texto-video" id="frase2"></div>
      </div>
      <div class="video-block">
        <video class="fade-video" src="videos/video2.mp4" autoplay muted loop playsinline></video>
        <div class="texto-video" id="frase3"></div>
      </div>
    </div>

    <!-- Navegador circular -->
    <div class="nav-circles"></div>
  </section>



    <nav class="menu" id="menu">
        <ul>
            <li><a href="">Alojamiento</a></li>
            <li><a href="">Vuelos</a></li>
            <li><a href="">Alquiler de coches</a></li>
            <li><a href="">Actividades</a></li>
            <div></div>
            <ul class="social-media">
                <li><a href="#"><i class="bi bi-instagram"></i></a></li>
                <li><a href="#"><i class="bi bi-facebook"></i></a></li>
                <li><a href="#"><i class="bi bi-twitter-x"></i></a></li>
            </ul>
        </ul>
    </nav>
    
    <!-- SECCION DE BUSQUEDA -->
    <section>  

    <div class="title-section">
        <h2 class="m-5 text-uppercase text-secondary-emphasis fw-bold">Explora destinos</h2>
    </div>
   <!-- FORMULARIO DE BÚSQUEDA -->
<div class="container mt-5">
  <form action="indexInvitado.jsp" method="get">
    <div class="d-flex align-items-center bg-white rounded-pill shadow-sm px-4 py-2 gap-4">
      
      <!-- CAMPO CIUDAD -->
      <div class="flex-grow-1 border-end pe-3">
        <small class="fw-bold text-muted d-block">Dónde</small>
        <input type="text" name="ciudad" class="form-control border-0 p-0" placeholder="Explora destinos" required>
      </div>

      <!-- Llegada (solo visual, opcional funcionalidad futura) -->
      <div class="flex-grow-1 border-end pe-3">
        <small class="fw-bold text-muted d-block">Llegada</small>
        <input type="date" name="llegada" class="form-control border-0 p-0 text-secondary">
      </div>

      <!-- Salida (solo visual, opcional funcionalidad futura) -->
      <div class="flex-grow-1 border-end pe-3">
        <small class="fw-bold text-muted d-block">Salida</small>
        <input type="date" name="salida" class="form-control border-0 p-0 text-secondary">
      </div>

      <!-- Cuántos (solo visual, opcional funcionalidad futura) -->
      <div class="flex-grow-1">
        <small class="fw-bold text-muted d-block">Quién</small>
        <input type="number" name="personas" class="form-control border-0 p-0 text-secondary" placeholder="¿Cuántos?" min="1">
      </div>

      <!-- BOTÓN DE ENVÍO -->
      <button type="submit" class="btn btn-success rounded-circle d-flex align-items-center justify-content-center" style="width: 44px; height: 44px;">
        <i class="bi bi-search"></i>
      </button>
    </div>
  </form>
</div>

</section>
<section>


</section>
    <!-- SECCION DE TARJETITAS -->
<section class="properties-section w-100 h-auto mt-5">
  <div class="container">
    <div class="row g-3">

      <!-- Card -->
      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-1.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-2.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>
      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-3.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-4.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>
      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-5.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-6.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>
      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-7.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-6">
        <div class="property-card">
          <img src="images/img-houses/img-8.avif" alt="Casa de campo" class="property-card__image" />
          <div class="property-card__badge">🏆 Favorito entre viajeros</div>
          <div class="property-card__heart">♥</div>
          <div class="property-card__dots">
            <div class="property-card__dot active"></div>
            <div class="property-card__dot"></div>
            <div class="property-card__dot"></div>
          </div>
          <div class="p-3 property-card__info">
            <h6 class="mb-1 fw-bold">Provincia de Cañete, Perú <span class="float-end">★ 4.93</span></h6>
            <p class="mb-0 text-muted">A 84 kilómetros de distancia</p>
            <p class="mb-0 text-muted">10–15 de abr</p>
            <p class="property-card__price">S/1,506 <span>por 5 noches</span></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
    
    <!-- IAMGENES QUE SE ACERCAn -->
    <section>
        <div class="container-destinations w-100 h-auto">
            <div class="destinations w-100 h-auto">
                <div class="card-img w-100 h-100">
                    <img src="images/ukraine-img.jpg" alt="Zoom hover effect">
                    <div class="overlay-subtext">Ucrania, Kiev</div>
                    <div class="overlay-text">Cuna de la historia eslava y belleza urbana!</div>
                </div>
                <div class="capa-2-row w-100 h-100 d-flex">
                    <div class="card-img card-longer czech-img w-50">
                        <img src="images/czech-img.jpg" alt="Zoom hover effect">
                        <div class="overlay-subtext">Chequia, Praga</div>
                        <div class="overlay-text">¡La ciudad de las cien torres!</div>
                    </div>
                    <div class="capa-2-col w-50 h-100">
                        <div class="card-img card-h-50 turkey-img w-100">
                            <img src="images/turkey-img.jpg" alt="Zoom hover effect">
                            <div class="overlay-subtext">Turquía, Estambul</div>
                            <div class="overlay-text">¡Cruce de culturas y sabores!</div>
                        </div>
                        <div class="card-img card-h-50 italy-img w-100">
                            <img src="images/italy-img.jpg" alt="Zoom hover effect">
                            <div class="overlay-subtext">Italia, Roma</div>
                            <div class="overlay-text">Historia viva entre ruinas y leyendas</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    

  <!-- FOOTER -->
<footer class="footer bg-black text-light h-100 position-relative overflow-hidden p-5">
  <div class="footer-content">
    <div class="column">
      <p>Asistencia</p>
      <ul>
        <li><a href="" class="text-white-50">Centro de ayuda</a></li>
        <li><a href="" class="text-white-50">AirCover</a></li>
        <li><a href="" class="text-white-50">Antidiscriminación</a></li>
        <li><a href="" class="text-white-50">Apoyo para discapacitados</a></li>
        <li><a href="" class="text-white-50">Opciones de cancelación</a></li>
        <li><a href="" class="text-white-50">Problemas en el vecindario</a></li>
      </ul>
    </div>
    <div class="column">
      <p>Modo anfitrión</p>
      <ul>
        <li><a href="" class="text-white-50">Pon tu espacio en Airbnb</a></li>
        <li><a href="" class="text-white-50">AirCover para anfitriones</a></li>
        <li><a href="" class="text-white-50">Recursos para anfitrionar</a></li>
        <li><a href="" class="text-white-50">Foro comunitario</a></li>
        <li><a href="" class="text-white-50">Anfitriona con responsabilidad</a></li>
        <li><a href="" class="text-white-50">Súmate a una clase gratuita sobre la actividad de los anfitriones</a></li>
        <li><a href="" class="text-white-50">Buscar un coanfitrión</a></li>
      </ul>
    </div>
    <div class="column">
      <p>Cоня</p>
      <ul>
        <li><a href="" class="text-white-50">Sala de prensa</a></li>
        <li><a href="" class="text-white-50">Funciones nuevas</a></li>
        <li><a href="" class="text-white-50">Carreras</a></li>
        <li><a href="" class="text-white-50">Inversionistas</a></li>
        <li><a href="" class="text-white-50">Espacios en соня.org</a></li>
      </ul>
    </div>
    <div class="column"></div>
  </div>
  <div class="all-rights-reserved w-100 d-flex align-items-center justify-content-evenly mt-5">
    © 2025 соня, Inc.
    <ul class="d-flex align-items-center w-50 justify-content-evenly">
      <li>Privacidad</li>
      <li>Términos</li>
      <li>Mapa del sitio</li>
    </ul>
  </div>
  <div class="signature-container">
    <div class="signature">соня</div>
  </div>
</footer>
    <script src="ind/scriptPROP.js"></script>
    <script src="ind/script.js"></script>
    <script src="ind/avionScroll.js"></script>
    <script>
      iniciarVideoScroll({
        selectorScrollSection: ".scroll-section",
        selectorVideoBlock: ".video-block",
        selectorVideo: ".fade-video",
        selectorTexto: ".texto-video",
        selectorNav: ".nav-circles",
        textosMap: {
          frase1: "Explora lugares únicos|y hospedajes inolvidables.",
          frase2: "Reserva fácil|Viaja seguro|Disfruta más",
          frase3: "Reserva tu hospedaje soñado."
          
        },
        imageSources: ["ind/xd.png", "ind/xd.png", "ind/xd.png"]
      });
    </script>
    

</body>
</html>
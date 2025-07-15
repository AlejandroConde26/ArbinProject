
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/login.css?v=<%= System.currentTimeMillis() %>"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    </head>
    <body>     
            <div class="container" id="container">
                 <div class="form-container sign-up-container">
                     <form action="SvUser" method="POST">
                                 <h1>Crear cuenta</h1>
                                 <div class="social-container">
                                         <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                                         <a href="#" class="social"><i class="fab fa-google"></i></a>
                                         <a href="#" class="social"><i class="fab fa-apple"></i></a>
                                 </div>
                                 <span>o utiliza tu correo electrónico para registrarte</span>
                                 <input type="text" placeholder="Nombres" name="full_name"/>
                                 <input type="text" placeholder="Apellidos" name="last_name"/>
                                 <input type="email" placeholder="Email" name="email"/>
                                 <input type="password" placeholder="Contraseña" name="password"/>
                                 <button type="submit">Registrarse</button>
                         </form>
                     

                 </div>
                 <div class="form-container sign-in-container">
                     <form action="SvLogin" method="POST">
                                 <h1>Iniciar Sesión</h1>
                                 <div class="social-container">
                                         <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                                         <a href="#" class="social"><i class="fab fa-google"></i></a>
                                         <a href="#" class="social"><i class="fab fa-apple"></i></a>
                                 </div>
                                 <span>o usa tu cuenta</span>
                                 <input type="email" placeholder="Ingresa tu correo electrónico" name="email" />
                                 <input type="password" placeholder="Ingresa tu contraseña" name="password"/>
                                 <a href="#">¿Olvidaste la contraseña?</a>
                                 <button type="submit">Iniciar Sesión</button>
                         </form>
                 </div>
                 <div class="overlay-container">
                         <div class="overlay">
                                 <div class="overlay-panel overlay-left">
                                         <h1>Bienvenido de nuevo!</h1>
                                         <p>Para mantenerte conectado con nosotros, por favor inicia sesión con tu información personal</p>
                                         <button class="ghost" id="signIn">Inicia Sesión</button>
                                 </div>
                                 <div class="overlay-panel overlay-right">
                                         <h1>Hola Amigo!</h1>
                                         <p>Ingresa tus datos personales y comienza tu viaje con nosotros</p>
                                         <button class="ghost" id="signUp">Registrarse</button>
                                 </div>
                         </div>
                 </div>
         </div>

        <footer>
             <p>
                 Al iniciar sesión o al crear una cuenta, aceptas nuestros 
                 <a href="#">Términos y condiciones</a> y la 
                 <a href="#">Política de privacidad</a>.
                 Todos los derechos reservados.<br>
                 Copyright (2006 - 2025) - соня™
             </p>
        </footer>

         <script src="js/login.js"></script>
    </body>
</html>

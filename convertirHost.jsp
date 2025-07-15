<%@page import="Models.User"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Conviértete en Host</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #0f0f0f;
            color: #e0e0e0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            background-color: #1a1a1a;
            border: 1px solid #2e2e2e;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(255, 255, 255, 0.05);
            max-width: 500px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            margin-bottom: 1rem;
            font-size: 1.9rem;
            letter-spacing: 1px;
        }

        .info {
            font-size: 0.95rem;
            color: #b0b0b0;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .checkbox {
            margin-bottom: 1.5rem;
            text-align: left;
        }

        input[type="checkbox"] {
            accent-color: white;
            transform: scale(1.2);
            margin-right: 0.5rem;
        }

        label {
            font-size: 0.95rem;
        }

        a {
            color: #aaa;
            text-decoration: underline;
        }

        .btn {
            background-color: transparent;
            color: white;
            padding: 0.8rem 1.8rem;
            border: 2px solid white;
            border-radius: 50px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: white;
            color: #0f0f0f;
        }

        .error {
            margin-top: 1rem;
            color: #ff4d4d;
            font-size: 0.9rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.98); }
            to { opacity: 1; transform: scale(1); }
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
    <div class="card">
        <h2>Conviértete en Host</h2>

        <div class="info">
            Estás a punto de dar el siguiente paso y convertirte también en <strong>Host</strong>.<br>
            Esto significa que tu cuenta de usuario podrá crear publicaciones, gestionar propiedades y compartir experiencias increíbles con otros viajeros.<br><br>
            No perderás ninguna funcionalidad como usuario, ¡solo ganarás más posibilidades! 🌟
        </div>

        <form action="SvHost" method="post">
            <div class="checkbox">
                <input type="checkbox" id="aceptoTerminos" name="aceptoTerminos">
                <label for="aceptoTerminos">
                    Acepto los <a href="#">términos y condiciones</a> para convertirme en Host
                </label>
            </div>
            <button class="btn" type="submit">Convertirme en Host</button>
        </form>

        <%
            String error = request.getParameter("error");
            if ("debesAceptar".equals(error)) {
        %>
            <div class="error">Debes aceptar los términos y condiciones para continuar.</div>
        <%
            }
        %>
    </div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.User" %>
<%@ page import="Models.Message" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    List<User> usuarios = (List<User>) request.getAttribute("usuariosConConversacion");
    List<Message> mensajes = (List<Message>) request.getAttribute("conversation");
    User receptor = (User) request.getAttribute("receptor");
    User sessionUser = (User) session.getAttribute("user");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Panel de Mensajes - Host</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            .chat-panel {
                height: 600px;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                overflow: hidden;
                display: flex;
            }
            .chat-users {
                width: 30%;
                background-color: #f1f1f1;
                overflow-y: auto;
                padding: 15px;
            }
            .chat-users a {
                display: block;
                padding: 10px;
                margin-bottom: 10px;
                background: #ffffff;
                border-radius: 6px;
                color: #333;
                text-decoration: none;
                transition: background 0.3s;
            }
            .chat-users a:hover {
                background-color: #dee2e6;
            }
            .chat-conversation {
                width: 70%;
                display: flex;
                flex-direction: column;
                padding: 15px;
                background: #ffffff;
            }
            .chat-messages {
                flex: 1;
                overflow-y: auto;
                margin-bottom: 15px;
            }
            .mensaje {
                max-width: 70%;
                padding: 10px;
                border-radius: 12px;
                margin-bottom: 10px;
            }
            .sent {
                background-color: #cfe2ff;
                margin-left: auto;
            }
            .received {
                background-color: #e2e3e5;
                margin-right: auto;
            }
            .form-chat {
                display: flex;
                gap: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="SvHost" class="btn btn-outline-secondary">
                    ⬅️ Volver
                </a>
                <h2 class="text-primary mb-0">📨 Panel de Chat - Host</h2>
                <div></div> <!-- Elemento vacío para balancear el espacio -->
            </div>
            <div class="chat-panel">
                <!-- Lista de usuarios -->
                <div class="chat-users">
                    <h5 class="text-center">Conversaciones</h5>
                    <% if (usuarios != null && !usuarios.isEmpty()) {
                            for (User u : usuarios) {%>
                    <a href="SvHostChatPanel?idReceptor=<%= u.getId_users()%>">
                        <%= u.getFull_name()%>
                    </a>
                    <%  }
                    } else { %>
                    <p>No hay conversaciones previas.</p>
                    <% } %>
                </div>

                <!-- Conversación -->
                <div class="chat-conversation">
                    <% if (receptor != null && mensajes != null) {%>
                    <h5>Conversación con <%= receptor.getFull_name()%></h5>
                    <div class="chat-messages">
                        <% for (Message m : mensajes) {
                                boolean enviado = m.getSender().getId_users() == sessionUser.getId_users();
                        %>
                        <div class="mensaje <%= enviado ? "sent" : "received"%>">
                            <strong><%= enviado ? "Tú" : receptor.getFull_name()%>:</strong><br>
                            <%= m.getContent()%><br>
                            <small>
                                <%= m.getSentDate() != null ? m.getSentDate().format(formatter) : "Sin fecha"%>
                                <% if (enviado) {%>
                                <%= m.getStatus().toString().equals("READ") ? " ✔✔" : " ✔"%>

                                <!-- Botón de eliminar solo para mensajes enviados -->
                                <form action="SvEliminarMensajeHost" method="post" style="display:inline;">
                                    <input type="hidden" name="messageId" value="<%= m.getId_message()%>">
                                    <input type="hidden" name="idReceptor" value="<%= receptor.getId_users()%>">
                                    <button type="submit" class="btn btn-sm btn-link text-danger p-0" title="Eliminar mensaje">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                                <% } %>
                            </small>
                        </div>
                        <% }%>
                    </div>

                    <!-- Formulario para enviar mensaje -->
                    <form action="SvSendMessageHost" method="post" class="form-chat">
                        <input type="hidden" name="idReceptor" value="<%= receptor.getId_users()%>">
                        <input type="text" name="content" class="form-control" placeholder="Escribe un mensaje..." required>
                        <button type="submit" class="btn btn-primary">Enviar</button>
                    </form>
                    <% } else { %>
                    <div class="d-flex align-items-center justify-content-center flex-grow-1">
                        <p class="text-muted">Selecciona una conversación para comenzar.</p>
                    </div>
                    <% }%>
                </div>

            </div>
        </div>
    </body>
</html>



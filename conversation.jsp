<%@page import="Models.Message"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Message" %>
<%@ page import="Models.User" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<Message> mensajes = (List<Message>) request.getAttribute("conversation");
    User receptor = (User) request.getAttribute("receptor");
    User sessionUser = (User) session.getAttribute("user");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String housingId = request.getParameter("housingId");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chat</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f0f2f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .chat-box {
                max-width: 850px;
                margin: 50px auto;
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                overflow: hidden;
                display: flex;
                flex-direction: column;
                height: 80vh;
            }

            .chat-header {
                padding: 20px;
                background-color: #007bff;
                color: #fff;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .chat-body {
                padding: 20px;
                flex: 1;
                overflow-y: auto;
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .message {
                max-width: 70%;
                padding: 12px 18px;
                border-radius: 20px;
                position: relative;
                line-height: 1.4;
                font-size: 15px;
            }

            .sent {
                align-self: flex-end;
                background-color: #d1e7dd;
                color: #0f5132;
            }

            .received {
                align-self: flex-start;
                background-color: #e2e3e5;
                color: #41464b;
            }

            .timestamp {
                display: block;
                font-size: 0.75rem;
                color: #6c757d;
                margin-top: 5px;
            }

            .chat-footer {
                padding: 15px 20px;
                border-top: 1px solid #dee2e6;
                background-color: #f8f9fa;
            }

            .chat-footer .form-control {
                border-radius: 20px;
            }

            .chat-footer .btn {
                border-radius: 20px;
                padding: 6px 20px;
            }

        </style>
    </head>
    <body>
        <div class="chat-box">
            <div class="chat-header">
                <h4 class="mb-0">Chat con <%= receptor.getFull_name()%></h4>
                <% if (housingId != null || housingId != "null") {%>
                <a href="infoRoom.jsp?housingId=<%= housingId%>" class="btn btn-light btn-sm"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-left" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0z"/>
                    <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708z"/>
                    </svg></a>
                    <% } else { %>
                <a href="SvCargarHousings" class="btn btn-secondary btn-sm"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-left" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0z"/>
                    <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708z"/>
                    </svg></a>
                    <% }%>

            </div>

            <div class="chat-body" id="chatBody">
                <% for (Message m : mensajes) {
                        boolean enviado = m.getSender().getId_users() == sessionUser.getId_users();
                %>
                <div class="message <%= enviado ? "sent" : "received"%>">
                    <strong><%= enviado ? "Tú" : receptor.getFull_name()%>:</strong><br>
                    <%= m.getContent()%>
                    <%
                        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                    %>
                    <span class="timestamp">
                        <% if (enviado) {%>
                        <form action="SvDeleteMessage" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar este mensaje?');">
                            <input type="hidden" name="messageId" value="<%= m.getId_message()%>">
                            <input type="hidden" name="idReceptor" value="<%= receptor.getId_users()%>">
                            <input type="hidden" name="housingId" value="<%= housingId%>">
                            <button type="submit" class="btn btn-link btn-sm p-0 m-0" title="Eliminar mensaje">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </form>
                        <% }%>
                        <%= m.getSentDate() != null ? m.getSentDate().format(formatter) : "Sin fecha"%>
                        <% if (enviado) {%>
                        <%= m.getStatus().toString().equals("READ") ? " ✔✔" : " ✔"%>
                        <% } %>
                    </span>
                </div>
                <% }%>
            </div>

            <div class="chat-footer">
                <form action="SvSendMessage" method="post" class="d-flex">
                    <input type="hidden" name="idReceptor" value="<%= receptor.getId_users()%>">
                    <input type="hidden" name="housingId" value="<%= housingId%>">
                    <input type="text" name="content" class="form-control me-2" placeholder="Escribe tu mensaje..." required>
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </div>
        </div>
        <script>
            // Auto scroll al final del chat
            const chatBody = document.getElementById("chatBody");
            chatBody.scrollTop = chatBody.scrollHeight;
        </script>
    </body>
</html>

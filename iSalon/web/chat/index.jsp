<%-- 
    Document   : index
    Created on : 17-may-2018, 20:53:12
    Author     : A
--%>

<%@page import="ctrl.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Validacion de usuario
    Usuario user = new Usuario(-1);
    if (session.getAttribute("user") == null) {
        request.setAttribute("preset", "login");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
        dispatcher.forward(request, response);
        return;
    } else {
        user = new Usuario((Integer) session.getAttribute("user"));
        user.validarUsuarioId();

        if (!user.isValid()) {
           request.setAttribute("preset", "login");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
        dispatcher.forward(request, response);
        return;
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Chat</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="/iSalon/js/WebSocket.js" type="text/javascript"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../Materialize/materialize.js" type="text/javascript"></script>
        <link href="../Materialize/materialize.css" rel="stylesheet" type="text/css"/>
        
        <style>
            #chatContent {
                overflow-y: auto;
                height: 95vh;
            }
        </style>
        <script>
            webSocket.webSocketName = "chat";
            webSocket.webSocketPath = "iSalon/WebSockets";
            webSocket.onMessage = function(msg) {
                var messDiv = document.createElement("div");
                messDiv.innerHTML = msg.data;
                $(messDiv).addClass("section");
                
                $("#chatContent").append(messDiv);
                $("#chatContent").get()[0].scrollTop = $("#chatContent").get()[0].scrollHeight;
            };
            
            function clearMessages() {
                $("#chatContent").html("");
            }
            
            $(document).ready(function() {
                
                $("#txtMessage").keypress(function(ev) {
                    if(ev.which === 13) {
                        ev.preventDefault();
                        var data = {
                            name: $("#name").val(),
                            message: $("#txtMessage").val()
                        };
                        
                        $("#txtMessage").val("");
                        $("#txtMessage").resize();

                        webSocket.send(JSON.stringify(data));
                    }
                });
                $("#btnClear").click(function() {
                    clearMessages(); 
                });
                
                webSocket.connect();
            });
        </script>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="section col s6" id="chatContent"></div>
                
                <div class="section col s6" id="chatControls">
                    <h4>Chat - <%=user.getNombre()%></h4>
                    <div class="input-field">
                        <i class="material-icons prefix">mode_edit</i>
                        <textarea id="txtMessage" class="materialize-textarea"></textarea>
                        <label>Mensaje</label>
                    </div>
                    <br>
                    <input class="btn" value="Enviar" type="button"/>

                    <div class="section">
                        <input type="button" id="btnClear" class="btn" value="Limpiar mensajes" />
                    </div>
                    <input id="name" type="hidden" value="<%=user.getNombre()%>">
                </div>
            </div>
        </div>
    </body>
</html>

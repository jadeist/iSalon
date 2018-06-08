<%-- 
    Document   : agregarDatos
    Created on : 11/05/2018, 05:05:41 PM
    Author     : A
--%>

<%@page import="ctrl.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Validacion de usuario
    Usuario user = new Usuario(-1);
    if (session.getAttribute("user") == null) {
        request.setAttribute("title", "Sesión no iniciada");
        request.setAttribute("message", "Iniciar sesión para continuar...");
        request.setAttribute("redirect", ".");
        request.setAttribute("type", "error");

        response.sendRedirect("/iSalon/error.jsp");
        return;
    } else {
        user = new Usuario((Integer) session.getAttribute("user"));
        user.validarUsuarioId();

        if ( !(user.isValid() && user.getTipo() == 3) ) {
            request.setAttribute("preset", "adminRights");

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
        <title>iSalon - Agregar Salon</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../../Materialize/materialize.js" type="text/javascript"></script>
        <link href="../../Materialize/materialize.css" rel="stylesheet" type="text/css"/>
        
    </head>
    <body>
        <div class="container">
            <h4>Agregar Salón</h4>
            <br><br>
            <form id="formAddGrp" method="post" action="agregar" autocomplete="off">

                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <i class="material-icons prefix">group_work</i>
                        <label for="name">Nombre del Salón</label>
                        <input id="txtGrpName" type="text" name="name"/>
                        <span class="helper-text"></span>
                    </div>
                </div>

                <div class="divider"></div>
                <button class="btn" type="submit" >
                    <i class="material-icons left">add_circle</i>
                    Agregar Salón
                </button>
            </form>
            <br>
            <a href="." class="btn-small waves-effect" >Regresar</a>
            <br><br>
        </div>
    </body>
</html>
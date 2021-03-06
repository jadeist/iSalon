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
        <title>iSalon - Agregar Grupo</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../../Materialize/materialize.js" type="text/javascript"></script>
        <link href="../../Materialize/materialize.css" rel="stylesheet" type="text/css"/>

        <script>
            $(document).ready(function () {
                $('#frmAddGrp').submit(function(ev) {
                    if(!$(self).val().match(/[1-6].[MV][1-9]/gi)) {
                        ev.preventDefault();
                    }
                });
                
                $('#txtGrpName').keyup(function(ev) {
                    var self = ev.target;
                    if($(self).val().match(/[1-6].[MV][1-9]/gi)) {
                        $(self).removeClass("invalid");
                        $(self).addClass("valid");
                    } else {
                        $(self).removeClass("valid");
                        $(self).addClass("invalid");
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <h4>Agregar Grupo</h4>
            <br><br>
            <form id="formAddGrp" method="post" action="agregar" autocomplete="off">

                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <i class="material-icons prefix">group_work</i>
                        <label for="name">Nombre de Grupo</label>
                        <input id="txtGrpName" type="text" name="name"/>
                        <span class="helper-text"
                            data-error="El nombre de grupo tendrá que ser: Periodo(1-6), I, Turno (M o V), Numero de Grupo(1 - 9) [E.g. 1IM1, 3IM4, 4IV5]"
                            data-success="Nombre válido"
                        ></span>
                    </div>
                </div>

                <div class="divider"></div>
                <button class="btn" type="submit" >
                    <i class="material-icons left">add_circle</i>
                    Agregar Grupo
                </button>

            </form>
            <br>
            <a href="." class="btn-small waves-effect" >Regresar</a>
            <br><br>
        </div>
    </body>
</html>
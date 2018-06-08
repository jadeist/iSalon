<%-- 
    Document   : agregarDatos
    Created on : 11/05/2018, 05:05:41 PM
    Author     : A
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.cDatos"%>
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
        <title>iSalon - Agregar Usuario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../../Materialize/materialize.js" type="text/javascript"></script>
        <link href="../../Materialize/materialize.css" rel="stylesheet" type="text/css"/>

        <script>
            $(document).ready(function () {
                // Initialization
                $('select').formSelect();
                
                $("form#formAddUser").submit(function (ev) {
                    if ($("input#pass1").val() !== $("input#pass2").val()) {
                        ev.preventDefault();
                    }
                });

                $("input#pass1").keyup((ev) => {
                    if ($(ev.target).val() !== "") {
                        $("input#pass2").prop("disabled", false);
                    } else {
                        $("input#pass2").prop("disabled", true);
                    }
                });
                $("input#pass2").keyup(() => {
                    if ($("input#pass1").val() === $("input#pass2").val()) {
                        $("input#pass2").removeClass("invalid");
                        $("input#pass2").addClass("valid");
                    } else {
                        $("input#pass2").removeClass("valid");
                        $("input#pass2").addClass("invalid");
                    }
                });
                $("input#pass1, input#pass2").blur(() => {
                    if ($("input#pass1").val() === $("input#pass2").val()) {
                        $("input#pass2").removeClass("invalid");
                        $("input#pass2").addClass("valid");
                    } else {
                        $("input#pass2").removeClass("valid");
                        $("input#pass2").addClass("invalid");
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <h4>Agregar Usuario</h4>
            <br><br>
            <form id="formAddUser" method="post" action="agregar">

                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <i class="material-icons prefix">account_circle</i>
                        <label for="username">Nombre de Usuario</label>
                        <input id="username" type="text" name="username" required />
                    </div>
                    <div class="input-field">
                        <i class="material-icons prefix">face</i>
                        <label for="name">Nombre</label>
                        <input id="name" type="text" name="name" required />
                    </div>
                </div>
                
                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <select name="type" required >
                            <%
                                cDatos db = new cDatos();
                                ResultSet res;
                                
                                db.conectar();
                                res = db.consulta("select * from tipoUsuario order by id asc");
                                
                                while(res.next()) {
                                    out.println("<option value='" + String.valueOf(res.getInt("id")) + "'>"
                                        + res.getString("nombre")
                                        + "</option>");
                                }
                            %>
                        </select>
                        <label>Selecciona el Tipo de Usuario</label>
                    </div>
                </div>
                        
                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <select name="grupo" required >
                            <option selected disabled value="-1">Selecciona un grupo</option>
                            <%
                                res = db.consulta("select * from grupos;");
                                while(res.next()) {
                                    out.println("<option value='" + String.valueOf(res.getInt("id")) + "'>"
                                        + res.getString("nombre")
                                        + "</option>");
                                }
                                
                                db.cierraConexion();
                            %>
                        </select>
                        <label>Selecciona el Grupo</label>
                    </div>
                </div>

                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <i class="material-icons prefix">vpn_key</i>
                        <input type="password" id="pass1" required />
                        <label for="pass1">Nueva Contraseña</label>
                    </div>
                    <div class="input-field">
                        <i class="material-icons prefix">done</i>
                        <input class="validate" type="password" id="pass2" disabled name="pass" required />
                        <label for="pass2">Confirma tu contraseña</label>
                        <span class="helper-text"
                            data-error="Las contraseñas deben coincidir"
                            data-success="Las contraseñas coinciden"
                        ></span>
                    </div>
                </div>

                <div class="divider"></div>
                <button class="btn" type="submit" >
                    <i class="material-icons left">add_circle</i>
                    Agregar Usuario
                </button>

            </form>
            <br>
            <a href="." class="btn-small waves-effect" >Regresar</a>
            <br><br>
        </div>
    </body>
</html>
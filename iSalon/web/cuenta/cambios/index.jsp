<%-- 
    Document   : index
    Created on : 11/05/2018, 03:29:28 PM
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
        <title>iSalon - Modificar Cuenta</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Sweet Alert-->
        <link href="../../swal/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <script src="../../swal/sweetalert2.js" type="text/javascript"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../../Materialize/materialize.js" type="text/javascript"></script>
        <link href="../../Materialize/materialize.css" rel="stylesheet" type="text/css"/>
        

        <script>
            $(document).ready(function () {

                $("form#frmData").submit(function (ev) {
                    ev.preventDefault();
                    if (($("input#pass1").val() !== $("input#pass2").val()) && $("input#switchPassword").is(":checked")) {
                        return;
                    }

                    var data = {
                        name: $("input#name").val(),
                        username: $("input#username").val()
                    };

                    if ($("input#switchPassword").is(":checked")) {
                        data.pass = $("input#pass2").val();
                    }

                    $.post('aplicarCambios', data, function (result) {
                        console.log(result);
                        result = JSON.parse(result);

                        swal({
                            title: result.message,
                            type: result.type
                        });
                    });
                });

                $("input#switchPassword").change(function (ev) {
                    if (ev.target.checked) {
                        $("div#divPass").show(500);
                    } else {
                        $("div#divPass").hide(300);
                        $("input#pass2").prop("disabled", true);
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
            <h2>Modificar Cuenta</h2>

            <form id="frmData" method="get" action="#">
                <div class="input-field">
                    <i class="material-icons prefix">account_circle</i>
                    <label for="username">Nombre de Usuario</label>
                    <input id="username" type="text" value="<%=user.getUsername()%>" />
                </div>
                <div class="input-field">
                    <i class="material-icons prefix">face</i>
                    <label for="name">Nombre</label>
                    <input id="name" type="text" value="<%=user.getNombre()%>" />
                </div>

                <div class="divider"></div>
                <h5>Cambiar contraseña?</h5>
                <div class="switch">
                    <label>
                        No
                        <input id="switchPassword" type="checkbox">
                        <span class="lever"></span>
                        Si
                    </label>
                </div>

                <div id="divPass" hidden class="card-panel hoverable transparent">
                    <div class="input-field">
                        <i class="material-icons prefix">vpn_key</i>
                        <input type="password" id="pass1" />
                        <label for="pass1">Nueva Contraseña</label>
                    </div>
                    <div class="input-field">
                        <i class="material-icons prefix">done</i>
                        <input class="validate" type="password" id="pass2" disabled />
                        <label for="pass2">Confirma tu contraseña</label>
                        <span class="helper-text"
                            data-error="Las contraseñas deben coincidir"
                            data-success="Las contraseñas coinciden"></span>
                    </div>
                </div>

                <br><br>
                <input class="btn" type="submit" value="Cambiar datos"/>
            </form>
        </div>
    </body>
</html>
<%-- 
    Document   : agregarDatos
    Created on : 11/05/2018, 05:05:41 PM
    Author     : A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Agregar Usuario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="../../swal/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <link href="../../css/menu.css" rel="stylesheet" type="text/css"/>
        <link href="../../css/materialize.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="../../swal/sweetalert2.js" type="text/javascript"></script>
        <script src="../../js/materialize.min.js" type="text/javascript"></script>

        <script>
            $(document).ready(function () {
                // Initialization
                $('select').material_select();
                
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
                        <input id="username" type="text" name="username" />
                    </div>
                    <div class="input-field">
                        <i class="material-icons prefix">face</i>
                        <label for="name">Nombre</label>
                        <input id="name" type="text" name="name" />
                    </div>
                </div>
                
                <div class="divider"></div>
                <div class="section">
                    <div class="input-field">
                        <select name="type">
                            <%
                                String[] tipos = new String[] {
                                    "Alumno",
                                    "Profesor",
                                    "Prefecto",
                                    "Adminstrador"
                                };

                                int n = tipos.length;
                                for(int i=0; i<n; ++i) {
                                    out.println("<option value='" + i + "'>"
                                        + tipos[i]
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
                        <i class="material-icons prefix">vpn_key</i>
                        <input type="password" id="pass1" />
                        <label for="pass1">Nueva Contraseña</label>
                    </div>
                    <div class="input-field">
                        <i class="material-icons prefix">done</i>
                        <input class="validate" type="password" id="pass2" disabled name="pass" />
                        <label for="pass2"
                               data-error="Las contraseñas deben coincidir"
                               data-success="Las contraseñas coinciden">
                            Confirma tu contraseña
                        </label>
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
        </div>
    </body>
</html>
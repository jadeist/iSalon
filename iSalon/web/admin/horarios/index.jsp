<%-- 
    Document   : index
    Created on : 4/06/2018, 09:58:56 AM
    Author     : DRA ELIA PALACIOS
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
        <title>Horarios</title>
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
            $(document).ready(function() {
                // Initialization
                $('select').formSelect();
                
                var turnos = "";
                var periodos = "";
                
                $("#selTurno").change(function(ev) {
                    var aux = $(ev.target).val();
                    turnos = "";
                    
                    for(i in aux) {
                        turnos += aux[i];
                    }
                    
                    if(aux.length !== 0) {
                        $("#selPeriodo").prop("disabled", false);
                        $('#selPeriodo').formSelect();
                        updateTable();
                    }
                });
                $("#selPeriodo").change(function(ev) {
                    periodos = "";
                    var aux = $(ev.target).val();
                    
                    for(i in aux) {
                        periodos += aux[i];
                    }
                    
                    updateTable();
                });
                
                function updateTable() {
                    if(turnos === '' || periodos === '') {
                        return;
                    }
                    var data = turnos + "||" + periodos;

                    console.log(data);

                    $.post('getTable', {request: data}, function(data, status) {
                        $("#tableHorarios").html(data);
                    });

                }
            });
        </script>
    </head>
    <body>
        <div class="container">
            <div class="section">
                <h3>Filtros</h3>
                <br>
                <div class="input-field">
                    <select multiple id="selTurno">
                        <option selected disabled>Selecciona turno</option>
                        <option value="M">Matutino</option>
                        <option value="V">Vespertino</option>
                    </select>
                    <label>Selecciona turno</label>
                </div>
                <div class="input-field">
                    <select multiple id="selPeriodo" disabled>
                        <option selected disabled>Selecciona periodo</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                    </select>
                    <label>Selecciona periodo</label>
                </div>
            </div>
            
            <div class="divider"></div>
            <div class="section">
                <table>
                    <thead>
                        <tr>
                            <td>Grupo</td>
                            <td>Materia</td>
                            <td>Hora Inicio</td>
                            <td>Hora Final</td>
                            <td>Dia</td>
                        </tr>
                    </thead>
                    <tbody id="tableHorarios"></tbody>
                </table>
            </div>
            
            <div class="fixed-action-btn">
                <a href="agregarDatos.jsp" class="btn-floating btn-large waves-effect waves-light blue" >
                    <i class="material-icons">add</i>
                </a>
            </div>
        </div>
    </body>
</html>
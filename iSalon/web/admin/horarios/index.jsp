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
        <!--Table Sorter-->
        <link href="../../css/theme.materialize.min.css" rel="stylesheet" type="text/css"/>
        <script src="../../js/jquery.tablesorter.combined.js" type="text/javascript"></script>
        
        <script>
            $(document).ready(function() {
                // Initialization
                $('select').formSelect();
                $('table').tablesorter();
                /*
                    {
                        theme: 'materialize',
                        widthFixed: true,
                        widgets: [ "filter", "zebra" ],
                        widgetOptions: {
                            zebra: [ "even", "odd" ],
                            filter_reset: 'filterReset'
                    }
                }
                */
                
                var turnos = "";
                var periodos = "";
                var requestTimer;
                var timeoutTime = 5000;
                
                $("#selTurno").change(function(ev) {
                    var aux = $(ev.target).val();
                    turnos = "";
                    
                    for(i in aux) {
                        turnos += aux[i];
                    }
                    
                    if(aux.length !== 0) {
                        $("#selPeriodo").prop("disabled", false);
                        $('#selPeriodo').formSelect();
                        updateTable(false);
                    }
                });
                $("#selPeriodo").change(function(ev) {
                    periodos = "";
                    var aux = $(ev.target).val();
                    
                    for(i in aux) {
                        periodos += aux[i];
                    }
                    
                    updateTable(false);
                });
                $("#btnGetData").click(function() {
                    updateTable(true);
                });
                
                $(document).on('click', '.btnDel', function(ev) {
                    var source = ev.target;
                    var name = $(source).parent().parent().children(".fieldName").text();
                    var grp = $(source).parent().parent().children(".fieldGroup").text();
                    var hi = $(source).parent().parent().children(".fieldHi").text();
                    var hf = $(source).parent().parent().children(".fieldHf").text();
                    var salon = $(source).parent().parent().children(".fieldSalon").text();
                    var message = 'Seguro de que quieres eliminar a: ' + name + ' (' + grp + '), [' + hi + ' - ' + hf + '], en ' + salon + '?';
                    
                    swal({
                        title: "Advertencia",
                        text: message,
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Si',
                        cancelButtonText: 'No',
                        reverseButtons: true
                    }).then((result) => {
                        if(result) {
                            console.log("Eliminación!");
                            
                            var data = {
                                id: $(source).parent().children(".hidId").val()
                            };
                            $.post('eliminarHorario', data, function(data) {
                                data = JSON.parse(data);
                                
                                swal({
                                    title: data.message,
                                    text: '',
                                    type: (data.isValid ? 'success' : 'error')
                                });
                                
                                if (data.isValid) {
                                    $(source).parent().parent().remove();
                                }
                            });
                        }
                    });
                });
                
                function updateTable(immediate) {
                    if(turnos === '' || periodos === '') {
                        return;
                    }
                    var data = turnos + "||" + periodos;
                    
                    if(!immediate) {
                        clearTimeout(requestTimer);
                        requestTimer = setTimeout(function() {
                            console.log("requesting...");
                            $.post('getTable', {request: data}, function(data, status) {
                                $("#tableHorarios").html(data);
                                $('table').tablesorter();
                            });
                        }, timeoutTime);
                    } else {
                        clearTimeout(requestTimer);
                        $.post('getTable', {request: data}, function(data, status) {
                            $("#tableHorarios").html(data);
                            $('table').tablesorter();
                        });
                    }
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
                <div class="row">
                    <a id="btnGetData" class="btn waves-effect waves-block col s4 offset-s8" >Obtener datos</a>
                </div>
            </div>
            
            <div class="divider"></div>
            <div class="section">
                <div class="row">
                    <a class="filterReset btn waves-effect waves-block col s3 hide" >Reiniciar filtros</a>
                </div>
                <table class="striped responsive-table">
                    <thead>
                        <tr class="row section">
                            <td class="col s2" >Grupo</td>
                            <td class="col s2" >Materia</td>
                            <td class="col s2" >Salón</td>
                            <td class="col s1" >Hora Inicio</td>
                            <td class="col s1" >Hora Final</td>
                            <td class="col s2" >Dia</td>
                            <td class="col s2" >Acciones</td>
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
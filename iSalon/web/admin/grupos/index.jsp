<%-- 
    Document   : index
    Created on : 11/05/2018, 02:13:12 PM
    Author     : A
--%>

<%@page import="database.cDatos"%>
<%@page import="java.sql.ResultSet"%>
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
    
    cDatos db = new cDatos();
    db.conectar();
    
    ResultSet res = db.consulta("select * from grupos order by nombre asc");
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Grupos</title>
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
                
                $("a.btnDel").click(function(ev) {
                    var source = ev.target;
                    var name = $(source).parent().parent().children(".fieldName").text();
                    
                    swal({
                        title: "Advertencia",
                        text: "Seguro de que quieres eliminar a " + name,
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
                            $.post('eliminarGrupo', data, function(data) {
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
                
                $("select#selType").change(function() {
                    $("select#selType option").each(function() {
                        if($(this).is(":selected")) {
                            $("tr.field:contains('" + $(this).text() + "')").show();
                        } else {
                            $("tr.field:contains('" + $(this).text() + "')").hide();
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <h2>Grupos</h2>

            <table class="highlight">
                <thead>
                    <tr>
                        <td>Nombre de Grupo</td>
                    </tr>
                </thead>
                <%
                    while(res.next()) {
                        out.println("<tr class='field'>");
                        out.println("<td class='fieldName'>");
                        out.println(res.getString("nombre"));
                        out.println("</td>");
                        out.println("<td>");
                        out.println("<input class='hidId' type='hidden' value='" + res.getInt("id") + "' />");
                        out.println("<a class='waves-effect waves-light btn btnDel red darken-2' >Eliminar</a>");
                        out.println("</td>");
                        out.println("</tr>");
                    }

                    db.cierraConexion();
                %>
            </table>
            <br><br><br>
            
            <div class="fixed-action-btn">
                <a href="agregarGrupo.jsp" class="btn-floating btn-large waves-effect waves-light blue" >
                    <i class="material-icons">group_add</i>
                </a>
            </div>
        </div>
    </body>
</html>
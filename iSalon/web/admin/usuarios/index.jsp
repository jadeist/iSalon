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
    
    String[] tipos = new String[] {
        "Alumno",
        "Profesor",
        "Prefecto",
        "Adminstrador"
    };
    String[] iconTipo = new String[] {
        "create",
        "book",
        "assignment",
        "star_border"
    };
    
    cDatos db = new cDatos();
    db.conectar();
    
    ResultSet res = db.consulta("select * from usuarios order by tipo asc");
    
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Usuarios</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="../../swal/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <link href="../../css/materialize.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="../../js/materialize.min.js" type="text/javascript"></script>
        <script src="../../swal/sweetalert2.js" type="text/javascript"></script>
        
        <script>
            $(document).ready(function() {
                // Initialization
                $('select').material_select();
                
                
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
                            $.post('eliminarUsuario', data, function(data) {
                                data = JSON.parse(data);
                                
                                swal({
                                    title: data.message,
                                    text: '',
                                    type: (data.isValid ? 'success' : 'error')
                                });
                                
                                $(source).parent().parent().remove();
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
            <h2>Usuarios</h2>

            <div class="section">
                <div class="input-field">
                    <select multiple id="selType">
                        <%  
                            int n = tipos.length;
                            for(int i=0; i<n; ++i) {
                                out.println("<option selected value='" + i + "'>"
                                        + tipos[i]
                                        + "<i class='material-icons prefix'>"
                                        + "</i>"
                                        + "</option>");
                            }
                        %>
                    </select>
                    <label>Selecciona los tipos de usuario a desplegar: </label>
                </div>
            </div>
            
            <table class="highlight">
                <thead>
                    <tr>
                        <td>Nombre</td>
                        <td>Tipo de usuario</td>
                        <td>Acciones</td>
                    </tr>
                </thead>
                <%
                    while(res.next()) {
                        out.println("<tr class='field'>");
                        out.println("<td class='fieldName'>");
                        out.println(res.getString("name"));
                        out.println("</td>");
                        out.println("<td class='fieldType'>");
                        out.println(tipos[res.getInt("tipo")]);
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
            <br><br>
            <a href="agregarDatos.jsp" class="btn-floating btn-large waves-effect waves-light blue" >
                <i class="material-icons">person_add</i>
            </a>
            <br><br><br>
            <div class="divider"></div>
        </div>
    </body>
</html>
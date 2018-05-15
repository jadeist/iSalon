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
            request.setAttribute("title", "No eres administrador");
            request.setAttribute("message", "Es necesario ser administrador para accesar!");
            request.setAttribute("redirect", ".");
            request.setAttribute("type", "error");

            response.sendRedirect("/iSalon/error.jsp");
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
    
    ResultSet res = db.consulta("select * from usuarios");
    
    
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
                
                
                $("input.btnDel").click(function(ev) {
                    var source = ev.target;
                    var name = $(source).parent().parent().children("fieldName").text();
                    
                    swal({
                        title: "Advertencia",
                        text: "Seguro de que quieres eliminar a " + name,
                        type: "warning",
                        reverseButtons: true
                    }).then((result) => {
                        if(result.value) {
                            console.log("Eliminación!");
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
                                        + iconTipo[i]
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
                        out.println("<input class='btn-small waves-effect waves-light red darken-3 btnDel' type='button' value='Eliminar' />");
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
        </div>
    </body>
</html>
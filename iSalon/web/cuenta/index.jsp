<%-- 
    Document   : index
    Created on : 11/05/2018, 11:48:14 AM
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

        if (!user.isValid()) {
           request.setAttribute("preset", "login");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
        dispatcher.forward(request, response);
        return;
        }
    }

    ResultSet res;
    cDatos db = new cDatos();

    db.conectar();
    
    db.setPreparedStatement("select menuContent.name, menuContent.link, menuContent.target, menuContent.icon from catMenuContent "
	+ "inner join menuContent on catMenuContent.idMenu = menuContent.id "
	+ "where catMenuContent.typeUsr = ? "
        + "order by menuContent.priority desc");
    db.setPreparedVariables(new String[][] {
        {"int", String.valueOf(user.getTipo())}
    });
    res = db.runPreparedQuery();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Inicio</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="../css/general.css" rel="stylesheet" type="text/css"/>
        <link href="../css/menu.css" rel="stylesheet" type="text/css"/>
        <link href="../css/materialize.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="../js/materialize.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="wrapper">
            <nav>
                <div class="nav-wrapper">
                    <a href="#" class="brand-logo">iSalon</a>

                    <ul id="nav-mobile" class="right">
                        <%
                            while (res.next()) {
                                out.println("<li class='waves-effect'>"
                                        + "<a href='/iSalon/" + res.getString("link") + "'"
                                        + " target='" + res.getString("target") + "'>"
                                        + "<i class='material-icons left'>" + res.getString("icon") + "</i>"
                                        + res.getString("name")
                                        + "</a>"
                                    + "</li>");
                            }

                            db.cierraConexion();
                        %>
                    </ul>
                </div>
            </nav>
            
            <br><br>
            <iframe name="content" class="frameCuenta" src="inicio.jsp"></iframe>
        </div>
    </body>
</html>

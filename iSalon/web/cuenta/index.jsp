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
    String links = "";
    String whiteText = "";

    db.conectar();
    db.setPreparedStatement("select menuContent.name, menuContent.link, menuContent.target, menuContent.icon from catMenuContent "
            + "inner join menuContent on catMenuContent.idMenu = menuContent.id "
            + "where catMenuContent.typeUsr = ? "
            + "order by menuContent.priority desc");
    db.setPreparedVariables(new String[][]{
        {"int", String.valueOf(user.getTipo())}
    });
    res = db.runPreparedQuery();

    String[] tipos = new String[]{
        "Alumno",
        "Profesor",
        "Prefecto",
        "Adminstrador"
    };
    String[] imgUsuarios = new String[]{
        "student.jpg",
        "teacher.bmp",
        "prefect.jpg",
        "admin.jpg"
    };
    
    while (res.next()) {
        links += "<li class='waves-effect'>";
        links += "<a href='/iSalon/" + res.getString("link") + "'";
        links += " target='" + res.getString("target") + "'";
        links += "class='sidenav-close'";
        links += "name='" + res.getString("name") + "'>";
        links += "<i class='material-icons left'>" + res.getString("icon") + "</i>";
        links += res.getString("name");
        links += "</a>";
        links += "</li>";
    }
    
    db.cierraConexion();
    
    whiteText = (user.getTipo() != 0 && user.getTipo() != 2) ? "white-text" : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Inicio</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../css/Background.css" rel="stylesheet" type="text/css"/>
        <link href="../css/menu.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="../Materialize/materialize.js" type="text/javascript"></script>
        <link href="../Materialize/materialize.css" rel="stylesheet" type="text/css"/>

        <script>
            function inIframe() {
                try {
                    return window.self !== window.top;
                } catch (e) {
                    return true;
                }
            }

            if (inIframe()) {
                console.log();
                window.location.href = $("#frameContent").get()[0].contentWindow.location.href;
            }

            $(document).ready(function () {
                $(".sidenav").sidenav();
                
                $("a").click(function(ev) {
                    
                    if(typeof $(ev.target).attr('name') !== 'undefined') {
                        $("title").html("iSalon - " + $(ev.target).attr('name'));
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="wrapper">
            <nav class="nav-extended">
                <div class="nav-wrapper">
                    <div class="nav-content hide-on-med-and-down">
                        <h5>iSalon - <%=user.getNombre()%>, <%=tipos[user.getTipo()]%></h5>
                    </div>
                    <a href="#" data-target="mobile-menu" class="sidenav-trigger"><i class="material-icons">menu</i></a>

                    <ul id="nav-mobile" class="right hide-on-med-and-down">
                        <%=links%>
                    </ul>
                </div>
            </nav>
            <ul id="mobile-menu" class="sidenav" style="overflow-y: auto">
                <li>
                    <div class="user-view <%=whiteText%>">
                        <div class="background">
                            <img class="responsive-img" src="../img/<%=imgUsuarios[user.getTipo()]%>" />
                        </div>
                        <h3><%=user.getNombre()%></h3>
                        <h4><%=tipos[user.getTipo()]%></h4>
                        <br>
                    </div>
                </li>
                <%=links%>
                <br><br><br><br><br>
            </ul>
            <a href="index.jsp" target="frameContent"></a>
            <iframe id="frameContent" name="content" class="frameCuenta" src="inicio.jsp"></iframe>
        </div>
    </body>
</html>
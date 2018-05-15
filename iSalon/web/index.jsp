<%-- 
    Document   : index
    Created on : 08-May-2018, 10:47:53
    Author     : Laxelott
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.cDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    boolean noUsers = false;
     
    cDatos db = new cDatos();
    
    db.conectar();
    ResultSet res = db.consulta("select count(*) as num from usuarios;");
    
    while(res.next()) {
        noUsers = (res.getInt("num") == 0);
    }
    db.cierraConexion();
%>
<!DOCTYPE html>
<html>
    <head>
        <title>iSalón</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="css/general.css" rel="stylesheet" type="text/css"/>
        <link href="css/menu.css" rel="stylesheet" type="text/css"/>
        <link href="css/materialize.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container">
            <h1>Inicio de Sesión</h1>
            <%=noUsers ? "<a href='noUsers.jsp'>Ningún usuario detectado, crear uno nuevo?</a>" : ""%>
            <form action="login" method="post">
                <div class="input-field">
                    <i class="material-icons prefix">account_circle</i>
                    <label for="username">Usuario</label>
                    <input type="text" name="username" id="username" />
                </div>
                <br>
                <div class="input-field">
                    <i class="material-icons prefix">vpn_key</i>
                    <label for="pass">Contraseña</label>
                    <input type="password" name="pass" id="pass" />
                </div>
                <br><br>
                <input class="btn" type="submit" value="Login" />
            </form>
        </div>
    </body>
</html>
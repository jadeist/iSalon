<%-- 
    Document   : noUsers
    Created on : 11/05/2018, 11:31:23 AM
    Author     : A
--%>

<%@page import="ctrl.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.cDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    boolean noUsers = false;
    String message;
    
    cDatos db = new cDatos();
    
    db.conectar();
    ResultSet res = db.consulta("select count(*) as num from usuarios;");
    
    while(res.next()) {
        noUsers = (res.getInt("num") == 0);
    }
    
    db.cierraConexion();
    
    if(noUsers) {
        Usuario user = new Usuario("admin", "1234".hashCode());
        user.setNombre("Adminstrador");
        user.create(3);
        
        message = "Usuario 'admin':'1234' creado";
    } else {
        message = "Usuarios ya existsen, ninguna acción realizada";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - Nuevo Usuario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/general.css" rel="stylesheet" type="text/css"/>
        <link href="css/materialize.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container">        
            <h3><%=message%></h3>
            <h4><a href=".">Regresar</a></h4>
        </div>
    </body>
</html>
<%-- 
    Document   : error
    Created on : 11/05/2018, 10:51:40 AM
    Author     : A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String title = request.getAttribute("title") != null ? (String) request.getAttribute("title") : "Error";
    String message = request.getAttribute("message") != null ? (String)  request.getAttribute("message") : "Hubo algún error";
    String redirect = request.getAttribute("redirect") != null ? (String)  request.getAttribute("redirect") : "/iSalon/";
    String type = request.getAttribute("type") != null ? (String) request.getAttribute("type") : "error";
    String preset = request.getAttribute("preset") != null ? (String) request.getAttribute("preset") : "";
    
    System.out.println(request.getAttribute("preset") == null);
    
    if (preset.equals("adminRights")) {
        title = "Permisos Necesarios!";
        message = "Permisos de administrador necesarios";
    } else if(preset.equals("login")) {
        title = "Sesión no Iniciada";
        message = "Iniciar sesión para continuar";
    } else if(preset.equals("fields")) {
        title = "Datos insuficientes";
        message = "Todos los datos deberán de proporcionarse";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - <%=title%></title>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Sweet Alert-->
        <link href="/iSalon/swal/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <script src="/iSalon/swal/sweetalert2.js" type="text/javascript"></script>
        
        <style>
            body {
                background-color: black;
            }
        </style>
        <script>
            $(document).ready(function() {
                swal({
                    title: "<%=title%>",
                    text: "<%=message%>",
                    type: "<%=type%>"
                }).then(function() {
                    window.parent.postMessage("'href': '<%=redirect%>', 'mode':'reload'", "*");
                    window.location = "<%=redirect%>";
                });
            });
        </script>
    </head>
    <body>
        
    </body>
</html>

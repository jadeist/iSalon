<%-- 
    Document   : error
    Created on : 11/05/2018, 10:51:40 AM
    Author     : A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String title = request.getAttribute("title") != null ? (String) request.getAttribute("title") : "Error";
    String message = request.getAttribute("message") != null ? (String)  request.getAttribute("message") : "Hubo algún error";
    String redirect = request.getAttribute("redirect") != null ? (String)  request.getAttribute("redirect") : ".";
    String type = request.getAttribute("type") != null ? (String) request.getAttribute("type") : "error";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iSalon - <%=title%></title>
        <link href="swal/sweetalert2.css" rel="stylesheet" type="text/css"/>
        <script src="swal/sweetalert2.js" type="text/javascript"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        
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
                    window.location = "<%=redirect%>";
                });
            });
        </script>
    </head>
    <body>
        
    </body>
</html>

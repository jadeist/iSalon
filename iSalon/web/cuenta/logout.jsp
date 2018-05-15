<%-- 
    Document   : logout
    Created on : 11/05/2018, 01:24:52 PM
    Author     : A
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("user");
    response.sendRedirect("/iSalon");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
        <style>
            body {
                background-color: black;
            }
        </style>
    </head>
    <body>
        
    </body>
</html>

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
        <link href="css/Background.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <!--Materialize-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="Materialize/materialize.js" type="text/javascript"></script>
        <link href="Materialize/materialize.css" rel="stylesheet" type="text/css"/>
        
        <script>
            var token = "";
            var kerberosServer = 'http://192.168.20.97:4747/iSalon-secure/kerberos';
            window.addEventListener("message", recieveMessage, false);
            
            function recieveMessage(event) {
                var data = JSON.parse(event.data);
                
                switch(data.mode) {
                    case 'reload':
                        if (data.href === ".") {
                            window.location.reload();
                        } else {
                            window.location = data.href;
                        }
                    break;
                }
            }
            
            function inIframe () {
                try {
                    return window.self !== window.top;
                } catch (e) {
                    return true;
                }
            }
            if(inIframe()) {
                window.parent.postMessage("'href': index.jsp, 'mode':'reload'", "*");
            }
            
            $(document).ready(function() {
                $("#frmDat  a").submit(function(ev) {
                    ev.preventDefault();
                    
                    var data = {
                        username: $("#username").val() ,
                        pass: $("#pass").val()
                    };
                    
                    $.ajax({
                        url: kerberosServer,
                        type:'POST'
                        data: data,
                        dataType: "json",
                        crossDomain: true,
                        success: function(data, status) {
                            console.log(data);
                            if(typeof data !== 'undefined') {
                                $("#hidToken").val(data);

                            } else {
                                console.log("error!");
                                console.log(status);
                            }
                        }
                    }
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Inicio de Sesión</h1>
            <%=noUsers ? "<a href='noUsers.jsp'>Ningún usuario detectado, crear uno nuevo?</a>" : ""%>
            <form id="frmData1" action="login" method="post">
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
            <form id="frmLogin">
                <input type="hidden" name="token" id="hidToken" />
            </form>
        </div>
    </body>
</html>
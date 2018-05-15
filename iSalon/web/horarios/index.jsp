<%-- 
    Document   : index
    Created on : 14-May-2018, 13:48:53
    Author     : Laxelott
--%>

<%@page import="ctrl.Usuario"%>
<%@page import="ctrl.AuxFunctions"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.cDatos"%>
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

    int userId = user.getId();
    cDatos db = new cDatos();
    ResultSet res;
    String grupo;

    /*
        Lunes       7 - 20
        Martes      7 - 20
        Miercoles   7 - 20
        Jueves      7 - 20
        Viernes     7 - 20
     */
    String[][] horario = new String[][]{
        {"", "", "", "", "", "", "", "", "", "", "", "", ""},
        {"", "", "", "", "", "", "", "", "", "", "", "", ""},
        {"", "", "", "", "", "", "", "", "", "", "", "", ""},
        {"", "", "", "", "", "", "", "", "", "", "", "", ""},
        {"", "", "", "", "", "", "", "", "", "", "", "", ""}
    };

    String[] horas = new String[]{
        "7 - 8",
        "8 - 9",
        "9 - 10",
        "10 - 11",
        "11 - 12",
        "12 - 13",
        "13 - 14",
        "14 - 15",
        "15 - 16",
        "16 - 17",
        "17 - 18",
        "18 - 19",
        "19 - 20"
    };

    db.conectar();

    for (int i = 0; i < 5; ++i) {
        res = db.consulta("select  grupos.nombre as 'grupo',  salones.nombre as 'salon',  horarios.nombre as 'clase',  horarios.horaInicio, horarios.horaFinal, horarios.dia, horarios.color from horarios  inner join cathorariogrupo  on cathorariogrupo.idHor = horarios.id inner join cathorariosalon  on cathorariosalon.idHor = horarios.id   inner join salones  on salones.id = cathorariosalon.idSal inner join grupos  ON grupos.id = cathorariogrupo.idGrp   inner join catgrupousuario  on catgrupousuario.idGrp "
                + "where catgrupousuario.idUsr = " + userId + "  and dia = " + i + "   order by horarios.horaInicio asc;");

        while (res.next()) {
            horario[i] = AuxFunctions.fillArray(
                    horario[i],
                    res.getString("clase") + " -[" + res.getString("salon") + "]",
                    res.getInt("horaInicio"),
                    res.getInt("horaFinal")
            );
        }
    }

    db.cierraConexion();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Horario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../css/materialize.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="../js/materialize.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container">
            <table class="responsive-table striped centered">
                <thead>
                    <tr>
                        <td>Horas</td>
                        <td>Lunes</td>
                        <td>Martes</td>
                        <td>Miércoles</td>
                        <td>Jueves</td>
                        <td>Viernes</td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int n = 5;
                        int m = 13;
                        String[][] tableRows = new String[m][n];

                        for (int i = 0; i < n; ++i) {
                            for (int j = 0; j < m; ++j) {
                                tableRows[j][i] = horario[i][j];
                            }
                        }

                        for (int i = 0; i < m; ++i) {
                            out.println("<tr>");

                            out.println("<th>");
                            out.println(horas[i]);
                            out.println("</th>");
                            for (int j = 0; j < n; ++j) {
                                out.println("<td>");
                                out.println(tableRows[i][j]);
                                out.println("</td>");
                            }
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
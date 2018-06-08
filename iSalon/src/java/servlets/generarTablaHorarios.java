/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import database.cDatos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author A
 */
@WebServlet(name = "generarTablaHorarios", urlPatterns = {"/admin/horarios/getTable"})
public class generarTablaHorarios extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String[] data = request.getParameter("request").split("\\|\\|");
            String[] dias = new String[] {
                "Lunes",
                "Martes",
                "Miercoles",
                "Jueves",
                "Viernes"
            };
            String tableHTML = "";
            String turnos = data[0];
            String periodos = data[1];
            String regex = "[" + periodos + "].[" + turnos + "]\\d";
            List<String[]> results = new ArrayList<String[]>();
        
            // regex = [].[]\\d
            
            cDatos db = new cDatos();
            ResultSet res;
            
            db.conectar();
            res = db.consulta("select 	grupos.nombre as 'grupo',  	salones.nombre as 'salon', 	horarios.nombre as 'clase',  	horarios.horaInicio, 	horarios.horaFinal, 	horarios.dia, 	horarios.color from horarios 	 	inner join cathorariogrupo  on cathorariogrupo.idHor = horarios.id 	inner join cathorariosalon  on cathorariosalon.idHor = horarios.id 	inner join salones  on salones.id = cathorariosalon.idSal 	inner join grupos  ON grupos.id = cathorariogrupo.idGrp 	inner join catgrupousuario  on catgrupousuario.idGrp  	order by horarios.horaInicio asc, horarios.dia;");
            
            while(res.next()) {
                results.add(new String[] {
                    res.getString("grupo"),
                    res.getString("salon"),
                    res.getString("clase"),
                    String.valueOf(res.getInt("horaInicio")),
                    String.valueOf(res.getInt("horaFinal")),
                    dias[res.getInt("dia")],
                    res.getString("color")
                });
            }
            
            String[][] items = matchStringArray(results.toArray(new String[results.size()][6]), regex, 0);
            
            db.cierraConexion();
            
            for(String[] i : items) {
                tableHTML += "<tr>";

                // Grupo
                tableHTML += "<td>";
                tableHTML += i[0];
                tableHTML += "</td>";
                // Materia
                tableHTML += "<td>";
                tableHTML += i[2];
                tableHTML += "</td>";
                // Salon
                tableHTML += "<td>";
                tableHTML += i[1];
                tableHTML += "</td>";
                // Hora Inicio
                tableHTML += "<td>";
                tableHTML += i[3];
                tableHTML += "</td>";
                // Hora Final
                tableHTML += "<td>";
                tableHTML += i[4];
                tableHTML += "</td>";
                // Dia
                tableHTML += "<td>";
                tableHTML += i[4];
                tableHTML += "</td>";
                
                tableHTML += "</tr>";
            }
            
            out.print(tableHTML);
        } catch (SQLException ex) {
            Logger.getLogger(generarTablaHorarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private String[][] matchStringArray(String[][] array, String regex, int index) {
        List<String[]> aux = new ArrayList<String[]>();
        
        for(String[] item : array) {
            if(item[index].matches(regex)) {
                aux.add(item);
            }
        }
        
        return aux.toArray(new String[aux.size()][6]);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

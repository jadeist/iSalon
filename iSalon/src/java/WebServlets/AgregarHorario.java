/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebServlets;

import ctrl.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import database.cDatos;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author A
 */
@WebServlet(name = "AgregarHorario", urlPatterns = {"/admin/horarios/agregar"})
public class AgregarHorario extends HttpServlet {

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
            HttpSession session = request.getSession();

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

                if (!(user.isValid() && user.getTipo() == 3)) {
                    request.setAttribute("preset", "adminRights");

                    RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            }

            // Inicio
            if (
                    request.getParameter("name") == null ||
                    request.getParameter("salon") == null ||
                    request.getParameter("grupo") == null ||
                    request.getParameter("hi") == null ||
                    request.getParameter("hf") == null ||
                    request.getParameter("dia") == null
                ) {
                request.setAttribute("preset", "fields");
                request.setAttribute("redirect", "/iSalon/admin/horarios/agregarDatos.jsp");

                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
                return;
            }

            String materia = request.getParameter("name");
            String salon = request.getParameter("salon");
            String grupo = request.getParameter("grupo");
            String strhi = request.getParameter("hi");
            String strhf = request.getParameter("hf");
            int dia = Integer.parseInt(request.getParameter("dia"));
            int hi, hf;
            
            try {
                hi = Integer.parseInt(strhi.substring(0, strhi.length() - 3));
                hf = Integer.parseInt(strhf.substring(0, strhf.length() - 3));
            } catch(NumberFormatException err) {
                request.setAttribute("preset", "fields");
                request.setAttribute("redirect", "/iSalon/admin/horarios/agregarDatos.jsp");
                request.setAttribute("title", "Hora inválida");
                request.setAttribute("message", "Cómo y por qué?");
                request.setAttribute("type", "question");

                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            if (hf < hi) {
                request.setAttribute("preset", "fields");
                request.setAttribute("redirect", "/iSalon/admin/horarios/agregarDatos.jsp");
                request.setAttribute("title", "Horas inválidas");
                request.setAttribute("message", "La hora inicial debe ser menor que la hora final!");

                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
                return;
            } else if(
                hf < 7 || hf > 21 ||
                hi < 7 || hi > 21
            ) {
                request.setAttribute("preset", "fields");
                request.setAttribute("redirect", "/iSalon/admin/horarios/agregarDatos.jsp");
                request.setAttribute("title", "Horas inválidas");
                request.setAttribute("message", "Las horas no deben de ser menores a 7 o mayores a 21");

                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
                return;
            }

            cDatos db = new cDatos();
            db.conectar();

            db.setPreparedStatement("call insertarHorario(?, ?, ?, ?, ?, ?)");
            db.setPreparedVariables(new String[][]{
                {"String", grupo},
                {"int", String.valueOf(hi)},
                {"int", String.valueOf(hf)},
                {"String", materia},
                {"String", String.valueOf(dia)},
                {"String", salon}
            });
            ResultSet res = db.runPreparedQuery();

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>iSalon - Agregar Grupo</title>");
            out.println("<script type='text/javascript' src='https://code.jquery.com/jquery-3.2.1.min.js'></script>");
            out.println("<link href='https://fonts.googleapis.com/icon?family=Material+Icons' rel='stylesheet'>");
            out.println("<link href='../../Materialize/materialize.css' rel='stylesheet' type='text/css'/>");
            out.println("<script src='../../Materialize/materialize.js' type='text/javascript'></script>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");

            while (res.next()) {
                out.println("<h2>");
                out.println(res.getString("message"));
                out.println("</h2>");
            }

            out.println("<a href='.' class='btn wave-effect'>");
            out.println("<i class='material-icons prefix'>arrow_back</i>");
            out.println("Regresar");
            out.println("</a>");
            out.println("</div>");

            out.println("</body>");
            out.println("</html>");

            db.cierraConexion();
        } catch (SQLException ex) {
            Logger.getLogger(AgregarHorario.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        response.getWriter().println("Cannot doGet!");
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
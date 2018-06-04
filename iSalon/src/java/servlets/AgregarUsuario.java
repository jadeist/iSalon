/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

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
@WebServlet(name = "AgregarUsuario", urlPatterns = {"/admin/usuarios/agregar"})
public class AgregarUsuario extends HttpServlet {

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
            
            // Validación
            
            if(
                request.getParameter("username") == null ||
                request.getParameter("name") == null ||
                request.getParameter("pass") == null ||
                request.getParameter("type") == null ||
                request.getParameter("grp") == null ||
                request.getParameter("grp").equals("-1")
            ) {
                request.setAttribute("preset", "fields");
                request.setAttribute("redirect", "/iSalon/admin/usuarios/agregarDatos.jsp");

                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
                return;
            }

            String username = request.getParameter("username");
            String name = request.getParameter("name");
            int pass = request.getParameter("pass").hashCode();
            int type = Integer.parseInt(request.getParameter("type"));
            int grp = Integer.parseInt(request.getParameter("grp"));

            cDatos db = new cDatos();
            db.conectar();

            db.setPreparedStatement("call crearUsuario(?, ?, ?, ?, ?)");
            db.setPreparedVariables(new String[][]{
                {"String", username},
                {"String", name},
                {"int", String.valueOf(pass)},
                {"int", String.valueOf(type)},
                {"int", "0"}
            });
            ResultSet res = db.runPreparedQuery();

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>iSalon - Agregar Usuario</title>");
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
            Logger.getLogger(AgregarUsuario.class.getName()).log(Level.SEVERE, null, ex);
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

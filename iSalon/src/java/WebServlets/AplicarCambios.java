/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebServlets;

import ctrl.Usuario;
import database.cDatos;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "AplicarCambios", urlPatterns = {"/cuenta/cambios/aplicarCambios"})
public class AplicarCambios extends HttpServlet {

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

                if (!user.isValid()) {
                    request.setAttribute("preset", "login");

                    RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            }
            
            // Falta validación
            
            String name = request.getParameter("name") != null ? request.getParameter("name") : user.getNombre();
            String username = request.getParameter("username") != null ? request.getParameter("username") : user.getNombre();
            int pass = request.getParameter("pass") != null ? request.getParameter("pass").hashCode() : -1;
            int id = user.getTipo() == 3 ?
                    request.getParameter("id") != null ?
                        Integer.parseInt(request.getParameter("id"))
                        : user.getId()
                    : user.getId();
            
            cDatos db = new cDatos();
            
            db.conectar();
            
            db.setPreparedStatement("call editarUsuario(?, ?, ?, ?)");
            db.setPreparedVariables(new String[][] {
                {"String", username},
                {"String", name},
                {"int", String.valueOf(pass)},
                {"int", String.valueOf(id)}
            });
            
            ResultSet res = db.runPreparedQuery();
            String output = "";
            
            while(res.next()) {
                if(res.getInt("isValid") == 1) {
                    output = "{"
                            + "\"type\": \"success\", "
                            + "\"message\": \"" + res.getString("message") + "\" "
                            + "}";
                } else {
                    output = "{"
                            + "\"type\": \"error\", "
                            + "\"message\": \"" + res.getString("message") + "\" "
                            + "}";
                }
            }
            db.cierraConexion();
            
            out.println(output);
            
        } catch (SQLException ex) {
            Logger.getLogger(AplicarCambios.class.getName()).log(Level.SEVERE, null, ex);
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
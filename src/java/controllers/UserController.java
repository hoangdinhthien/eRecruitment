/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import config.Config;
import daos.RoleDAO;
import daos.UserDAO;
import dtos.RoleDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
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
 * @author ACER
 */
@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UserController extends HttpServlet {

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
        request.setAttribute("controller", "user");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("op");
        request.setAttribute("action", action);
//        String action = request.getParameter("action");
        System.out.println("Option : " + action);
        switch (action) {
            case "info": {
                view(request, response);
                break;
            }
            case "update": {
                view(request, response);
                break;
            }
            case "updatehandler": {
                updateHandler(request, response);
                break;
            }
        }
    }

    public void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
//            HttpSession session = request.getSession();
//            String email = (String) session.getAttribute("email");

            String email = request.getParameter("email");
            System.out.println("Info");
            UserDAO uDao = new UserDAO();
            UserDTO user = uDao.find(email);
            RoleDAO rDao = new RoleDAO();
            List<RoleDTO> listRole = rDao.selectAll();
            request.setAttribute("listRole", listRole);
            request.setAttribute("user", user);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

     public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
//            HttpSession session = request.getSession();
//            String email = (String) session.getAttribute("email");
            String email = request.getParameter("email");
            
            UserDAO uDao = new UserDAO();
            UserDTO user = uDao.find(email);
            request.setAttribute("user", user);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void updateHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("Update Handler");
//            HttpSession session = request.getSession();
//            String email = (String) session.getAttribute("email");
            String email = request.getParameter("email");
            
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            UserDAO uDao = new UserDAO();
            uDao.update(email, phone, address);
            UserDTO user = uDao.find(email);
            System.out.println("");
            request.setAttribute("user", user);
            request.setAttribute("action", "info");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
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

package controllers;

import config.Config;
import daos.UserDAO;
import dtos.GoogleDTO;
import dtos.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.GoogleUtils;
import utils.MailUtils;

/**
 *
 * @author Thien
 */
public class LoginController extends HttpServlet {

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
        request.setAttribute("controller", "login");
        String op = request.getParameter("op");
        request.setAttribute("action", op);
        switch (op) {
            //Sau khi click login with google
            case "login":
                login(request, response);
                break;
            //Sau khi click logout
            case "logout":
                logout(request, response);
                break;
            case "verification":
                verification(request, response);
                break;
            case "verification_handler":
                verification_handler(request, response);
                break;
        }
    }

    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Sau khi login bang google, google se gui 1 doan code de kiem tra
            String code = request.getParameter("code");
            if (code == null || code.isEmpty()) {
                RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
                dis.forward(request, response);
            } else {
                //Neu hop le thi tao session de luu thong tin dang nhap
                HttpSession session = request.getSession();
                //chuyen doi doan code thanh token de lay thong tin
                String accessToken = GoogleUtils.getToken(code);
                //Lay thong tin
                GoogleDTO google = GoogleUtils.getUserInfo(accessToken);
                //Neu user chua ton tai thi tao moi
                UserDTO u = UserDAO.searchUserByEmail(google.getEmail());
                if (u == null) {
                    session.setAttribute("info", google);
                    request.getRequestDispatcher("/login?op=verification").forward(request, response);
                } else {
                    //Neu da ton tai user roi thi kiem tra role

                    //Cái này kh có cũng đc
//                    if (u.getRole().equalsIgnoreCase("Admin")) {
//                    }
//                    if (u.getRole().equalsIgnoreCase("HR Staff")) {
//                    }
//                    if (u.getRole().equalsIgnoreCase("Interviewer")) {
//                    }
//                    if (u.getRole().equalsIgnoreCase("Member")) {
//                    }
//                    if (u.getRole().equalsIgnoreCase("Candidate")) {
//                    }
                    //Neu khong phai la user moi thi phai check role
                    session.setAttribute("role", u.getRole());
                }
                session.setAttribute("info", google);
                //luu thong tin dang nhap vao session cho chac
                request.setAttribute("controller", "home");
                request.setAttribute("action", "index");
                request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        request.setAttribute("controller", "home");
        request.setAttribute("action", "index");
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void verification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            GoogleDTO google = (GoogleDTO) session.getAttribute("info");
            int verifyCode = (int) Math.floor(((Math.random() * 899999) + 100000));
            String to = google.getEmail();
            String subject = "3HTD: Verify Your Account";
            String body = "<h3>You receive this email because you has chosen verify via this email address.</h3></br>"
                    + "<p>This is your verification code:</p></br>"
                    + "<p style=\"font-size: 20px; font-weight:bold;\">G - "
                    + verifyCode
                    + "</p></br>"
                    + "<p>This code has effect on 10 minutes. If this is not you please skip this message!</p>";
            MailUtils.send(to, subject, body);
            request.setAttribute("code", verifyCode);
            request.setAttribute("action", "verification");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void verification_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            GoogleDTO google = (GoogleDTO) session.getAttribute("info");
            String code= request.getParameter("code");
            String inputCode= request.getParameter("inputCode").trim();
            if (!code.equals(inputCode)) {
                
                request.setAttribute("message", "Wrong code!");
                request.setAttribute("inputCode", inputCode);
                request.setAttribute("code", code);
                request.setAttribute("action", "verification");
            } else {
                UserDAO.addBasicInfo(new UserDTO(google.getEmail(), google.getName(), 4));
                //Mac dinh user moi la member
                session.setAttribute("role", "Member");
                request.setAttribute("controller", "home");
                request.setAttribute("action", "index");
            }
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
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

package controllers;

import config.Config;
import daos.CandidateDAO;
import daos.MajorDAO;
import dtos.CandidateDTO;
import dtos.MajorDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Thien
 */
public class InterviewController extends HttpServlet {

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
        request.setAttribute("controller", "interview");
        String op = request.getParameter("op");
        request.setAttribute("action", op);
        switch (op) {
            //Chuyen den giao dien set schedule
            case "set_schedule":
                set_schedule(request, response);
                break;
            //Xu ly filter
            case "set_schedule_handler":
                set_schedule_handler(request, response);
                break;
        }
    }

    protected void set_schedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Lay het major ra de lm combo box filter by major
            List<MajorDTO> listOfMajor = MajorDAO.listAll();
            request.setAttribute("listOfMajor", listOfMajor);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(InterviewController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(InterviewController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void set_schedule_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int major_id = Integer.parseInt(request.getParameter("major_id"));
            String page = request.getParameter("page");
            //page hien tai
            int intpage = 1;
            //Tong so page
            int totalpage = 0;
            //do la int nen khong duoc null
            if (page != null) {
                intpage = Integer.parseInt(page);
            }
            //Lay candidate theo major
            List<CandidateDTO> listOfCandidate = CandidateDAO.searchTestedCandidate(major_id);
            //Tao list con de phan trang
            List<CandidateDTO> sublist = new LinkedList<>();
            //Tap hop so cua page
            List<Integer> pageList = new LinkedList<>();
            //Bat dau phan trang
            if (listOfCandidate.size() > 0) {
                totalpage = listOfCandidate.size() % 4 == 0 ? listOfCandidate.size() / 4 : (listOfCandidate.size() / 4) + 1;
                for (int i = 0; i < totalpage; i++) {
                    pageList.add(i);
                }
                int n = (intpage - 1) * 4;

                if (listOfCandidate.size() >= n + 4) {
                    sublist = listOfCandidate.subList(n, n + 4);
                } else {
                    sublist = listOfCandidate.subList(n, listOfCandidate.size());
                }
            }
            //Lay lai Major va bao toan form
            List<MajorDTO> listOfMajor = MajorDAO.listAll();
            request.setAttribute("listOfMajor", listOfMajor);
            request.setAttribute("choosenMajor", major_id);
            
            request.setAttribute("sublist", sublist);
            request.setAttribute("page", intpage);
            request.setAttribute("noOfPage", pageList);
            request.setAttribute("action", "set_schedule");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(InterviewController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(InterviewController.class.getName()).log(Level.SEVERE, null, ex);
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

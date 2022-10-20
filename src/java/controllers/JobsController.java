/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import config.Config;
import daos.JobsDAO;
import daos.MajorDAO;
import daos.NotificationDAO;
import dtos.GoogleDTO;
import dtos.JobsDTO;
import dtos.MajorDTO;
import dtos.NotificationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "JobsController", urlPatterns = {"/job"})
public class JobsController extends HttpServlet {

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
        try  {
            HttpSession session = request.getSession();
            GoogleDTO google = (GoogleDTO) session.getAttribute("info");
            NotificationDAO nDao = new NotificationDAO();
            List<NotificationDTO> notify = nDao.select(google.getEmail());
            request.setAttribute("listNotification", notify);
            request.setAttribute("count", nDao.count(google.getEmail()));
            
            List<MajorDTO> listMajor = MajorDAO.listAll();
            request.setAttribute("listMajor", listMajor);
            
            request.setAttribute("controller", "job");
            String op = request.getParameter("op");
            request.setAttribute("action", op);
            switch (op) {
                case "list":
                    list_jobs(request, response);
                    break;
                case "search":
                    search_jobs(request, response);
                    break;
                case "add_job":
                    add_job(request, response);
                    break;
                case "add_job_handler":
                    add_job_handler(request, response);
                    break;
                case "filter_job":
                    filter_job(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void list_jobs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                List<JobsDTO> list = JobsDAO.list_job();
                MajorDAO majorDao = new MajorDAO();
                List<MajorDTO> listMajor = majorDao.listAll();
                request.setAttribute("listMajor", listMajor);
                request.setAttribute("list", list);
                request.setAttribute("action", "search");
                request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected void search_jobs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String search = request.getParameter("search");
            try {
                List<JobsDTO> list = JobsDAO.search_job(search);
                MajorDAO majorDao = new MajorDAO();
                List<MajorDTO> listMajor = majorDao.listAll();
                request.setAttribute("listMajor", listMajor);
                request.setAttribute("list", list);
                request.setAttribute("search", search);
                request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected void add_job(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        }
    }

    protected void add_job_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String job_id = request.getParameter("job_id");
            String job_name = request.getParameter("job_name");
            int major_id = Integer.parseInt(request.getParameter("major_id"));
            String job_description = request.getParameter("job_description");
            int job_vacancy = Integer.parseInt(request.getParameter("job_vacancy"));
            int level_id = Integer.parseInt(request.getParameter("level_id"));
            double salary = Double.parseDouble(request.getParameter("salary"));
            Date postDate = new Date();
            JobsDTO new_job = new JobsDTO();
            new_job.setJob_id(job_id);
            new_job.setJob_name(job_name);
            new_job.setMajor_id(major_id);
            new_job.setJob_description(job_description);
            new_job.setJob_vacancy(job_vacancy);
            new_job.setLevel_id(level_id);
            new_job.setSalary(salary);
            new_job.setPost_date(postDate);
            JobsDAO.add_job(new_job);
            request.getRequestDispatcher("/job?op=list").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    protected void filter_job(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int fmajor = Integer.parseInt(request.getParameter("major_id"));
            int flevel = Integer.parseInt(request.getParameter("level_id"));
            int fsalary = Integer.parseInt(request.getParameter("salary"));
            try {
                List<JobsDTO> list = JobsDAO.filter_job(fmajor,flevel,fsalary);
                MajorDAO majorDao = new MajorDAO();
                List<MajorDTO> listMajor = majorDao.listAll();
                request.setAttribute("listMajor", listMajor);
                request.setAttribute("list", list);
                request.setAttribute("action", "search");
                request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(JobsController.class.getName()).log(Level.SEVERE, null, ex);
            }
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import config.Config;
import daos.ExamDAO;
import daos.MajorDAO;
import daos.OptionDAO;
import daos.QuestionDAO;
import dtos.MajorDTO;
import dtos.OptionDTO;
import dtos.QuestionDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
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
@WebServlet(name = "ExamController", urlPatterns = {"/exam"})
public class ExamController extends HttpServlet {

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
//        String controller = (String) request.getAttribute("controller");
//        String action = (String) request.getAttribute("action");
        request.setAttribute("controller", "exam");
        String op = request.getParameter("op");
//        request.setAttribute("action", op);
        System.out.println("Action : " + op);
        switch (op) {
            case "QuestionBank": {
                questionBank(request, response);
                break;
            }
            case "Update": {
                update(request, response);
                break;
            }
            case "Add": {
                create(request, response);
                break;
            }
            case "Create": {
                createHandler(request, response);
                break;
            }
            case "UpdateHandler": {
                updateHandler(request, response);
                break;
            }
            case "CreateExam": {
                createExam(request, response);
                break;
            }
            case "takeExam": {
                takeExam(request, response);
                break;
            }
            case "result": {
                result(request, response);
                break;
            }
        }
    }

    protected void questionBank(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            QuestionDAO qDao = new QuestionDAO();
            List<QuestionDTO> listQuestion = qDao.listAll();
//            System.out.println("Count Test : " + qDao.count(2));
//            QuestionDTO qTest = listQuestion.get(0);
//            System.out.println("Q Test : " + qTest);
            OptionDAO opDao = new OptionDAO();
            List<OptionDTO> listOption = opDao.listAll();
            MajorDAO majorDao = new MajorDAO();
            List<MajorDTO> listMajor = majorDao.listAll();

            request.setAttribute("listMajor", listMajor);
            request.setAttribute("listQuestion", listQuestion);
            request.setAttribute("listOption", listOption);
            request.setAttribute("action", "questionBank");

            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("Create function");
            MajorDAO majorDao = new MajorDAO();
            List<MajorDTO> listMajor = majorDao.listAll();
            System.out.println("Create function 1");
            request.setAttribute("listMajor", listMajor);
            request.setAttribute("action", "create");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void createHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
//            String controller = (String) request.getAttribute("controller");
            System.out.println("Create Handler function");
            String question = request.getParameter("question");
            int major = Integer.parseInt(request.getParameter("major"));
            // Tạo Câu Hỏi
            QuestionDAO qDao = new QuestionDAO();
            String newId = qDao.newId();
            System.out.println("New Id : " + newId + ", Question:" + question + ", Major: " + major);
            qDao.add(newId, question, major);
            System.out.println("Added!");
            //Thêm câu trả lời
            int count = Integer.parseInt(request.getParameter("count")); // Số câu trả lời
            int correctOptions = Integer.parseInt(request.getParameter("correctOptions")); //Câu đúng
            OptionDAO opDao = new OptionDAO();
            for (int i = 1; i <= count; i++) {
                String option = request.getParameter("option" + i);
                if (i == correctOptions) {
                    opDao.add(newId, option, true);
                } else {
                    opDao.add(newId, option, false);
                }
                System.out.println(i);
            }
//            request.getRequestDispatcher(controller).forward(request, response);
            request.setAttribute("action", "questionBank");
            questionBank(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
//            String controller = (String) request.getAttribute("controller");
            String q_id = request.getParameter("q_id");
            MajorDAO majorDao = new MajorDAO();
            List<MajorDTO> listMajor = majorDao.listAll();
            QuestionDAO qDao = new QuestionDAO();
            QuestionDTO q = qDao.selectOne(q_id);
            OptionDAO opDao = new OptionDAO();
            List<OptionDTO> listOption = opDao.listOneQuestion(q_id);
            System.out.println(q);
            System.out.println(listOption);
            request.setAttribute("question", q);
            request.setAttribute("listMajor", listMajor);
            request.setAttribute("listOption", listOption);
            request.setAttribute("action", "update");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void updateHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
//            String controller = (String) request.getAttribute("controller");
            System.out.println("Update Handler function");
            String question = request.getParameter("question");
            String q_id = request.getParameter("q_id");
            int major = Integer.parseInt(request.getParameter("major"));

            QuestionDAO qDao = new QuestionDAO();
            System.out.println("New Id : " + q_id + ", Question:" + question + ", Major: " + major);
            qDao.update(q_id, question, major);
            System.out.println("Added!");

            int count = Integer.parseInt(request.getParameter("count"));
            int correctOptions = Integer.parseInt(request.getParameter("correctOptions"));
            OptionDAO opDao = new OptionDAO();
            opDao.delete(q_id);

            for (int i = 1; i <= count; i++) {
                String option = request.getParameter("option" + i);
                System.out.println("Option " + i + ": " + option);
                if (i == correctOptions) {
                    opDao.add(q_id, option, true);
                } else {
                    opDao.add(q_id, option, false);
                }
                System.out.println(i);
            }
//            request.getRequestDispatcher(controller).forward(request, response);
            questionBank(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void createExam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int major = Integer.parseInt(request.getParameter("major"));
            int numOfQuestion = Integer.parseInt(request.getParameter("numOfQuestion"));
            String name = request.getParameter("name");

            ExamDAO eDao = new ExamDAO();
            String id = eDao.newId();
            eDao.create(id, name, major);

            QuestionDAO qDao = new QuestionDAO();
            List<QuestionDTO> listQuestion = qDao.listOneMajor(major);
            int size = qDao.countByMajor(major) - 1;

            ArrayList<Integer> random = new ArrayList<>();
            for (int i = 0; i <= size; i++) {
                random.add(i);
            }

            Random r = new Random();
            if (listQuestion != null) {
                for (int i = 0; i < numOfQuestion; i++) {
                    int index = r.nextInt(random.size());
                    QuestionDTO qTest = listQuestion.get(random.remove(index));
                    eDao.addQuestion(id, qTest.getQ_id());
                    System.out.println(i + 1 + ". Selected: " + qTest);
                }
            } else {
                System.out.println("List Empty");
            }
            questionBank(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void takeExam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String canId = request.getParameter("canId");
            // CandidateDAO cDao = new Candidate 
            ExamDAO eDao = new ExamDAO();
            String eId = eDao.getExam(canId);
            System.out.println(eId);
            if (eId == null) {

            } else {
                QuestionDAO qDao = new QuestionDAO();
                List<QuestionDTO> listQuestion = qDao.listOneExam(eId);
                OptionDAO opDao = new OptionDAO();
                List<OptionDTO> listOption = opDao.listOneQExam(eId);
//            System.out.println(listOption);
                request.setAttribute("listQuestion", listQuestion);
                request.setAttribute("listOption", listOption);
                request.getRequestDispatcher("/WEB-INF/view/exam/exam.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void result(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String canId = request.getParameter("canId");
            String eId = request.getParameter("eId");
            QuestionDAO qDao = new QuestionDAO();
            double count = qDao.countByExam(eId);
            OptionDAO opDao = new OptionDAO();
            double correct = 0;
            for (int i = 1; i <= count; i++) {
                int answer = Integer.parseInt(request.getParameter("answer" + i));
                if (answer != 0) {
                    if (opDao.isCorrect(answer)) {
                        correct++;
                    }
                    System.out.println(answer + " : " + opDao.isCorrect(answer));
                }

            }
            System.out.println(correct + " " + count + " " + ((correct / count)));
            double mark = (double) ((correct / count) * 10);
            System.out.println("Mark : " + mark);
            request.getRequestDispatcher("/WEB-INF/view/exam/result.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ExamController.class.getName()).log(Level.SEVERE, null, ex);
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

package controllers;

import config.Config;
import daos.CandidateDAO;
import daos.InterviewerDAO;
import daos.InterviewingDAO;
import daos.MajorDAO;
import dtos.CandidateDTO;
import dtos.InterviewerDTO;
import dtos.InterviewingDTO;
import dtos.MajorDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
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

    //Tao 4 period trong 1 ngay
    Map<String, String> period;

    @Override
    public void init() throws ServletException {
        super.init();
        if (this.period == null) {
            this.period = new HashMap<String, String>();
        }
        period.put("08:00 - 10:00 AM", "08:00:00");
        period.put("10:00 - 12:00 AM", "10:00:00");
        period.put("13:00 - 15:00 PM", "13:00:00");
        period.put("15:00 - 17:00 PM", "15:00:00");
    }

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
                set_schedule_view(request, response);
                break;
            //Xu ly filter
            case "set_schedule_filtered":
                set_schedule_filtered(request, response);
                break;
            //Xu ly xep lich phong van
            case "set_schedule_handler":
                set_schedule_handler(request, response);
                break;
        }
    }

    protected void set_schedule_view(HttpServletRequest request, HttpServletResponse response)
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

    protected void set_schedule_filtered(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int major_id = Integer.parseInt(request.getParameter("major_id"));
            String page = request.getParameter("page");
            String success = request.getParameter("success");
            //page hien tai
            int intpage = 1;
            //Tong so page
            int totalpage = 0;
            //do la int nen khong duoc null
            if (page != null && success == null) {
                intpage = Integer.parseInt(page);
            }
            //Lay candidate theo major
            List<CandidateDTO> listOfCandidate = CandidateDAO.searchCandidateById(major_id, 2);

            //Lay available interviewer theo major
            List<InterviewerDTO> listOfInterviewer = InterviewerDAO.searchAvailableInterviewer(major_id, true);

            if (listOfCandidate.iterator().hasNext()) {
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
                //Lay thoi gian hien tai cong them 1 ngay
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date();
                Calendar c = Calendar.getInstance();
                c.setTime(date);
                c.add(Calendar.DATE, 1);
                date = c.getTime();
                request.setAttribute("minDate", sdf.format(date));


                //Pagination
                request.setAttribute("sublist", sublist);
                request.setAttribute("page", intpage);
                request.setAttribute("noOfPage", pageList);

                //Lay period
                request.setAttribute("period", period.keySet());

                //Lay list interviewer
                request.setAttribute("interviewers", listOfInterviewer);
                if (listOfInterviewer.size() < 2) {
                    request.setAttribute("message", "Sorry, there's not enough available interviewers. Please comeback another time!");
                }

            }
            //Lay lai Major va bao toan form
            List<MajorDTO> listOfMajor = MajorDAO.listAll();
            request.setAttribute("listOfMajor", listOfMajor);
            request.setAttribute("chosenMajor", major_id);
            
            //Set lai action de chay view
            request.setAttribute("action", "set_schedule");
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
            String time = request.getParameter("period");
            String date = request.getParameter("date");
            String[] iId = request.getParameterValues("iId");
            String[] cId = request.getParameterValues("cId");
            //Lay thong tin de bao toan form
            int major_id = Integer.parseInt(request.getParameter("major_id"));
            String page = request.getParameter("page");
            //parse time de check xem trong database co time do chua
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            time = period.get(time);
            if (!InterviewingDAO.searchInterviewByDate(sdf.parse(date + " " + time))) {
                for (String i : iId) { //Chay vong lap lay interviewer's id 
                    for (String c : cId) { // Chay vong lay candidate's id
                        InterviewingDTO ig = new InterviewingDTO();
                        ig.setInter_id(i);
                        ig.setCan_id(c);
                        ig.setDate(sdf.parse(date + " " + time));
                        ig.setLocation("3HTD Company");
                        List<InterviewingDTO> listOfInterview = InterviewingDAO.searchInterviewByInterviewerId(i);

                        //Gioi han so interview cua 1 interviewer
                        if (listOfInterview.size() < 8) {
                            InterviewingDAO.addInterview(ig);
                            CandidateDAO.updateCandidateStatus(c);
                        } else {//Set interviewer unavailable va tra lai thong bao
                            InterviewerDAO.updateInterviewerStatus(i, false);
                            request.setAttribute("message", "Interviewer is not available anymore. Please choose another one!");
//                            request.setAttribute("page", page);
//                            request.setAttribute("major_id", major_id);
                            request.getRequestDispatcher("/interview?op=set_schedule_filtered").forward(request, response);
                        }
                    }
                }
                //Add interview thanh cong
//                request.setAttribute("major_id", major_id);
//                request.setAttribute("page", "1");
                request.getRequestDispatcher("/interview?op=set_schedule_filtered&success=true").forward(request, response);
            } else {//Neu datetime da ton tai thi tra lai trang va thong bao loi
                request.setAttribute("message", "This date has been booked. Please choose another time");
//                request.setAttribute("page", page);
//                request.setAttribute("major_id", major_id);
                request.getRequestDispatcher("/interview?op=set_schedule_filtered").forward(request, response);
            }
        } catch (ParseException ex) {
            Logger.getLogger(InterviewController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(InterviewController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
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

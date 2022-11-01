package controllers;

import config.Config;
import daos.CandidateDAO;
import daos.ExamDAO;
import daos.JobsDAO;
import daos.MajorDAO;
import daos.NotificationDAO;
import dtos.CandidateDTO;
import dtos.GoogleDTO;
import dtos.JobsDTO;
import dtos.MajorDTO;
import dtos.NotificationDTO;

import dtos.UserDTO;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import utils.DBUtils;
import utils.MailUtils;

@WebServlet(name = "ApplyController", urlPatterns = {"/apply"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 1000,
        maxRequestSize = 1024 * 1024 * 1000)

public class ApplyController extends HttpServlet {

    //Upload
    PrintWriter out = null;
    Connection con = null;
    PreparedStatement ps = null;
    HttpSession session = null;

    //Download
    public static int BUFFER_SIZE = 1024 * 100;
    public static final String UPLOAD_DIR = "cv";
    public static String fileName = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {

        try {
            HttpSession session = request.getSession();
            GoogleDTO google = (GoogleDTO) session.getAttribute("info");
            if (google != null) {
                NotificationDAO nDao = new NotificationDAO();
                List<NotificationDTO> notify = nDao.select(google.getEmail());
                request.setAttribute("listNotification", notify);
                request.setAttribute("count", nDao.count(google.getEmail()));
            }
            List<MajorDTO> listMajor = MajorDAO.listAll();
            request.setAttribute("listMajor", listMajor);
            request.setAttribute("controller", "apply");
            String op = request.getParameter("op");
            request.setAttribute("action", op);
            switch (op) {
                case "index":
                    upload(request, response);
                    break;
                // Upload File
                case "uploadFile":
                    uploadFile(request, response);
                    break;
                case "downloadFile":
                    downloadFile(request, response);
                    break;
                // Custom
                case "deleteFile":
                    deleteFile(request, response);
                    break;
                case "yesupNewest":
                    yesupNewest(request, response);
                    break;
                case "yesupRecruit":
                    yesupRecruit(request, response);
                    break;
                // Display Applications
                case "listAll":
                    listAll(request, response);
                    break;
                case "list0":
                    list0(request, response);
                    break;
                case "listPending":
                    listPending(request, response);
                    break;
                case "list4":
                    list4(request, response);
                    break;

                // Sort STATUS ALL
                case "sortByStatusASCAll":
                    sortByStatusASCAll(request, response);
                    break;
                case "sortByStatusDESCAll":
                    sortByStatusDESCAll(request, response);
                    break;
                //==== SORT JOB_ID ALL
                case "sortByJobASCAll":
                    sortByJobASCAll(request, response);
                    break;
                case "sortByJobDESCAll":
                    sortByJobDESCAll(request, response);
                    break;
                //==== SORT CAN_ID ALL
                case "sortByCanASCAll":
                    sortByCanASCAll(request, response);
                    break;
                case "sortByCanDESCAll":
                    sortByCanDESCAll(request, response);
                    break;
                //==== SORT EXAM SCORE ALL
                case "sortByScoreASCAll":
                    sortByScoreASCAll(request, response);
                    break;
                case "sortByScoreDESCAll":
                    sortByScoreDESCAll(request, response);
                    break;
                //==== SORT JOB_ID RECRUIT
                case "sortByJobASCRecruit":
                    sortByJobASCRecruit(request, response);
                    break;
                case "sortByJobDESCRecruit":
                    sortByJobDESCRecruit(request, response);
                    break;
                //==== SORT CAN_ID RECRUIT
                case "sortByCanASCRecruit":
                    sortByCanASCRecruit(request, response);
                    break;
                case "sortByCanDESCRecruit":
                    sortByCanDESCRecruit(request, response);
                    break;
                //==== SORT EXAM SCORE RECRUIT
                case "sortByScoreASCRecruit":
                    sortByScoreASCRecruit(request, response);
                    break;
                case "sortByScoreDESCRecruit":
                    sortByScoreDESCRecruit(request, response);
                    break;
                //==== SORT JOB NEWEST
                case "sortByJobASCNewest":
                    sortByJobASCNewest(request, response);
                    break;
                case "sortByJobDESCNewest":
                    sortByJobDESCNewest(request, response);
                    break;
                //==== SORT STATUS PENDING
                case "sortByStatusASCPending":
                    sortByStatusASCPending(request, response);
                    break;
                case "sortByStatusDESCPending":
                    sortByStatusDESCPending(request, response);
                    break;
                //==== SORT JOB PENDING
                case "sortByJobASCPending":
                    sortByJobASCPending(request, response);
                    break;
                case "sortByJobDESCPending":
                    sortByJobDESCPending(request, response);
                    break;
                //==== SORT SCORE PENDING
                case "sortByScoreASCPending":
                    sortByScoreASCPending(request, response);
                    break;
                case "sortByScoreDESCPending":
                    sortByScoreDESCPending(request, response);
                    break;
                //==== SORT CAN_ID PENDING
                case "sortByCanASCPending":
                    sortByCanASCPending(request, response);
                    break;
                case "sortByCanDESCPending":
                    sortByCanDESCPending(request, response);
                    break;
                //==== FILTER STATUS 012345 ALL
                case "filterStatus0All":
                    filterStatus0All(request, response);
                    break;
                case "filterStatus1All":
                    filterStatus1All(request, response);
                    break;
                case "filterStatus2All":
                    filterStatus2All(request, response);
                    break;
                case "filterStatus3All":
                    filterStatus3All(request, response);
                    break;
                case "filterStatus4All":
                    filterStatus4All(request, response);
                    break;
                case "filterStatus5All":
                    filterStatus5All(request, response);
                    break;

            }
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void upload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.selectAll();
            System.out.println(list);
            request.setAttribute("list", list);
            request.setAttribute("action", "index_apply");
//        request.setAttribute("controller", "upload");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    protected void listAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.selectAll();
            System.out.println(list);
            request.setAttribute("listAll", list);
            request.setAttribute("action", "list_All");
//        request.setAttribute("controller", "upload");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    protected void list0(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.hrstatus0();
            System.out.println(list);
            request.setAttribute("list0", list);
            request.setAttribute("action", "list_Newest");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void listPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.hrstatus14();
            System.out.println("listPending: " + list);
            request.setAttribute("listPending", list);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    protected void list4(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.hrstatus4();
            System.out.println(list);
            request.setAttribute("list4", list);
            request.setAttribute("action", "list_Recruit");
//        request.setAttribute("controller", "upload");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    //==== SORT STATUS ALL
    protected void sortByStatusASCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sort = tf.sortByStatusASCAll();
            System.out.println(sort);
            request.setAttribute("listAll", sort);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("All sort:" + sort);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByStatusDESCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sort = tf.sortByStatusDESCAll();
            System.out.println(sort);
            request.setAttribute("listAll", sort);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("All sort:" + sort);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT JOB ALL
    protected void sortByJobASCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByJobASCAll();
            request.setAttribute("listAll", sortPen);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByJobDESCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByJobDESCAll();
            request.setAttribute("listAll", sortPen);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //===== FILE
    protected void uploadFile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            out = response.getWriter();
            session = request.getSession(false);
            String folderName = "cv";
            Part filePart = request.getPart("file");//Textbox name FILE
            String fileName = filePart.getSubmittedFileName();

            //Đường dẫn đến Nơi Lưu
            // C:\Users\ADMIN\OneDrive\Máy tính\PRJ\UploadFileProPro\build\web\cv\
            String uploadPath = request.getServletContext().getRealPath("") + folderName + File.separator;

            File dir = new File(uploadPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            String path
                    = //                    folderName +
                    fileName;
            UserDTO userDTO = new UserDTO();
            userDTO.getEmail();

            System.out.println("fileName:" + fileName);
            System.out.println("path:" + path);

            //============
            // Mã của can_id : Cxxx
            // Mã của job_id : Jxxx
            int num = 6;
            String can_id = "C00" + num;
            String job_id = "J00"
                    + num;
            String gmail
                    = "member"
                    + //                     num +
                    "4@gmail.com";

            InputStream is = filePart.getInputStream();
            Files.copy(is, Paths.get(uploadPath + fileName), StandardCopyOption.REPLACE_EXISTING);
            try {
                con = DBUtils.makeConnection();
                System.out.println("Connection done [Upload]");

                String sql = "insert into candidate(can_id,job_id,email,can_cv,isStatus) "
                        + "values(?,?,?,?,?)";

                ps = con.prepareStatement(sql);
                ps.setString(1, can_id);
                //1 email - 1 job_id
                ps.setString(2, job_id);
                System.out.println("Email: " + userDTO.getEmail());
//                ps.setString(3, "2@gmail.com");
                System.out.println("Email" + gmail);
                ps.setString(3, gmail);
                System.out.println(gmail);
                ps.setString(4, path);
                ps.setInt(5, 0);

                int status = ps.executeUpdate();
                if (status > 0) {
                    session.setAttribute("fileName", fileName);
                    String msg = "" + fileName + "file uploaded successfully...";
                    request.setAttribute("msg", msg);

//Đường tới /upload/success.jsp
                    request.setAttribute("controller", "apply");
                    request.setAttribute("action", "index_apply");
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
//                    RequestDispatcher rd = request.getRequestDispatcher("/success.jsp");
//                    rd.forward(request, response);
//=====
                    System.out.println("File upload successfully");
                    System.out.println("Uploaded Path: " + uploadPath);
                }
            } catch (SQLException ex) {
                out.println("Exception: " + ex);
                System.out.println("Exception1: " + ex);

            } finally {
                try {
                    if (ps != null) {
                        ps.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    out.println(e);
                }
            }

        } catch (IOException | ServletException e) {
            out.println("Exception: " + e);
            System.out.println("Exception2: " + e);
        }

    }

    protected void downloadFile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        fileName = request.getParameter("fileName");
        if (fileName == null || fileName.equals("")) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>File " + fileName + " Is Not Present ...!(1)<h3>");
            System.out.println("Error Downloading :" + fileName);
        } else {
            System.out.println("Downloading(2) :" + fileName);
            String applicationPath = getServletContext().getRealPath("");
            String downloadPath = applicationPath
                    + UPLOAD_DIR;
            String filePath = downloadPath + File.separator + fileName;
            System.out.println(fileName);
            System.out.println(filePath);

            File file = new File(filePath);
            OutputStream outStream = null;
            FileInputStream inputStream = null;

            if (file.exists()) {
                String mimeType = "application/octet-stream";
                response.setContentType(mimeType);

                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", file.getName());
                response.setHeader(headerKey, headerValue);

                try {
                    outStream = response.getOutputStream();
                    inputStream = new FileInputStream(file);
                    byte[] buffer = new byte[BUFFER_SIZE];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                } catch (IOException ioExObj) {
                    System.out.println("Exception While Performing The I/O Operation?= " + ioExObj.getMessage());
                } finally {
                    if (inputStream != null) {
                        inputStream.close();
                    }

                    outStream.flush();
                    if (outStream != null) {
                        outStream.close();
                    }
                }
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<h3>File " + fileName + " Is Not Present..!(2)<h3>");
                System.out.println("Upload FileName: " + fileName);
            }

        }
    }

    protected void deleteFile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            String can_id = request.getParameter("can_id"); // lấy id
            CandidateDAO tf = new CandidateDAO();
            tf.delete(can_id);
            //Cho hiện lại danh sách 
            response.sendRedirect("/upload?op=upload_index");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    protected void yesupNewest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            String can_id = request.getParameter("can_id"); // lấy id        
            CandidateDAO tf = new CandidateDAO();
            tf.updateup(can_id);
            int major = tf.getMajor(can_id);
            ExamDAO eDao = new ExamDAO();
            eDao.giveExam(can_id, major);
            CandidateDTO cd = new CandidateDTO();
            System.out.println("status :" + cd.getIsStatus());
            String email = tf.getEmailByCanId(can_id);
            NotificationDAO nDao = new NotificationDAO();
            nDao.add(email, "Aplication " + can_id + " have been accepted",
                    "Thank you for apply to this jobs. "
                            + "You aplication have been accepted by the HR department. "
                            + "There is a entry Exam that need to be done before the interviewing. "
                            + "Please take this test at soon at posible.",
                    "Click here to take the exam.",
                    "exam?op=confirmExam&canId=" + can_id);
//            String to = google.getEmail();
            String subject = "3HTD: Aplication " + can_id + " have been accepted";
            String body = "<p>Thank you for apply to this jobs. "
                    + "You aplication have been accepted by the HR department. "
                    + "There is a entry Exam that need to be done before the interviewing. "
                    + "Please take this test at soon at posible.</p></br>"
                    + "<a  href=\"http://localhost:8084/recruitment-system/exam?op=confirmExam&canId=" + can_id + "\" style=\"font-size: 20px; font-weight:bold;\"> Click here to take the exam: </a></br>"
                    + "<p>If this is not you please skip this message!</p>";
            MailUtils.send(email, subject, body);
            //Cho hiện lại danh sách 
            response.sendRedirect("apply?op=list0");
        } catch (SQLException ex) {
        } catch (Exception ex) {
        }
    }

    protected void yesupRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            String can_id = request.getParameter("can_id"); // lấy id        
            CandidateDAO tf = new CandidateDAO();
            tf.updateup(can_id);
            String email = tf.getEmailByCanId(can_id);
            tf.removeUnusedApplication(email);
            JobsDAO jDao = new JobsDAO();
            JobsDTO job = jDao.getJob(can_id);
            
            NotificationDAO nDao = new NotificationDAO();
            nDao.add(email, "Your future job is here.",
                    "Thank you for apply to this jobs."
                            + " We have been impressed with your background and would like to formally offer you the position of " + job.getJob_name() + "."
                            + " This is a full time position with an annual salary of " + job.getSalary() + "."
                            + " You will be reporting to the head of the department. Your expected starting date is 31/10."
                            + " Because of this, your other applicans will be cancel.",
                    null,
                    null);
            //Cho hiện lại danh sách 
            String subject = "3HTD: Your future job is here.";
            String body = "<p>Thank you for apply to this jobs. "
                    + "We have been impressed with your background and would like to formally offer you the position of " + job.getJob_name() + ". "
                    + "This is a full time position with an annual salary of " + job.getSalary() + "$. "
                    + "You will be reporting to the head of the department. "
                    + "Your expected starting date is 31/10.</p></br>"
                    + "<p>Because of this, your other applicans will be cancel.</p></br>"
                    + "<p>If this is not you please skip this message!</p>";
            MailUtils.send(email, subject, body);
            response.sendRedirect("apply?op=listAll");
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT CAN_ID ALL
    protected void sortByCanASCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByCanASCAll();
            request.setAttribute("listAll", sortPen);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByCanDESCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByCanDESCAll();
            request.setAttribute("listAll", sortPen);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT SCORE ALL
    protected void sortByScoreASCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByScoreASCAll();
            request.setAttribute("listAll", sortPen);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByScoreDESCAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByScoreDESCAll();
            request.setAttribute("listAll", sortPen);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT STATUS PENDING
    protected void sortByStatusASCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByStatusASCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByStatusDESCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByStatusDESCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT JOB PENDING
    protected void sortByJobASCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByJobASCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByJobDESCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByJobDESCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT CAN_ID PENDING
    protected void sortByCanASCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByCanASCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByCanDESCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByCanDESCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT SCORE PENDING
    protected void sortByScoreASCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByScoreASCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByScoreDESCPending(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByScoreDESCPending();
            request.setAttribute("listPending", sortPen);
            request.setAttribute("action", "list_Pending");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Pending" + sortPen);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT JOB RECRUIT
    protected void sortByJobASCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByJobASCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByJobDESCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByJobDESCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT CAN_ID RECRUIT
    protected void sortByCanASCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByCanASCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByCanDESCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByCanDESCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT EXAM SCORE RECRUIT
    protected void sortByScoreASCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByScoreASCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByScoreDESCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByScoreDESCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT JOB NEWEST
    protected void sortByJobASCNewest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByJobASCNewest();
            System.out.println(sortRecruit);
            request.setAttribute("list0", sortRecruit);
            request.setAttribute("action", "list_Newest");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByJobDESCNewest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sort = tf.sortByJobDESCNewest();
            request.setAttribute("list0", sort);
            request.setAttribute("action", "list_Newest");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    // FILTER STATUS ALL
    protected void filterStatus0All(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> fil = tf.hrstatus0();
            request.setAttribute("listAll", fil);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void filterStatus1All(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> fil = tf.hrstatus1();
            request.setAttribute("listAll", fil);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void filterStatus2All(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> fil = tf.hrstatus2();
            request.setAttribute("listAll", fil);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void filterStatus3All(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> fil = tf.hrstatus3();
            request.setAttribute("listAll", fil);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void filterStatus4All(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> fil = tf.hrstatus4();
            request.setAttribute("listAll", fil);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void filterStatus5All(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> fil = tf.hrstatus5();
            request.setAttribute("listAll", fil);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
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
        try {
            processRequest(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ApplyController.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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

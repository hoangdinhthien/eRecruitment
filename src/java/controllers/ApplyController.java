package controllers;

import config.Config;
import daos.CandidateDAO;
import daos.InterviewingDAO;
import daos.JobsDAO;
import daos.UserDAO;
import dtos.CandidateDTO;
import dtos.GoogleDTO;
import dtos.InterviewingDTO;
import dtos.JobsDTO;
import dtos.UserDTO;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
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
            throws ServletException, IOException, ClassNotFoundException, SQLException {
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
            case "listApplicationByEmail":
                listApplicationByEmail(request, response);
                break;
            case "viewUserApplication":
                viewUserApplication(request, response);
                break;
            case "list0":
                list0(request, response);
                break;
            case "listInprocess":
                listInprocess(request, response);
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
//            ==== SORT CAN NEWEST
            case "sortByCanASCNewest":
                sortByCanASCNewest(request, response);
                break;
            case "sortByCanDESCNewest":
                sortByCanDESCNewest(request, response);
                break;
            //==== SORT STATUS Inprocess
            case "sortByStatusASCInprocess":
                sortByStatusASCInprocess(request, response);
                break;
            case "sortByStatusDESCInprocess":
                sortByStatusDESCInprocess(request, response);
                break;
            //==== SORT SCORE Inprocess
            case "sortByScoreASCInprocess":
                sortByScoreASCInprocess(request, response);
                break;
            case "sortByScoreDESCInprocess":
                sortByScoreDESCInprocess(request, response);
                break;
            //==== SORT CAN_ID Inprocess
            case "sortByCanASCInprocess":
                sortByCanASCInprocess(request, response);
                break;
            case "sortByCanDESCInprocess":
                sortByCanDESCInprocess(request, response);
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
            // Search Job_id
            case "search":
                search(request, response);
                break;
        }
    }
// protected void upload(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException, ClassNotFoundException {
//        try {
//            String jobId = request.getParameter("job_id");
//            CandidateDAO tf = new CandidateDAO();
//            List<CandidateDTO> list = tf.selectAll();
//            System.out.println(list);
//            request.setAttribute("job_id", jobId);
//            request.setAttribute("list", list);
//            request.setAttribute("action", "index_apply");
//            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
//        } catch (SQLException ex) {
//            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
    // VIEW USER APPLICATION ( HR STAFF )

    protected void viewUserApplication(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        String email = request.getParameter("email"); // lấy id
        try {
            
            System.out.println("User Email: "+ email);
            List<CandidateDTO> sea = CandidateDAO.viewUserApplication(email);
            request.setAttribute("listEmail", sea);
            request.setAttribute("email", email);
            request.setAttribute("controller", "user");
            request.setAttribute("action", "viewUserInfo");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
        System.out.println("Error: " +email);
        }
    }

    // LIST BY ACCOUNT EMAIL
    protected void listApplicationByEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        try {
            //Lay email tu session
            HttpSession session = request.getSession();
            GoogleDTO g = (GoogleDTO) session.getAttribute("info");
            String email = g.getEmail();
            List<CandidateDTO> sea = CandidateDAO.search2(email);
            request.setAttribute("listEmail", sea);
            request.setAttribute("controller", "user");
            request.setAttribute("action", "info");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void search(HttpServletRequest request, HttpServletResponse response)
            throws ClassNotFoundException, SQLException {
        String search = request.getParameter("search");
        try {
            List<CandidateDTO> sea = CandidateDAO.search(search);
            request.setAttribute("listAll", sea);
            request.setAttribute("search", search);
            request.setAttribute("action", "list_All");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void upload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            String jobId = request.getParameter("job_id");
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.selectAll();
            System.out.println(list);
            request.setAttribute("job_id", jobId);
            request.setAttribute("list", list);
            request.setAttribute("action", "index_apply");
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

    protected void listInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> list = tf.hrstatus14();
            System.out.println("listInprocess: " + list);
            request.setAttribute("listInprocess", list);
            request.setAttribute("action", "list_Inprocess");
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

    //===== FILE
    protected void uploadFile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
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
            String path = /*folderName +*/ fileName;
            UserDTO userDTO = new UserDTO();
            userDTO.getEmail();

            System.out.println("fileName:" + fileName);
            System.out.println("path:" + path);

            HttpSession session = request.getSession();
            GoogleDTO google = (GoogleDTO) session.getAttribute("info");
            if (google != null) {

                System.out.println("Info");
                UserDAO uDao = new UserDAO();
                UserDTO user = uDao.find(google.getEmail());
                System.out.println("Email :" + user.getEmail());
                String job_id = request.getParameter("job_id");
                System.out.println(job_id);
                JobsDAO uj = new JobsDAO();
                // Mã của can_id : Cxxx
                // Mã của job_id : Jxxx
                CandidateDAO cd = new CandidateDAO();
                String can_id = cd.newId();
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
                    ps.setString(3, user.getEmail());
                    ps.setString(4, path);
                    ps.setInt(5, 0);

                    int status = ps.executeUpdate();
                    System.out.println("abc");
                    System.out.println(job_id);
                    if (status > 0) {
                        session.setAttribute("fileName", fileName);
                        String msg = "" + fileName + " file uploaded successfully...";
                        request.setAttribute("msg", msg);
                        List<JobsDTO> list = JobsDAO.list_job();
                        request.setAttribute("controller", "job");
                        request.setAttribute("list", list);
                        request.setAttribute("action", "search");
                        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                        System.out.println("File upload successfully");
                        System.out.println("Uploaded Path: " + uploadPath);
                    }
                } catch (SQLException ex) {
//                    out.println("Exception: " + ex);
                    System.out.println("Exception1: " + ex);
                    session.setAttribute("fileName", fileName);
                    String msgFailed = "" + fileName + " file uploaded failed...";
                    request.setAttribute("msgFailed", "That Job already apply.");
                    List<JobsDTO> list = JobsDAO.list_job();
                    request.setAttribute("controller", "job");
                    request.setAttribute("list", list);
                    request.setAttribute("action", "search");
                    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
                    System.out.println("File upload failed");
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
            } else {
                System.out.println("Error when connect to account");
            }

        } catch (IOException | ServletException e) {
            out.println("Exception: " + e);
            System.out.println("Exception2: " + e);
            String msgFailed = "" + fileName + " file uploaded failed...";
            request.setAttribute("msgFailed", msgFailed);
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
            response.sendRedirect("upload?op=upload_index");
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
            CandidateDTO cd = new CandidateDTO();
            System.out.println("status :" + cd.getIsStatus());

            //Cho hiện lại danh sách 
            response.sendRedirect("apply?op=list0");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    protected void yesupRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            String can_id = request.getParameter("can_id"); // lấy id        
            CandidateDAO tf = new CandidateDAO();
            tf.updateup(can_id);
            CandidateDTO cd = new CandidateDTO();
            System.out.println("status :" + cd.getIsStatus());

            //Cho hiện lại danh sách 
            response.sendRedirect("apply?op=listAll");
        } catch (SQLException ex) {
            ex.printStackTrace();
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
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
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
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
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
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
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
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT STATUS Inprocess
    protected void sortByStatusASCInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByStatusASCInprocess();
            request.setAttribute("listInprocess", sortPen);
            request.setAttribute("action", "list_Inprocess");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByStatusDESCInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByStatusDESCInprocess();
            request.setAttribute("listInprocess", sortPen);
            request.setAttribute("action", "list_Inprocess");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT CAN_ID Inprocess
    protected void sortByCanASCInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByCanASCInprocess();
            request.setAttribute("listInprocess", sortPen);
            request.setAttribute("action", "list_Inprocess");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByCanDESCInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByCanDESCInprocess();
            request.setAttribute("listInprocess", sortPen);
            request.setAttribute("action", "list_Inprocess");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT SCORE Inprocess
    protected void sortByScoreASCInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByScoreASCInprocess();
            request.setAttribute("listInprocess", sortPen);
            request.setAttribute("action", "list_Inprocess");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByScoreDESCInprocess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortPen = tf.sortByScoreDESCInprocess();
            request.setAttribute("listInprocess", sortPen);
            request.setAttribute("action", "list_Inprocess");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
            System.out.println("Inprocess" + sortPen);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT CAN_ID RECRUIT
    protected void sortByCanASCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByCanASCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list4", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByCanDESCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByCanDESCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list4", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT EXAM SCORE RECRUIT
    protected void sortByScoreASCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByScoreASCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list4", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByScoreDESCRecruit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByScoreDESCRecruit();
            System.out.println(sortRecruit);
            request.setAttribute("list4", sortRecruit);
            request.setAttribute("action", "list_Recruit");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==== SORT JOB NEWEST
    protected void sortByCanASCNewest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sortRecruit = tf.sortByCanASCNewest();
            System.out.println(sortRecruit);
            request.setAttribute("list0", sortRecruit);
            request.setAttribute("action", "list_Newest");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void sortByCanDESCNewest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            CandidateDAO tf = new CandidateDAO();
            List<CandidateDTO> sort = tf.sortByCanDESCNewest();
            request.setAttribute("list0", sort);
            request.setAttribute("action", "list_Newest");
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(ApplyController.class.getName()).log(Level.SEVERE, null, ex);
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

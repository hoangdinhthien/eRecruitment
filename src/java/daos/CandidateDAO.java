/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CandidateDTO;
import dtos.InterviewingDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Thien's
 */
public class CandidateDAO {

    public static List<CandidateDTO> searchCandidateByMajor(int major_id, int status) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("SELECT c.can_id, j.major_id, c.email, c.can_cv, c.isStatus, u.[name], u.[phone] FROM [dbo].[Candidate] c JOIN [dbo].[Job] j "
                + " on j.[job_id] = c.[job_id] JOIN [dbo].[User] u on c.[email] = u.[email] WHERE major_id=? and isStatus=?");
        stm.setInt(1, major_id);
        stm.setInt(2, status);
        ResultSet rs = stm.executeQuery();
        List<CandidateDTO> list = new LinkedList();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setMajorId(rs.getInt("major_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setName(rs.getString("name"));
            c.setIsStatus(rs.getInt("isStatus"));
            c.setPhone(rs.getString("phone"));
            list.add(c);
        }
        con.close();
        return list;
    }
    public static CandidateDTO searchCandidateByEmail(String email) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("SELECT c.can_id, j.major_id, c.email, c.can_cv, c.isStatus, u.[name], u.[phone] FROM [dbo].[Candidate] c JOIN [dbo].[Job] j "
                + " on j.[job_id] = c.[job_id] JOIN [dbo].[User] u on c.[email] = u.[email] WHERE c.[email]=?");
        stm.setString(1, email);
        ResultSet rs = stm.executeQuery();
        CandidateDTO c = new CandidateDTO();
        if (rs.next()) {
            c.setId(rs.getString("can_id"));
            c.setMajorId(rs.getInt("major_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setName(rs.getString("name"));
            c.setIsStatus(rs.getInt("isStatus"));
            c.setPhone(rs.getString("phone"));
        }
        con.close();
        return c;
    }
    public static CandidateDTO searchCandidateById(String id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("SELECT c.can_id, j.major_id, c.email, c.can_cv, u.[name] FROM [dbo].[Candidate] c JOIN [dbo].[Job] j "
                + " on j.[job_id] = c.[job_id] JOIN [dbo].[User] u on c.[email] = u.[email] WHERE c.[can_id]=?");
        stm.setString(1, id);
        ResultSet rs = stm.executeQuery();
        CandidateDTO c = new CandidateDTO();
        if (rs.next()) {
            c.setId(rs.getString("can_id"));
            c.setMajorId(rs.getInt("major_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setName(rs.getString("name"));
        }
        con.close();
        return c;
    }

    public static boolean updateCandidateStatus(String id, int isStatus) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("update [dbo].[Candidate] set isStatus=? where can_id=?");
        stm.setInt(1, isStatus);
        stm.setString(2, id);
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }
    //FILTER STATUS ALL

    // LIST ALL APPLICATIONS
    public List<CandidateDTO> selectAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,c.can_cv,score,isStatus from [Candidate] c"
        //                + "left join Interviewing as i "
        //                + "on i.can_id = c.can_id "
        );
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            InterviewingDTO i = new InterviewingDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
//            i.setScore(rs.getInt("inter_score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);

        }
        con.close();
        return list;
    }

    public List<CandidateDTO> hrstatus0() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,isStatus from [candidate] where isStatus =0");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<CandidateDTO> hrstatus1() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,isStatus from [candidate] where isStatus =1");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<CandidateDTO> hrstatus2() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,isStatus from [candidate] where isStatus =2");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<CandidateDTO> hrstatus3() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,isStatus from [candidate] where isStatus =3");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<CandidateDTO> hrstatus5() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,isStatus from [candidate] where isStatus =5");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<CandidateDTO> hrstatus14() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [candidate] where isStatus > 0 and isStatus < 5");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setScore(rs.getInt("score"));
                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<CandidateDTO> hrstatus4() throws ClassNotFoundException, SQLException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        try {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score from [candidate] where isStatus = 4");
            list = new ArrayList<>();
            while (rs.next()) {
                CandidateDTO c = new CandidateDTO();
                c.setId(rs.getString("can_id"));
                c.setJobId(rs.getString("job_id"));
                c.setEmail(rs.getString("email"));
                c.setCv(rs.getString("can_cv"));
                c.setScore(rs.getInt("score"));
//                c.setIsStatus(rs.getInt("isStatus"));
                list.add(c);
            }
            con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // SORT STATUS ALL
    public List<CandidateDTO> sortByStatusASCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by isStatus ,can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
//            InterviewingDTO i = new InterviewingDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
//            i.setScore(rs.getInt("inter_score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);

        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByStatusDESCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by isStatus DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
//            InterviewingDTO i = new InterviewingDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
//            i.setScore(rs.getInt("inter_score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);

        }
        con.close();
        return list;
    }

    // SORT JOB_ID ALL
    public List<CandidateDTO> sortByJobASCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by job_id, can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByJobDESCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by job_id DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT SCORE ALL
    public List<CandidateDTO> sortByScoreASCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by score, can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByScoreDESCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by score DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT CAN_ID ALL
    public List<CandidateDTO> sortByCanASCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by  can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByCanDESCAll() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] order by can_id DESC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT STATUS PENDING
    public List<CandidateDTO> sortByStatusASCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by isStatus, can_id  ASC ");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByStatusDESCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by isStatus DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT JOB_ID PENDING
    public List<CandidateDTO> sortByJobASCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by job_id, can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByJobDESCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by job_id DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT SCORE PENDING
    public List<CandidateDTO> sortByScoreASCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by score, can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByScoreDESCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by score DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT CAN_ID PENDING
    public List<CandidateDTO> sortByCanASCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by  can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByCanDESCPending() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus > 0 and isStatus < 5 order by can_id DESC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT JOB_ID NEWEST
    public List<CandidateDTO> sortByJobASCNewest() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 0 order by job_id, can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByJobDESCNewest() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 0 order by job_id DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT JOB_ID RECRUIT
    public List<CandidateDTO> sortByJobASCRecruit() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 4 order by job_id, can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByJobDESCRecruit() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 4 order by job_id DESC , can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT CAN_ID RECRUIT
    public List<CandidateDTO> sortByCanASCRecruit() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 4 order by can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByCanDESCRecruit() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 4 order by can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    // SORT EXAM SCORE RECRUIT
    public List<CandidateDTO> sortByScoreASCRecruit() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 4 order by score,can_id  ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    public List<CandidateDTO> sortByScoreDESCRecruit() throws SQLException, ClassNotFoundException {
        List<CandidateDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select can_id,job_id,email,can_cv,score,isStatus from [Candidate] where isStatus = 4 order by score DESC, can_id ASC");
        list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO c = new CandidateDTO();
            c.setId(rs.getString("can_id"));
            c.setJobId(rs.getString("job_id"));
            c.setEmail(rs.getString("email"));
            c.setCv(rs.getString("can_cv"));
            c.setScore(rs.getInt("score"));
            c.setIsStatus(rs.getInt("isStatus"));
            list.add(c);
        }
        con.close();
        return list;
    }

    /*
    public static List<CandidateDTO> search_can(String job_name) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select * from [dbo].[Job] where job_name like ? order by [post_date] desc");
        stm.setString(1, "%" + job_name + "%");
        ResultSet rs = stm.executeQuery();
        List<CandidateDTO> list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO r = new CandidateDTO();
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_description(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getInt("salary"));
            r.setPost_date(rs.getDate("post_date"));
            list.add(r);
        }
        con.close();
        return list;
    }
     */
    // Custom
    public void updateup(String can_id) throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("UPDATE [Candidate] SET isStatus = isStatus + 1 WHERE can_id = ?");
        stm.setString(1, can_id);
        stm.executeUpdate();
        con.close();
    }

    public void delete(String can_id) throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        System.out.println("Connection done [Delete]");

        PreparedStatement stm = con.prepareStatement("DELETE FROM [Candidate] WHERE can_id = ?");
        stm.setString(1, can_id);
        stm.executeUpdate();
        System.out.println("Deleted(1): " + can_id);
        con.close();

    }
    
    public int getMajor (String canId) throws ClassNotFoundException, SQLException{
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("select [Job].[major_id] from [Candidate] INNER JOIN [Job] ON   [Candidate].[job_id] = [Job].[job_id] where [Candidate].[can_id] = ? ");
        stm.setString(1, canId);
        ResultSet rs = stm.executeQuery();
        int major = 0;
        if (rs.next()){
            major = rs.getInt("major_id");
        }
        con.close();
        return major;
    }
    
    public void result(double score, String id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Update [Candidate] set [score] = ? , [isStatus] = 2 where [can_id] = ? ");
        stm.setDouble(1, score);
        stm.setString(2, id);
        stm.executeUpdate();
        System.out.println("Update " + score +" "+ id );
        con.close();
    }
    
    public boolean check(String canId) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select [isStatus] from [Candidate] where [can_id] = ? ");
        stm.setString(1, canId);
        ResultSet rs = stm.executeQuery();
        boolean check = false;
        if (rs.next()) {
            if (rs.getInt("isStatus") == 2){
                check = true;
            }
        }
        con.close();
        return check;
    }
    
}


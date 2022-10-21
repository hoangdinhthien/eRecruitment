/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.InterviewingDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author Thien's
 */
public class InterviewingDAO {

    public static boolean addInterview(InterviewingDTO ig) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("insert into [dbo].[Interviewing](inter_id, can_id, date, location,[isStatus]) values(?,?,?,?,?)");
        stm.setString(1, ig.getInter_id());
        stm.setString(2, ig.getCan_id());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        stm.setString(3, sdf.format(ig.getDate()));
        stm.setString(4, ig.getLocation());
        stm.setInt(5, ig.getIsStatus());
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }

    public static boolean deleteInterview(String can_id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("delete from [eRecruitment].[dbo].[Interviewing] where [can_id]=?");
        stm.setString(1, can_id);
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }

    public static List<InterviewingDTO> searchInterviewByInterviewerId(String id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select  i.id, i.inter_id, i.can_id, i.[date], i.[location], i.[inter_score], i.[inter_comment], i.isStatus, c.[can_cv]"
                + " from [dbo].[Interviewing] i join  [dbo].[Candidate] c on i.[can_id]=c.[can_id] where inter_id=? order by i.isStatus asc");
        stm.setString(1, id);
        ResultSet rs = stm.executeQuery();
        List<InterviewingDTO> list = new LinkedList();
        while (rs.next()) {
            InterviewingDTO i = new InterviewingDTO();
            i.setId(rs.getInt("id"));
            i.setInter_id(rs.getString("inter_id"));
            i.setCan_id(rs.getString("can_id"));
            i.setDate(rs.getDate("date"));
            i.setLocation(rs.getString("location"));
            i.setScore(rs.getInt("inter_score"));
            i.setComment(rs.getString("inter_comment"));
            if (rs.getInt("isStatus") == 3) {
                i.setStatus("Hasn't Interviewed");
            } else if (rs.getInt("isStatus") == 4) {
                i.setStatus("Has Interviewed");
            }
            i.setCan_cv(rs.getString("can_cv"));
            list.add(i);
        }
        con.close();
        return list;
    }

    public static List<InterviewingDTO> searchInterviewByCandidateId(String id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm;
        stm = con.prepareStatement(" Select Min(i.id) as id, Min(i.can_id) as can_id, Min(i.inter_id) as inter_id, Min(i.[location]) as location, "
                + "Min(i.[inter_score]) as inter_score, Min(i.[date]) as [date], c.[isStatus] "
                + "from  [dbo].[Interviewing] i join  [dbo].[Candidate] c on i.[can_id]=c.[can_id] where i.[can_id]=? Group By c.[isStatus]");

        stm.setString(1, id);
        ResultSet rs = stm.executeQuery();
        List<InterviewingDTO> list = new LinkedList();
        while (rs.next()) {
            try {
                InterviewingDTO i = new InterviewingDTO();
                i.setId(rs.getInt("id"));
                i.setInter_id(rs.getString("inter_id"));
                i.setCan_id(rs.getString("can_id"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                i.setDate(sdf.parse(rs.getString("date")));
                i.setLocation(rs.getString("location"));
                i.setScore(rs.getInt("inter_score"));
                if (rs.getInt("isStatus") == 3) {
                    i.setStatus("Hasn't Interviewed");
                } else if (rs.getInt("isStatus") == 4) {
                    i.setStatus("Has Interviewed");
                }
                list.add(i);
            } catch (ParseException ex) {
                Logger.getLogger(InterviewingDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        con.close();
        return list;
    }

    public static boolean addInterviewRecord(InterviewingDTO ig) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("update [dbo].[Interviewing] set [inter_score] = ?, [inter_comment] = ?,[isStatus]=? where id= ?");
        stm.setInt(1, ig.getScore());
        stm.setString(2, ig.getComment());
        stm.setInt(3, ig.getIsStatus());
        stm.setInt(4, ig.getId());
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }

    public static boolean checkInterviewRecord(String can_id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm;
        stm = con.prepareStatement(" Select ISNULL([inter_comment],'null') as inter_comment from [eRecruitment].[dbo].[Interviewing] where can_id=?");

        stm.setString(1, can_id);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            InterviewingDTO i = new InterviewingDTO();
            i.setComment(rs.getString("inter_comment"));
            if (i.getComment().equals("null")) {
                return false;
            }
        }
        con.close();
        return true;
    }

    public static boolean searchInterviewByDate(Date date) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select id, inter_id, can_id, date, location, inter_score from [dbo].[Interviewing] where date=?");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        stm.setString(1, sdf.format(date));
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return true;
        }
        con.close();
        return false;
    }
}

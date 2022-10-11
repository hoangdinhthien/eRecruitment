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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Thien's
 */
public class InterviewingDAO {

    public static boolean addInterview(InterviewingDTO ig) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("insert into [dbo].[Interviewing](inter_id, can_id, date, location) values(?,?,?,?)");
        stm.setString(1, ig.getInter_id());
        stm.setString(2, ig.getCan_id());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        stm.setString(3, sdf.format(ig.getDate()));
        stm.setString(4, ig.getLocation());
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }

    public static List<InterviewingDTO> searchInterviewByInterviewerId(String id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select id, inter_id, can_id, date, location, inter_score from [dbo].[Interviewing] where inter_id=?");
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
            list.add(i);
        }
        con.close();
        return list;
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

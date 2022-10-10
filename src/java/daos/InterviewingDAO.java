/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.InterviewerDTO;
import dtos.InterviewingDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
        public static List<InterviewerDTO> searchInterviewByInterviewerId(int major_id, boolean isAvailable) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select i.[inter_id],i.[email],u.[name]  from [dbo].[Interviewer] i join [dbo].[User] u"
                + " on i.[email] = u.[email] where major_id=? and isAvailable= ?");
        stm.setInt(1, major_id);
        stm.setBoolean(2, isAvailable);
        ResultSet rs = stm.executeQuery();
        List<InterviewerDTO> list = new LinkedList();
        while (rs.next()) {
            InterviewerDTO i = new InterviewerDTO();
            i.setId(rs.getString("inter_id"));
            i.setEmail(rs.getString("email"));
            i.setName(rs.getString("name"));
            list.add(i);
        }
        con.close();
        return list;
    }
}

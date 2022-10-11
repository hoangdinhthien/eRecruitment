/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CandidateDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Thien's
 */
public class CandidateDAO {

    public static List<CandidateDTO> searchCandidateById(int major_id, int status) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("SELECT c.can_id, j.major_id, c.email, c.can_cv, c.isStatus, u.[name], u.[phone] FROM [dbo].[Candidates] c JOIN [dbo].[Jobs] j "
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
    
    public static boolean updateCandidateStatus(String id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("update [dbo].[Candidates] set isStatus=3 where can_id=?");
        stm.setString(1, id);
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }
}

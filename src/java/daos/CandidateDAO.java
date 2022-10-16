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
    
    public static boolean updateCandidateStatus(String id,int isStatus) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("update [dbo].[Candidate] set isStatus=? where can_id=?");
        stm.setInt(1, isStatus);
        stm.setString(2, id);
        int rs = stm.executeUpdate();
        con.close();
        return rs != 0;
    }
}

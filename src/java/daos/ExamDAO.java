/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import utils.DBUtils;

/**
 *
 * @author ACER
 */
public class ExamDAO {
    public String newId() throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from [Exam] ");
        int i = 0;
        while (rs.next()) {
            i++;
        }
        i++;
        String newId = "Q0" + i;
        PreparedStatement pstm = con.prepareStatement("select * from [Exam] where [exam_id] = ?");
        pstm.setString(1, newId);
        rs = pstm.executeQuery();
        while (rs.next()) {
            i++;
            if (i < 10) {
                newId = "E0" + i;
            } else {
                newId = "E" + i;
            }
            pstm.setString(1, newId);
            rs = pstm.executeQuery();
        }
        con.close();
        return newId;
    }
    
    public void create(String name) throws ClassNotFoundException, SQLException{
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("INSERT INTO [Exam] values ( ? , ? )");
        stm.setString(1, newId());
        stm.setString(2, name);
        stm.executeQuery();
    }
}

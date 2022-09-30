/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.QuestionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ACER
 */
public class QuestionDAO {

    public List<QuestionDTO> listAll() throws SQLException, ClassNotFoundException {
        List<QuestionDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from [Questions]");
        list = new ArrayList();
        while (rs.next()) {
            QuestionDTO q = new QuestionDTO();
            q.setQ_id(rs.getString("q_id"));
            q.setQuestiontxt(rs.getString("questiontxt"));
            q.setMajor_id(rs.getInt("major_id"));
            list.add(q);
        }
        con.close();
        return list;
    }

    public QuestionDTO selectOne(String id) throws SQLException, ClassNotFoundException {
        QuestionDTO q = new QuestionDTO();
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("select * from [Questions] where [q_id] = ?");
        stm.setString(1, id);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            q.setQ_id(rs.getString("q_id"));
            q.setQuestiontxt(rs.getString("questiontxt"));
            q.setMajor_id(rs.getInt("major_id"));
        }
        con.close();
        return q;
    }
    
        public String newId() throws SQLException, ClassNotFoundException{
        Connection con = DBUtils.makeConnection();

        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from [Questions] ");
        int i = 0;
        while (rs.next()) {
            i++;
        }
        i++;
        String newId = "Q00" + i;
        rs = stm.executeQuery("select * from [Questions] where [q_id] = "+ newId);
        while (rs.next()) {
            i++;
            if (i < 10){
                newId = "Q00" + i;
            } else if (i < 100){
                newId = "Q0" + i;
            } else {
                newId = "Q" + i;
            }
            rs = stm.executeQuery("select * from [Questions] where [q_id] = "+ newId);
        }
        return newId;
    }
        
        public void add(String id, String content, int major) throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("insert into [Questions]] values ( ? , ? , ? )");
        stm.setString(1, id);
        stm.setString(2, content);
        stm.setInt(3, major);
        stm.executeQuery();
        con.close();
        
        
    }
}

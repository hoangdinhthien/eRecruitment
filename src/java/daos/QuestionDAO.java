/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.QuestionDTO;
import java.sql.Connection;
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
    public List<QuestionDTO> listAll() throws SQLException, ClassNotFoundException{
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
}


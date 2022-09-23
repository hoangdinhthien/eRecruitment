/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.OptionDTO;
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
public class OptionDAO {
    public List<OptionDTO> listAll() throws SQLException, ClassNotFoundException{
        List<OptionDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from [Options]");
        list = new ArrayList();
        while (rs.next()) {
            OptionDTO opt = new OptionDTO();
            opt.setOp_id(rs.getInt("op_id"));
            opt.setQ_id(rs.getString("q_id"));
            opt.setContent(rs.getString("content"));
            opt.setIsCorrect(rs.getBoolean("isCorrect"));
            list.add(opt);
        }
        con.close();
        return list;
    }
}

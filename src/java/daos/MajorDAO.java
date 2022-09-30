/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.MajorDTO;
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
public class MajorDAO {
    public static List<MajorDTO> listAll() throws SQLException, ClassNotFoundException{
        List<MajorDTO> list = null;
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("select * from [Major]");
        list = new ArrayList();
        while (rs.next()) {
            MajorDTO major = new MajorDTO();
            major.setMajor_id(rs.getInt("major_id"));
            major.setMajor_name(rs.getString("major_name"));
            list.add(major);
        }
        con.close();
        return list;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author ACER
 */
public class UserDAO {
    public UserDTO find(String email) throws SQLException, ClassNotFoundException {
        UserDTO user = null;
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("select * from [User] where email = ? ");
        stm.setString(1, email);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            user = new UserDTO();
            user.setEmail(rs.getString("email"));
            user.setName(rs.getString("name"));
            user.setRole_id(rs.getInt("role_id"));
            user.setPhone(rs.getString("phone"));
            user.setAddress(rs.getString("address"));
        }
        con.close();
        return user;
    }
}

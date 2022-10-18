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
 */
public class UserDAO {

    public static boolean addBasicInfo(UserDTO u) throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("insert into [dbo].[User](email, name, role_id) values(?,?,?)");
        stm.setString(1, u.getEmail());
        stm.setString(2, u.getName());
        stm.setInt(3, u.getRoleId());
        int result = stm.executeUpdate();
        con.close();
        return result != 0;
    }

    public static UserDTO searchUserByEmail(String email) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select u.[name], u.[phone], u.[address], r.[role_name] from [dbo].[User] u"
                + " join [dbo].[Role] r  on u.role_id = r.role_id where email=?");
        stm.setString(1, email);
        ResultSet rs = stm.executeQuery();
        UserDTO u = null;
        if (rs.next()) {
            u = new UserDTO();
            u.setName(rs.getString("name"));
            u.setRole(rs.getString("role_name"));
            u.setPhone(rs.getString("phone"));
            u.setAddress(rs.getString("address"));
        }
        con.close();
        return u;
    }

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
            user.setRoleId(rs.getInt("role_id"));
            user.setPhone(rs.getString("phone"));
            user.setAddress(rs.getString("address"));
        }
        con.close();
        return user;
    }

    public void update(String email, String phone, String address) throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("UPDATE [User] SET [phone] = ? , [address] = ?  WHERE [email] = ? ");
        stm.setString(1, phone);
        stm.setString(2, address);
        stm.setString(3, email);
        stm.executeUpdate();
        con.close();
    }
}

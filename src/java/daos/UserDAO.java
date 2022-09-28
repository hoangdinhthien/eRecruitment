//Thien
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
    public static boolean searchUserByEmail(String email) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select role_id from [dbo].[User] where email=?");
        stm.setString(1, email);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return true;
        }
        con.close();
        return false;
    }
}

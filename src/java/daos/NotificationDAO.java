/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.NotificationDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ACER
 */
public class NotificationDAO {

    public List<NotificationDTO> select(String email) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("select * from [Notification] where [email] = ?");
        stm.setString(1, email);
        ResultSet rs = stm.executeQuery();
        List<NotificationDTO> list = null;
        while (rs.next()) {
            NotificationDTO n = new NotificationDTO();
            n.setnId(rs.getInt("nId"));
            n.setEmail(rs.getString("email"));
            n.setTitle(rs.getString("title"));
            n.setContent(rs.getString("content"));
            n.setLink(rs.getString("link"));
            n.setDate(rs.getDate("date"));
            list.add(n);
        }
        con.close();
        return list;
    }
    
    public void add(String email, String title, String content, String link) throws ClassNotFoundException, SQLException{
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("insert into [Notification] ( [email], [title], [content], [link], [date]) values ( ? , ? , ? , ? , ? )");
        stm.setString(1, email);
        stm.setString(2, title);
        stm.setString(3, content);
        stm.setString(4, link);
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        stm.setString(5, dtf.format(now));
        stm.executeUpdate();
    }
    
    public void delete(int id) throws ClassNotFoundException, SQLException{
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("delet from [Notification] where [nId] = ? ");
        stm.setInt(1, id);
        stm.executeUpdate();
    }
}

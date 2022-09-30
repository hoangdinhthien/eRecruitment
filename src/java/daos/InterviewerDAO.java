package daos;

import dtos.InterviewerDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Thien
 */
public class InterviewerDAO {
        public static List<InterviewerDTO> searchInterviewer(int major_id, boolean isAvailable) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select i.[inter_id],i.[email],u.[name]  from [dbo].[Interviewer] i join [dbo].[User] u"
                + " on i.[email] = u.[email] where major_id=? and isAvailable= ?");
        stm.setInt(1, major_id);
        stm.setBoolean(2, isAvailable);
        ResultSet rs = stm.executeQuery();
        List<InterviewerDTO> list = new LinkedList();
        while (rs.next()) {
            InterviewerDTO i = new InterviewerDTO();
            i.setId(rs.getString("inter_id"));
            i.setEmail(rs.getString("email"));
            i.setName(rs.getString("name"));
            list.add(i);
        }
        con.close();
        return list;
    }
}

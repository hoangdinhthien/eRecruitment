/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.JobsDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Thien's
 */
public class JobsDAO {

    public static List<JobsDTO> search_job(String job_name) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select * from [dbo].[Job] where job_name like ? order by [post_date] desc");
        stm.setString(1, "%" + job_name + "%");
        ResultSet rs = stm.executeQuery();
        List<JobsDTO> list = new ArrayList<>();
        while (rs.next()) {
            JobsDTO r = new JobsDTO();
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_description(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getInt("salary"));
            r.setPost_date(rs.getDate("post_date"));
            list.add(r);
        }
        con.close();
        return list;
    }

    public static List<JobsDTO> list_job() throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select * from [dbo].[Job] order by [post_date] desc ");
        ResultSet rs = stm.executeQuery();
        List<JobsDTO> list = new ArrayList<>();
        while (rs.next()) {
            JobsDTO r = new JobsDTO();
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_description(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getDouble("salary"));
            r.setPost_date(rs.getDate("post_date"));
            list.add(r);
        }
        con.close();
        return list;
    }

    public static boolean add_job(JobsDTO j) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Insert into Job(job_id,job_name,major_id,job_description,level_id,job_vacancy,salary,post_date)"
                        + "Values(?,?,?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, j.getJob_id());
                stm.setString(2, j.getJob_name());
                stm.setInt(3, j.getMajor_id());
                stm.setString(4, j.getJob_description());
                stm.setInt(5, j.getLevel_id());
                stm.setInt(6, j.getJob_vacancy());
                stm.setDouble(7, j.getSalary());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                stm.setString(8, sdf.format(j.getPost_date()));
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
}

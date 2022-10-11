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
        PreparedStatement stm = con.prepareStatement("Select * from [dbo].[Jobs] where job_name like ? order by [post_date] desc");
        stm.setString(1, "%" + job_name + "%");
        ResultSet rs = stm.executeQuery();
        List<JobsDTO> list = new ArrayList<>();
        while (rs.next()) {
            JobsDTO r = new JobsDTO();
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_des(rs.getString("job_description"));
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
        PreparedStatement stm = con.prepareStatement("Select * from [dbo].[Jobs] order by [post_date] desc ");
        ResultSet rs = stm.executeQuery();
        List<JobsDTO> list = new ArrayList<>();
        while (rs.next()) {
            JobsDTO r = new JobsDTO();
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_des(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getInt("salary"));
            r.setPost_date(rs.getDate("post_date"));
            list.add(r);
        }
        con.close();
        return list;
    }
}


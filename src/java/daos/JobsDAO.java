/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CandidateDTO;
import dtos.JobsDTO;
import dtos.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Thien's
 */
public class JobsDAO {

    public static String newId() throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery("SELECT [job_id] FROM [Job] ");
        int i = 0;
        while (rs.next()) {
            i++;
        }
        i++;
        System.out.println(i);
        String newId = null;
        if (i < 10) {
            newId = "C00" + i;
        } else if (i < 100) {
            newId = "C0" + i;
        } else {
            newId = "C" + i;
        }
        PreparedStatement pstm = con.prepareStatement("SELECT [job_id] FROM [Job]  WHERE [job_id] = ?");
        pstm.setString(1, newId);
        rs = pstm.executeQuery();
        while (rs.next()) {
            i++;
            if (i < 10) {
                newId = "C00" + i;
            } else if (i < 100) {
                newId = "C0" + i;
            } else {
                newId = "C" + i;
            }
            pstm.setString(1, newId);
            rs = pstm.executeQuery();
        }
        con.close();
        return newId;
    }

    public static List<JobsDTO> search_job(String job_name) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select [job_id],[job_name],[major_id],[job_description],[level_id],[job_vacancy],[salary],[post_date] "
                + "from [dbo].[Job] where job_name like ? and [job_vacancy] > 0 order by [post_date] desc");
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
        PreparedStatement stm = con.prepareStatement("Select j.[job_id],j.[job_name],"
                //                                + "c.[job_id],"
                + "[major_id],[job_description],[level_id],[job_vacancy],[salary],[post_date]"
                + " from [dbo].[Job] j"
                //                                + " inner JOIN [Candidate] c ON j.[job_id] = c.[job_id]"
                + " where [job_vacancy] > 0 order by [post_date] desc ");
        ResultSet rs = stm.executeQuery();
        List<JobsDTO> list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO can = new CandidateDTO();
            can.setJobId(rs.getString("job_id"));
            
            UserDTO us = new UserDTO();
//            System.out.println("aaa" + rs.getString("job_id"));
            JobsDTO r = new JobsDTO();
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_description(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getDouble("salary"));
            r.setPost_date(rs.getDate("post_date"));
            r.setJobid(can);

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

    public static List<JobsDTO> filter_job(int fmajor, int flevel, int fsalary) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        String sql = "Select [job_id],[job_name],[major_id],[job_description],[level_id],[job_vacancy],[salary],[post_date]  from [dbo].[Job] ";
        if (fmajor != 0 || flevel != 0 || fsalary != 0) {
            sql = sql + " where ";
            if (fmajor != 0) {
                sql = sql + " [major_id] = ? ";
                if (flevel != 0 || fsalary != 0) {
                    sql = sql + " and ";
                }
            }
            if (flevel != 0) {
                sql = sql + " [level_id] = ? ";
                if (fsalary != 0) {
                    sql = sql + " and ";
                }
            }
            if (fsalary != 0) {
                if (fsalary == 1) {
                    sql = sql + " [salary] < 1000 ";
                } else if (fsalary == 2) {
                    sql = sql + " [salary] >= 1000  and [salary] < 5000 ";
                } else if (fsalary == 3) {
                    sql = sql + " [salary] >= 5000 ";
                }
            }
        }
        sql = sql + " order by [post_date] desc ";
        PreparedStatement stm = con.prepareStatement(sql);
        int position = 1;
        if (fmajor != 0) {
            stm.setInt(position, fmajor);
            position++;
        }
        if (flevel != 0) {
            stm.setInt(position, flevel);
        }
        ResultSet rs = stm.executeQuery();
        List<JobsDTO> filter = new ArrayList<>();
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
            filter.add(r);
        }
        con.close();
        return filter;
    }

    public JobsDTO getJob(String canId) throws ClassNotFoundException, SQLException {
        CandidateDAO cDao = new CandidateDAO();
        String jobId = cDao.getJob(canId);
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select * from [dbo].[Job] WHERE [job_id] = ? ");
        stm.setString(1, jobId);
        ResultSet rs = stm.executeQuery();
        JobsDTO r = new JobsDTO();
        while (rs.next()) {
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_description(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getInt("salary"));
            r.setPost_date(rs.getDate("post_date"));
        }
        con.close();
        return r;
    }

    public void reduceVacancy(String jobId) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("UPDATE [Job] SET [job_vacancy] = [job_vacancy] - 1 WHERE [job_id] = ? ");
        stm.setString(1, jobId);
        stm.executeUpdate();
        con.close();
    }

    public boolean checkVacancy(String jobId) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("SELECT [job_vacancy] FROM [Job] WHERE [job_id] = ? ");
        stm.setString(1, jobId);
        ResultSet rs = stm.executeQuery();
        int vacancy = 0;
        if (rs.next()) {
            vacancy = rs.getInt("job_vacancy");
        }
        con.close();
        boolean check = true;
        if (vacancy <= 1) {
            if (vacancy == 1) {
                reduceVacancy(jobId);
            }
            check = false;
        } else {
            reduceVacancy(jobId);
            check = true;
        }
        return check;
    }

    public static boolean update_job(JobsDTO j) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Update [dbo].[Job] set job_name=?,major_id=?,job_description=?,level_id=?,job_vacancy=?,salary=?,post_date=? where job_id=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, j.getJob_name());
                stm.setInt(2, j.getMajor_id());
                stm.setString(3, j.getJob_description());
                stm.setInt(4, j.getLevel_id());
                stm.setInt(5, j.getJob_vacancy());
                stm.setDouble(6, j.getSalary());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                stm.setString(7, sdf.format(j.getPost_date()));
                stm.setString(8, j.getJob_id());
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

    public static JobsDTO search_update_job(String job_id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select [job_id],[job_name],[major_id],[job_description],[level_id],[job_vacancy],[salary],[post_date] from [dbo].[Job] where job_id = ? order by [post_date] desc");
        stm.setString(1, job_id);
        ResultSet rs = stm.executeQuery();
        JobsDTO r = new JobsDTO();
        if (rs.next()) {
            r.setJob_id(rs.getString("job_id"));
            r.setJob_name(rs.getString("job_name"));
            r.setMajor_id(rs.getInt("major_id"));
            r.setJob_vacancy(rs.getInt("job_vacancy"));
            r.setJob_description(rs.getString("job_description"));
            r.setLevel_id(rs.getInt("level_id"));
            r.setSalary(rs.getInt("salary"));
            r.setPost_date(rs.getDate("post_date"));
        }
        con.close();
        return r;
    }

    public static boolean delete_job(String job_id) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "Delete [dbo].[Job] where job_id=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, job_id);
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

    public static List<CandidateDTO> list_mail(String job_id) throws ClassNotFoundException, SQLException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("Select [email] from [dbo].[Candidate] where job_id=?");
        stm.setString(1, job_id);
        ResultSet rs = stm.executeQuery();
        List<CandidateDTO> list = new ArrayList<>();
        while (rs.next()) {
            CandidateDTO r = new CandidateDTO();
            r.setEmail(rs.getString("email"));
            list.add(r);
        }
        con.close();
        return list;
    }

}

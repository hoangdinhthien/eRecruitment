/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.util.Date;

/**
 *
 * @author DELL
 */
public class JobsDTO {
    private String job_id;
    private String job_name;
    private int major_id;
    private int job_vacancy;
    private String job_des;
    private int level_id;
    private int salary;
    private Date post_date;

    public JobsDTO() {
    }

    public String getJob_id() {
        return job_id;
    }

    public void setJob_id(String job_id) {
        this.job_id = job_id;
    }

    public String getJob_name() {
        return job_name;
    }

    public void setJob_name(String job_name) {
        this.job_name = job_name;
    }

    public int getMajor_id() {
        return major_id;
    }

    public void setMajor_id(int major_id) {
        this.major_id = major_id;
    }

    public int getJob_vacancy() {
        return job_vacancy;
    }

    public void setJob_vacancy(int job_vacancy) {
        this.job_vacancy = job_vacancy;
    }

    public String getJob_des() {
        return job_des;
    }

    public void setJob_des(String job_des) {
        this.job_des = job_des;
    }

    public int getLevel_id() {
        return level_id;
    }

    public void setLevel_id(int level_id) {
        this.level_id = level_id;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public Date getPost_date() {
        return post_date;
    }

    public void setPost_date(Date post_date) {
        this.post_date = post_date;
    }
    
}

<%-- 
    Document   : add_job
    Created on : Oct 13, 2022, 4:20:11 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="<c:url value="/job"/>" style="background-color: blue" >
            Job ID:
            <input type="text" name="job_id"/><br/>
            Job name:
            <input type="text" name="job_name"/><br/>
            Major ID:<br/>
            <select name="major_id">
                <option value="1">Marketing</option>
                <option value="2">Logistic</option>
                <option value="3">Data Science and Analytics</option>
                <option value="4">Information Technology</option>
                <option value="5">Graphic Design</option>
                <option value="6">Engineering</option>
                <option value="7">Risk Manager</option>
                <option value="8">Economic Finance</option>
                <option value="9">Business Intelligence and Development</option>
                <option value="10">Operations</option>
            </select><br/>
            Job vacancy:
            <input type="text" name="job_vacancy"/><br/>
            Job Description
            <input type="text" name="job_description"/><br/>
            Level ID:<br/>
            <select name="level_id">
                <option value="1">Intern</option>
                <option value="2">Fresher</option>
                <option value="3">Junior</option>
                <option value="4">Senior</option>
                <option value="5">Manager</option>
                <option value="6">Leader</option>
            </select><br/>
            Salary:
            <input type="text" name="salary"/><br/>
            <button type="submit" name="op" value="add_job_handler">ADD</button>
        </form>
    </body>
</html>

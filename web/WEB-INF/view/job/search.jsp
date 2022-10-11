<%-- 
    Document   : search
    Created on : Oct 6, 2022, 4:47:37 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1" cellspacing="0" cellpadding="4">
            <thead>
                <tr>
                    <th>Job ID</th>
                    <th>Job Name</th>
                    <th>Major ID</th>
                    <th>Job Vacancy</th>
                    <th>Job Description</th>
                    <th>Level ID</th>
                    <th>Salary</th>
                    <th>Post Date</th>
                </tr>
            </thead>
            <c:forEach var="job" items="${list}" varStatus="loop">
                <tr>
                    <td>${job.job_id}</td>
                    <td>${job.job_name}</td>
                    <td>${job.major_id}</td>
                    <td>${job.job_vacancy}</td>
                    <td>${job.job_des}</td>
                    <td>${job.level_id}</td>
                    <td>${job.salary}</td>
                    <td>${job.post_date}</td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>

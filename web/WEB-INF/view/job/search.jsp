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
        <a class="link" href="<c:url value="/job?op=add_job"/>">Add a new job</a>
        <!--<form action="<c:url value="/job"/>">
            Search: 
            <input type="text" name="search" value=""/><br/>
            <button type="submit" name="op" value="search">Search</button>
        </form>-->
        <form action="<c:url value="/job"/>">
            <ul style="position: relative">
                <li style="display: inline-block;margin-right:  50px"><select name="major_id">
                        <option value="0">All</option>
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
                    </select></li>
                    <li style="display: inline-block;margin-right:  50px"><select name="level_id">
                        <option value="0">All</option>
                        <option value="1">Intern</option>
                        <option value="2">Fresher</option>
                        <option value="3">Junior</option>
                        <option value="4">Senior</option>
                        <option value="5">Manager</option>
                        <option value="6">Leader</option>
                    </select></li>
                    <li style="display: inline-block;margin-right:  100px"><select name="salary">
                        <option value="0">All</option>
                        <option value="1"> less than 1000 </option>
                        <option value="2"> 1000 to 5000</option>
                        <option value="3"> more than 5000</option>
                    </select></li>
                    <li style="display: inline-block;position: absolute;top: 5px"><button type="submit" name="op" value="filter_job">Search</button></li>
            </ul>
        </form>
        <c:if test="${empty list}">
            <h3>No result!</h3>
        </c:if>
        <c:if test="${not empty list}">
            <div class="container" style="margin: 5% 0% 5% 0%; ">
                <div class="col-md-6 ">
                    <c:forEach var="job" items="${list}">
                        <div style="background-color: #59c5dc; border-radius: 10px; margin-bottom: 50px;padding-left: 20px;"onclick="#">
                            <h3 style="text-align: left;color: black">
                                Job Name: ${job.job_name}
                            </h3> <br/>
                            <div style="text-align: left; width: 100%" >
                                <p style="display: inline-block; margin-right: 30px;">
                                    Job ID: ${job.job_id} 
                                </p>    
                                <p style="display: inline-block; margin-right: 30px;">
                                    Major ID: ${job.major_id} 
                                </p>    
                                <p style="display: inline-block; margin-right: 30px;">
                                    Vacancy: ${job.job_vacancy} 
                                </p>
                            </div>
                            <p style="text-align: left;">
                                Description: ${job.job_description} <br/>
                            </p>
                            <div style="text-align: left; width: 100%">
                                <p style="display: inline-block; margin-right: 30px">
                                    Level ID: ${job.level_id} <br/>
                                </p>
                                <p style="display: inline-block;">
                                    Salary: ${job.salary} <br/>
                                </p>
                            </div>
                            <p style="text-align: left;">
                                Post Date: ${job.post_date} <br/>
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </body>
</html>

<%-- 
    Document   : index
    Created on : Oct 5, 2022, 4:44:35 PM
    Author     : ADMIN
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.DBUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%!
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <br><br><br><br>
        <%--
        <a href="listcv?op=list">Applications List</a><br/>
        <a href="listcv?op=userviewlist">Applications List 2</a><br/>
        <a href="upload?op=upload_index">Applications List 3</a><br><br>
        --%>
    <center>

        <form action="upload" method="post" enctype="multipart/form-data">

            
            <table border="1" cellspacing="0" cellpadding="4">
                <thead>
                    <tr>
                        <th>No.</th><th>Can_id</th><th>Job_id</th>
                        <th>Email</th><th>can_cv(File Upload)</th>
                        <th>Status</th><th style="text-align: center">Operations</th>    
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="can" items="${list}" varStatus="loop">
                        <tr
                            <td>${loop.count}</td>
                            <td>${can.id}</td>
                            <td>${can.jobId}</td>
                            <td>${can.email}</td>
                            <td>${can.cv}</td>
                            <td>${can.isStatus}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table><br>
        </form>


        <br>
        <%--<a href="<c:url value='/upload?op=upload_index'/>">Home</a>--%>
    </center>
</body>

</html>

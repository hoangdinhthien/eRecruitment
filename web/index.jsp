<%-- 
    Document   : index
    Created on : Sep 23, 2022, 9:34:05 AM
    Author     : Thien's
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
        <h1>Hello World!</h1>
        <a href="<c:url value="/ExamController?action=Add"/>">Create</a>
        <a href="<c:url value="/ExamController?action=Update&q_id=Q001"/>">Update</a>
        <a href="<c:url value="/ExamController?action=QuestionBank"/>">qBank</a>
        <a href="test.jsp">test</a>
    </body>
</html>

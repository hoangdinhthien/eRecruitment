<%-- 
    Document   : result
    Created on : Oct 15, 2022, 2:33:55 AM
    Author     : ACER
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
        <h2>You Have Completed The Exam</h2>
        <br>
        <hr/>
        <a href="<c:url value="/exam?op=QuestionBank"/>"><button>Return to home page.</button></a>
    </body>
</html>

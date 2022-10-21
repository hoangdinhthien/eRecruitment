<%-- 
    Document   : success
    Created on : Oct 5, 2022, 10:04:19 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Success Page</title>
    </head>
    <body>
    <center>
        <c:if test="${requestScope.msg!=null}">
            <h3><c:out value="${requestScope.msg}"></c:out></h3>
        </c:if><br>
        <br>
        <c:if test="${sessionScope.fileName!=null}">
            <c:set var="file" scope="session" value="${sessionScope.fileName}"/>
        </c:if>
        <a href="upload?op=downloadFile&fileName=${file}">Download</a> 
        &nbsp;&nbsp;&nbsp;

        <a href="<c:url value='/upload?op=file_list'/>">View List</a>
        <br><a href="<c:url value='/upload?op=upload_index'/>">Home</a>
<%--        <a href="upload?op=file_list&fileName=${file}">View3</a> 
        <a href="upload?op=file_list">View4</a> --%>
    </center>  
</body>
</html>

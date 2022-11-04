<%-- 
    Document   : feedback
    Created on : Nov 3, 2022, 12:37:03 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:choose>
        <c:when test="${not empty info && role == 'Admin' || role == 'HR Staff'}">
            <c:if test="${listFeedback==null}">
                <h2>Nothing at the moment!</h2>
            </c:if>
            <c:forEach items="${listFeedback}" var="feedback">
                ${feedback.subject} <br/>
                ${feedback.email} <br/>
                ${feedback.detail}<br/>
                <fmt:formatDate type = "date" value = "${feedback.date}" /> <br/>
                <a href="<c:url value="/home?op=delete&id=${feedback.id}"/>"><button>Delete</button></a>
            </c:forEach>
        </c:when>
            <c:otherwise>
                <form action="<c:url value="/home"/>" >
                    Feedback Subject: <br/>
                    <input type="text" name="subject"  maxlength="150"/><br/>
                    Email: <br/>
                    <input type="text" name="email" maxlength="60" value="${feedbackEmail}"/><br/>
                    Detail: <br/>
                    <input type="text" name="detail"  maxlength="400"/><br/>
                    <input type="hidden" name="op" value="sendFeedback"/><br/>
                    <input type="submit"/>
                </form>
            </c:otherwise>
        </c:choose>
    </body>
</html>

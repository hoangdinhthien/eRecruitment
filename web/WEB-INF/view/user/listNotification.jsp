<%-- 
    Document   : listNotification
    Created on : Oct 17, 2022, 7:44:34 PM
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
            <c:when test="${listNotification != null}">
                <a href="<c:url value="/user?op=readAll"/>">Mark all as read</a> | 
                <a href="<c:url value="/user?op=delete"/>">Delete all that read</a> <hr/>
                <c:forEach items="${listNotification}" var="notification">
                    ${notification.title}<br/>
                    ${notification.content}<br/>
                    <fmt:formatDate type = "both" value = "${notification.date}" /> (${notification.timeAgo}) <br/>
                    <c:if test="${notification.linkTitle != null && notification.link != null}">
                        <a href="<c:url value="/user?op=toLink&nId=${notification.nId}"/>">${notification.linkTitle}</a>
                    </c:if><br/>
                    <c:if test="${notification.isRead}">
                        Readed
                    </c:if>
                    <c:if test="${!notification.isRead}">
                        New | <a href="<c:url value="/user?op=read&nId=${notification.nId}"/>">Mark as read</a>
                    </c:if>
                        
                    <hr/>
                </c:forEach>
            </c:when>
                <c:otherwise>
                    
                    <h2>You don't have any notifications</h2>
                </c:otherwise>
        </c:choose>
    </body>
</html>

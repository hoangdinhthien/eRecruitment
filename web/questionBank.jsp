<%-- 
    Document   : questionBank
    Created on : Oct 4, 2022, 4:58:19 PM
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
        <c:forEach items="${listQuestion}" var="question">
            Question : ${question.questiontxt} <br/>
            Major : 
            <c:forEach var="major" items="${listMajor}">
                <c:if test="${major.major_id == question.major_id}">${major.major_name}</c:if>
            </c:forEach>
            <input type="hidden" name="q_id" value="${question.q_id}"/>
            <table id = "main">
                <c:set var="numOfOption" value="0"/>
                <c:forEach var="option" items="${listOption}">
                    <c:if test="${option.q_id == question.q_id}">
                        <tr>
                            <td>
                                <c:if test="${option.isCorrect}"> <input type="radio" checked/> </c:if>
                                </td>
                                <td>
                                ${option.content}
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <button><a href="<c:url value="/ExamController?action=Update&q_id=${question.q_id}"/>">Update</a></button>
            </table>
            <hr/>
        </c:forEach>

    </body>
</html>

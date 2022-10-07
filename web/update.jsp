<%-- 
    Document   : questionBank
    Created on : Sep 27, 2022, 3:12:55 PM
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
        <form action="<c:url value="/ExamController"/>" id="mainform" onsubmit="return validateForm()">
            <textarea type="text" placeholder="Question" name="question" cols="200" rows="5" style="resize: none;" required="true">${question.questiontxt}</textarea><br/>
            <input type="hidden" name="q_id" value="${question.q_id}"/>
            <select name="major">
                <c:forEach var="major" items="${listMajor}">
                    <option value="${major.major_id}" <c:if test="${major.major_id == question.major_id}"> selected="selected" </c:if> >${major.major_name}</option>
                </c:forEach>
            </select>

            <hr/>
            <table id = "main">
                <c:set var="numOfOption" value="0"/>
                <c:forEach var="option" items="${listOption}">
                    <c:set var="numOfOption" value="${numOfOption+1}"/>
                    <tr>
                        <td>
                            <input type="radio" value="${numOfOption}"  name="correctOptions" required="true" <c:if test="${option.isCorrect}"> checked </c:if>/>
                            </td>
                            <td>
                                <input type="text" placeholder="Option"  name="option${numOfOption}" value="${option.content}" required="true"/>    
                        </td>
                    </tr>
                </c:forEach>
                <!--                <input type="radio" value="2" class="radoOption" name="correctOptions" required="true"/><input type="text" placeholder="Name" class="someInput" name="option2" required="true"/>
                                <br>-->
            </table>
            <input type="hidden" id="countInput" name="count" value="2"/>
            <input type="button" id="addButton" value="Add" onclick="add(${numOfOption})" <c:if test="${numOfOption == 10}"> disabled="true" </c:if>/>
            <input type="button" id="removeButton" value="Remove" onclick="remove(${numOfOption})" <c:if test="${numOfOption <= 2}"> disabled="true" </c:if>/>
            <input type="hidden" name="action" value="UpdateHandler"/>
            <input type="submit"/>
        </form>

        <script src="script.js"></script> 
    </body>
</html>
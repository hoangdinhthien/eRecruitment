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
        <style>
            h1{
                text-align: center
            }
            li{
                border: 1px solid blue;
                padding: 10px;
                margin: 25px 0;
                background: #C2C1C5;
            }
            .update-btn{
                text-decoration: none;
            }
            .question-title{
                display: block
            }
            .question-major{
                display: block
            }
            .list-option{
                border: 1px solid red;
                background: #E4E4E4;
                display: block;
                padding: 10px 2px;
                margin: 10px 0;
            }

        </style>
    </head>
    <body>

        <h1>Question bank</h1>

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
            </table>
            <button><a href="<c:url value="/ExamController?action=Update&q_id=${question.q_id}"/>">Update</a></button>
            <hr/>
        </c:forEach>


        <div class="list-question">
            <ol type="1">
                <c:forEach items="${listQuestion}" var="question">
                    <li>
                        <span class="question-title">Question : ${question.questiontxt} </span>

                        <span class="question-major">
                            Major : 
                            <c:forEach var="major" items="${listMajor}">
                                <c:if test="${major.major_id == question.major_id}">${major.major_name}</c:if>
                            </c:forEach>
                        </span>

                        <input type="hidden" name="q_id" value="${question.q_id}"/>
                        <table id = "main" class="list-option">
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
                        </table>
                        <button><a class="update-btn" href="<c:url value="/ExamController?action=Update&q_id=${question.q_id}"/>">Update</a></button>
                    </li>
                </c:forEach>
            </ol>
        </div>
    </body>
</html>

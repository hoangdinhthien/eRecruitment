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
        <link href="<c:url value="/site2.css"/>" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .update-question{
                border: 1px solid red;
                padding: 20px 30px;
                background:  #C7C7C7;
            }

            hr{
                background-color: blue;
            }
            .update-title{
                text-align: left;
            }
       
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update question</h2>
            <form action="<c:url value="/exam"/>" id="mainform" onsubmit="return validateForm()">
                <div class="update-question">
                    <textarea type="text" placeholder="Question" name="question" cols="140" rows="8" style="resize: none;" required="true">${question.questiontxt}</textarea><br/>
                    <input type="hidden" name="q_id" value="${question.q_id}"/>
                    <select name="major">
                        <c:forEach var="major" items="${listMajor}">
                            <option value="${major.major_id}" <c:if test="${major.major_id == question.major_id}"> selected="selected" </c:if> >${major.major_name}</option>
                        </c:forEach>
                    </select>
                </div>
                <hr>
                <table id = "main">
                    <h4 class="update-title">Choose correct option</h4>
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
                    <input type="hidden" id="countInput" name="count" value="2" class="update-btn"/>
                    <input type="button" id="addButton" value="Add" onclick="add(${numOfOption})" <c:if test="${numOfOption == 10}"> disabled="true" </c:if>/>
                    <input type="button" id="removeButton" value="Remove" onclick="remove(${numOfOption})" <c:if test="${numOfOption <= 2}"> disabled="true" </c:if>/>
                    <input type="hidden" name="op" value="UpdateHandler"/>
                    <input type="submit"/>
            </form>
        </div>
        <script src="script.js"></script> 
    </body>
</html>
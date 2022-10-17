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
        <!--<link href="<c:url value="/site2.css"/>" rel="stylesheet" type="text/css">-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <style>
            .update-question{
                /*border: 1px solid red;*/
                padding: 20px 30px;
                background:  #C7C7C7;
                display: block;
                height: auto;
            }

            .update-selection{
                padding:  0 0 30px 0;
            }

            .update-title{
                text-align: left;
                display: block;
                padding:  50px 0 5px 0 ;
            }

            .update-option{
                display: flex;
                grid-template-columns: auto auto auto;
                gap: 20px;
                padding: 5px 20px;
            }

            .update-btn{
                text-align: right;
                margin: 0 auto;
                padding-bottom: 30px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update question</h2>
            <form action="<c:url value="/exam"/>" id="mainform" onsubmit="return validateForm()">
                
                <div class="update-question">
                    <textarea type="text" placeholder="Question" name="question" cols="150" rows="10" style="resize: none;" required="true">${question.questiontxt}</textarea><br/>
                    <input type="hidden" name="q_id" value="${question.q_id}"/>
                        <select name="major">
                            <c:forEach var="major" items="${listMajor}">
                                <option value="${major.major_id}" <c:if test="${major.major_id == question.major_id}"> selected="selected" </c:if> >${major.major_name}</option>
                            </c:forEach>
                        </select>
                </div>

                <div class="update-selection">
                    <table id = "main">
                        <h4 class="update-title">Choose correct option:</h4>
                        <c:set var="numOfOption" value="0"/>
                        <c:forEach var="option" items="${listOption}">
                            <c:set var="numOfOption" value="${numOfOption+1}"/>
                            <div class="update-option">
                                <input type="radio" value="${numOfOption}"  name="correctOptions" required="true" <c:if test="${option.isCorrect}"> checked </c:if>/>
                                <input type="text" placeholder="Option"  name="option${numOfOption}" value="${option.content}" required="true" />    
                            </div>
                        </c:forEach>
                    </table>
                </div>

                <div class="update-btn">       
                    <input type="hidden" id="countInput" name="count" value="2" class="update-btn btn btn-primary"/>
                    <input type="button" id="addButton" value="Add" onclick="add(${numOfOption})" <c:if test="${numOfOption == 10}"> disabled="true" </c:if>/>
                    <input type="button" id="removeButton" value="Remove" onclick="remove(${numOfOption})" <c:if test="${numOfOption <= 2}"> disabled="true" </c:if>/>
                    <input type="hidden" name="op" value="UpdateHandler"/>
                    <input type="submit"/>
                </div>
            </form>
        </div>
                    
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="script.js"></script> 
    </body>
</html>
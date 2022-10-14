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
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">-->
        <style>
            .update-btn{
                text-decoration: none;
            }
            .question-title{
                display: block;
                text-align: left;

            }
            .question-major{
                display: block;
                text-align: left;
            }
            .list-option{
                background: #E4E4E4;
                display: block;
                padding: 10px 2px;
                margin: 10px 0;
                text-align: left;
            }
            li{
                list-style-type: none
            }
            dialog {
                width: 500px;
                height: 500px !important;
            }
            .center{
                margin-left: auto !important;
                margin-right: auto !important;
            }
            .bordertest tr td {
                border-style:solid;border-color: #96D4D4;
            }
        </style>
    </head>
    <body>

        <h1 style="text-align: center">Question bank</h1>
        <button onclick="document.querySelector('dialog').showModal()" >Create Exam </button>
        <div>
            <dialog style="height: 150px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Update Infomation</h5>
                    </div>
                    <form action="<c:url value="/exam"/>">
                        <!--<div class="modal-body">-->
                        <input type="hidden" value="CreateExam" name="op"/>
                        <table class="center bordertest" >
                            <tr>
                                <td>
                                    Major : 
                                </td>
                                <td class="center">
                                    <select name="major" style="text-align-last:center; position: fixed !important; display: inline-block;">
                                        <c:forEach var="major" items="${listMajor}" >
                                            <option value="${major.major_id}" >${major.major_name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Number Of Question : 
                                </td>
                                <td>
                                    <input type="number" name="numOfQuestion" min="1" max="10" required="true"/>
                                </td>
                            </tr>
                        </table>
                        <!--</div>-->
                        <br/>
                        <div class="modal-footer">
                            <table class="center">
                                <tr>
                                    <td>
                                        <button type="submit" class="btn btn-primary">Update</button>
                                    </td>
                                    <!--                        </tr>
                                                            <tr>-->
                                    <td>
                                        <button onclick="document.querySelector('dialog').close()" class="btn btn-secondary" >Cancel</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form> 
                </div>
            </dialog>
        </div>
        <div class="container">
            <div class="list-question">
                <c:forEach items="${listQuestion}" var="question" varStatus="loop">
                    <li style="border: 1px solid blue; padding: 10px; margin: 25px 0; background: #C2C1C5;" >
                        <span class="question-title">${loop.count}. Question : ${question.questiontxt} </span>

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
                        <button><a class="update-btn" href="<c:url value="/exam?op=Update&q_id=${question.q_id}"/>">Update</a></button>
                    </li>
                </c:forEach>
            </div>
        </div>
    </body>
</html>

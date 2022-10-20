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

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <style>
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
                border-style:solid;
                border-color: #96D4D4;
            }
            .update-btn{
                text-align: right;
                margin: 0 auto;
            }
            .option{
                display: block;
                padding: 20px;

            }
        </style>
    </head>
    <body>

        <h1 style="text-align: center">Question bank</h1>
        <div class="container">
            <button class="btn btn-danger"onclick="document.querySelector('dialog').showModal()" >Create Exam </button>
            <a href="<c:url value="/exam?op=Add"/>"
               <button class="btn btn-danger" >Add question</button>
            </a>
            <div class="row">
                <div class="col-sm">                   
                </div>
                <div class="col-lg-3">                   
                    <li class="dropdown dropdown-1">
                        <div>
                            <span>Major</span>
                            <span class="arrow_carrot-down"></span>
                        </div>
                        <ul class="dropdown_menu dropdown_menu-1">
                            <c:forEach var="major" items="${listMajor}">
                                <li class="dropdown_item-1">
                                    <a href="<c:url value='/home?op=index'/>">${major.major_name}</a></li>
                                </c:forEach>
                        </ul>
                    </li>
                </div>
                <div class="col-sm">                   
                </div>
            </div>
        </div>
               
               
        <div>
            <dialog>
                <div class="modal-content">
                    <h5 class="modal-title">Create Exam</h5>
                    <form action="<c:url value="/exam"/>">  
                        <div class="input-group mb-3">
                            <input type="hidden" value="CreateExam" name="op"/>
                            <span class="input-group-text">Exam name:</span>
                            <input class="form-control" type="text" name="name" required="true"/>
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text mb-3">Major:</span>
                            <select class="form-control" name="major">
                                <c:forEach var="major" items="${listMajor}" >
                                    <option value="${major.major_id}" >${major.major_name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text">Number Of Question :</span>
                            <input class="form-control" type="number" name="numOfQuestion" min="1" max="10" required="true"/>
                        </div>
                        <button type="submit" class="btn btn-secondary">Update</button>
                        <button onclick="document.querySelector('dialog').close()" class="btn btn-secondary" >Cancel</button>
                    </form> 
                </div>
            </dialog>
        </div>
        <div class="container">
            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                    Dropdown button
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                    <li><a class="dropdown-item" href="#">Action</a></li>
                    <li><a class="dropdown-item" href="#">Another action</a></li>
                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
            </div>
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
                        <div id = "main" class="list-option">
                            <c:set var="numOfOption" value="0"/>
                            <c:forEach var="option" items="${listOption}">
                                <c:if test="${option.q_id == question.q_id}">
                                    <div class="input-group">
                                        <div class="input-group-text">
                                            <c:if test="${option.isCorrect}"> <input class="form-check-label" type="radio" checked/> </c:if>
                                            </div>
                                            <input type="text" id="disabledTextInput" class="form-control" placeholder="${option.content}">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="update-btn">
                            <a href="<c:url value="/exam?op=Update&q_id=${question.q_id}"/>">
                                <button class="btn btn-primary">Update question</button>
                            </a>
                        </div>
                    </li>
                </c:forEach>
            </div>
        </div>
    </body>
</html>

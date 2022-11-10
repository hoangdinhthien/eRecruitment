<%-- 
    Document   : index
    Created on : Oct 5, 2022, 4:44:35 PM
    Author     : ADMIN
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="utils.DBUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
    <center>
        <c:if test="${not empty Reject}">
            <div class="alert alert-success alert-dismissible">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>${Reject}!</strong>
            </div>
        </c:if>
        <c:if test="${not empty Accept}">
            <div class="alert alert-success alert-dismissible">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>${Accept}!</strong> 
            </div>
        </c:if>
        <h1>List All Applications</h1>
        <div class="pt-3 align-items-center justify-content-center d-flex">
            <!--===Filter===-->
            <nav class="header__menu" >
                <ul>
                    <li>
                        <a class="btn btn-success" style="color: #ffffff !important; border-color: #66D7A7;
                           background: #66D7A7; border-style: solid; text-transform: uppercase; font-weight: 500;
                           width: 100px"
                           href="<c:url value="apply?op=listAll"/>" 
                           type="button"> 
                            Status 
                            <span class="arrow_carrot-down"></span>
                        </a>
                        <ul class="header__menu__dropdown">
                            <li><a href="apply?op=filterStatus0All">Waiting</a></li>
                            <li><a href="apply?op=filterStatus1All">Accepted</a></li>
                            <li><a href="apply?op=filterStatus2All">Tested</a></li>
                            <li><a href="apply?op=filterStatus3All">Scheduled</a></li>
                            <li><a href="apply?op=filterStatus4All">Interviewed</a></li>
                            <li><a href="apply?op=filterStatus5All">Hired</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <!--===SEARCH===-->
            <form action="<c:url value="apply?op=search"/>" class="d-flex w-50 m-3">
                <div class="input-group flex-nowrap">
                    <span class="input-group-text" id="addon-wrapping"> <i class="fa fa-search"></i></span>
                    <input class="form-control me-2"  placeholder="Search Job" type="text" name="search" 
                           value="${search}"/>
                </div>
                <button class="btn btn-success" style=" color: #ffffff !important; border-color: #66D7A7;background: #66D7A7; border-style: solid; text-transform: uppercase; font-weight: 500"  
                        type="submit" value="search" name="op">
                    Search
                </button>
            </form>
        </div>
        <br>
        <nav class="header__menu">
            <ul>
                <li><a href="<c:url value="/apply?op=sortByScoreASCAll"/>"> Sort by Exam Score </a>
                    <ul class="header__menu__dropdown">
                        <li><a href="apply?op=sortByScoreASCAll">Score Ascending</a></li>
                        <li><a href="apply?op=sortByScoreDESCAll">Score Descending</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!--TABLE-->
        <table class="table table-striped" border="1" cellspacing="0" cellpadding="4">      
            <c:choose>
                <c:when test="${not empty listAll}">
                    <thead>
                        <tr>
                            <th>No.</th><th>Can_id</th><th>Job Name</th>
                            <th>Email</th><th>File Upload</th>
                            <th>Exam Score</th>
                            <!--                    <th>Interview Score</th>-->
                            <th>Status</th><th style="text-align: center">Operation</th>    
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="can" items="${listAll}" varStatus="loop">

                            <tr>
                                <td style="text-align: left;"><fmt:formatNumber value="${loop.count}" pattern="000" /></td>
                                <td>${can.id}</td>
                                <td>${can.jobname.job_name}</td>
                                <td><a href="<c:url value="apply?op=viewUserApplication&email=${can.email}"/>"> ${can.email} </a></td>
                                <td>${can.cv}</td>
                                <td>${can.score}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${can.isStatus==0}">
                                            Hasn't Accepted
                                        </c:when>
                                        <c:when test="${can.isStatus==1}">
                                            Accepted
                                        </c:when>
                                        <c:when test="${can.isStatus==2}">
                                            Tested
                                        </c:when>
                                        <c:when test="${can.isStatus==3}">
                                            Has Scheduled
                                        </c:when>
                                        <c:when test="${can.isStatus==4}">
                                            Has Been Interviewed
                                        </c:when>
                                        <c:when test="${can.isStatus==5}">
                                            Hired
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td style="text-align: center">
                                    <a href="apply?op=downloadFile&fileName=${can.cv}">Download</a>
                                </td>
                            </tr>

                        </c:forEach>

                    </tbody>
                </c:when>
                <c:otherwise>
                    <c:out value="NO DATA FOUND"/>
                </c:otherwise>
            </c:choose>
        </table><br>
        <br>
    </center>
</body>
</html>

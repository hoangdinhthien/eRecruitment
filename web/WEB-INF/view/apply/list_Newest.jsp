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
        <h1>Newest Applications</h1> <br>
        <c:choose>
            <c:when test="${not empty list0  }">
                <table class="table table-striped" border="1" cellspacing="0" cellpadding="4">
                    <nav class="header__menu">
                        <ul>
                            <li><a href="<c:url value="apply?op=sortByCanASCNewest"/>"> Sort by Can Id </a>
                                <ul class="header__menu__dropdown">
                                    <li><a href="apply?op=sortByCanASCNewest">Can Id Ascending</a></li>
                                    <li><a href="apply?op=sortByCanDESCNewest">Can Id Descending</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                   
                    <thead>
                        <tr>
                            <th>No.</th><th>Can_id</th><th>Job Name</th>
                            <th>Email</th><th>File Upload</th>

                            <!--                    <th>Interview Score</th>-->
                            <!--<th>Status</th>-->
                            <th style="text-align: center">Operations</th>    
                        </tr>
                    </thead>
                    <c:forEach var="can" items="${list0}" varStatus="loop">
                        <tr>
                            <td style="text-align: left;"><fmt:formatNumber value="${loop.count}" pattern="000" /></td>
                            <td>${can.id}</td>
                            <td>${can.jobname.job_name}</td>
                            <td>${can.email}</td>
                            <td>${can.cv}</td>
<!--                            <td><c:choose>
                                    <c:when test="${can.isStatus==0}">
                                        Hasn't Accepted
                                    </c:when>
                                </c:choose></td>-->
                            <td style="text-align: center">
                                <a href="apply?op=downloadFile&fileName=${can.cv}">Download</a> |
                                <a href="apply?op=yesupNewest&can_id=${can.id}&email=${can.email}">Accept</a> |
                                <a href="apply?op=deleteFile&can_id=${can.id}&email=${can.email}">Reject</a> 
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

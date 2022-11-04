<%-- 
    Document   : view
    Created on : Oct 5, 2022, 4:27:07 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<c:url value="/css/style.css"/>" type="text/css">
        <title>JSP Page</title>

    </head>
    <body>
        <main class=" user-profile">
            <h2>My profile</h2>
            <div class="container">
                <div class="row">
                    <!-- ben trai  -->
                    <div class="col-2">
                        <figure>
                            <img src="${info.picture}" alt="Not Found" class="user-img" onerror="this.src='<c:url value="/cvs/default.jpg"/>';"/> 
                        </figure>

                        <!-- user name -->
                        <h4>User name</h4>
                    </div>

                    <!--ben phai-->
                    <div class="col-10">
                        <div class="user-content">
                            <h5 class="user-content-item">
                                Email: ${user.email}
                            </h5>
                            <h5 class="user-content-item">
                                Name: ${user.name}
                            </h5>
                            <h5 class="user-content-item">
                                Phone Number: ${user.phone}
                            </h5>
                            <h5 class="user-content-item">
                                Address: ${user.address}
                            </h5>
                            <c:if test="${user.roleId!=5}">
                                <h5 class="user-content-item">
                                    Role: <c:forEach items="${listRole}" var="role">
                                        <c:if test="${role.id==user.roleId}">${role.name}</c:if>
                                    </c:forEach>
                                </h5>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="account-management">
            <h3>
                Account management
            </h3>

            <span class="account-management-item">-Edit your info <button onclick="document.querySelector('dialog').showModal()" >Update </button></span>
            <dialog >
                <p>Update Infomation</p>
                <form action="<c:url value="/user"/>" method="post">
                    <input type="hidden" value="${user.email}" name="email"/>
                    <input class="input" type="text" value="${user.name}" name="name" placeholder="Name"/><br/>
                    <input class="input" type="text" value="${user.phone}" name="phone" placeholder="Phone Number" pattern="[0]{1}[1-9]{1}[0-9]{8}"/><br/>
                    <input class="input" type="text" value="${user.address}" name="address" placeholder="address"/><br/>
                    <input type="hidden" name="op" value="updatehandler"/>
                    <button type="submit" >Update</button>
                </form> 
                <button onclick="document.querySelector('dialog').close()" class="btn btn-secondary"  >Cancel</button>
            </dialog>
        </div>
        <div class="account-management">
            <h3>
                My Application
            </h3>

            <table class="table table-striped" border="1" cellspacing="0" cellpadding="4">      
                <c:choose>
                    <c:when test="${not empty listEmail}">
                        <thead>
                            <tr>
                                <th>No.</th><th>Job Name</th>
                                <th>File Upload</th>
                                <th>Exam Score</th>
                                <!--                    <th>Interview Score</th>-->
                                <th>Status</th><th style="text-align: center">Operations</th>    
                            </tr>
                        </thead>
                        <c:forEach var="can" items="${listEmail}" varStatus="loop">
                            <tr>
                                <td style="text-align: center;"><fmt:formatNumber value="${loop.count}" pattern="000" /></td>
                                <td>${can.jobname.job_name}</td>
                                <td>${can.cv}</td>
                                <td>${can.score}</td>
                                <td><c:choose>
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
                                    <a href="apply?op=downloadFile&fileName=${can.cv}">Download</a> |
                                    <a href="apply?op=deleteFile&can_id=${can.id}">Delete</a> 
                                    <c:if test="${can.isStatus==1}">
                                       | <a href="exam?op=confirmExam&canId=${can.id}">Attempt Exam</a>
                                    </c:if>
                            </tr>

                        </c:forEach>

                        </tbody>
                    </c:when>
                    <c:otherwise>
                        <c:out value="NO DATA FOUND"/>
                    </c:otherwise>
                </c:choose>
            </table>
        </div>

        <!--                <table>
                            <tbody>
                                <tr>
                                    <td>
                                        Email :
                                    </td>
                                    <td>
        ${user.email}
    </td>
</tr>
<tr>
    <td>
        Name :
    </td>
    <td>
        ${user.name}
    </td>
</tr>
        <%--<c:if test="${user.role_id!=4}">--%>
            <tr>
                <td>
                    Role :
                </td>
                <td>
        ${user.roleId}
    </td>
</tr>
        <%--</c:if>--%>
        <tr>
            <td>
                Phone Number :
            </td>
            <td>
        ${user.phone}
    </td>
</tr>
<tr>
    <td>
        Address : 
    </td> 
    <td>
        ${user.address}
    </td>
</tr>
</tbody>
</table>-->
    </body>
</html>

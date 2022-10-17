<%-- 
    Document   : interview_schedule
    Created on : Oct 14, 2022, 10:05:34 AM
    Author     : Thien's
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="<c:url value="/css/thien.css"/>" rel="stylesheet" type="text/css"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Interview Schedule</title>
    </head>
    <body>
        <div class="container">
            <c:if test="${not empty interview}">
                <div class="row">
                    <nav class="interview-table">
                        <ul>
                            <li style="padding-left: 30px;">Name</li>
                            <li style="padding-left: 50px;">Interview's Date</li>
                            <li >Location</li>
                            <li style="padding-left: -20px;">Status</li>
                        </ul>
                    </nav>
                </div>
                <div class="">
                    <nav class="interview-table-content">
                        <c:forEach var="i" items="${interview}" varStatus="loop">
                            <div style="border-radius: 10px;border: 3px solid pink; padding-bottom: 0;margin-bottom: 50px;">
                                <div class="set-can" style="padding-top: 30px ; padding-bottom: 80px;">
                                    <div class="form-popup-cv form-container-cv" id="myForm${loop.count}">
                                        <button type="button" class="btn cancel" onclick="closeForm(${loop.count})">Close</button>
                                        <embed
                                            type="application/pdf"
                                            src=""
                                            frameBorder="0"
                                            scrolxling="auto"
                                            height="500px"
                                            width="80%"
                                            >
                                    </div>
                                    <ul class="">
                                        <li style="text-align: left">${i.can_name}</li>
                                        <li><fmt:formatDate value="${i.date}" pattern="dd-MM-yyyy HH:mm"/></li>
                                        <li>${i.location}</li>
                                            <c:if test="${i.status=='Expired'}">
                                            <li style="color: red">${i.status}</li>
                                            </c:if>
                                            <c:if test="${i.status=='Has Interviewed'}">
                                            <li style="color: #007fff">${i.status}</li>
                                            </c:if>
                                            <c:if test="${i.status=='Hasn\'t Interviewed'}">
                                            <li style="color: #EDBB0E">${i.status}</li>
                                            </c:if>
                                    </ul>
                                    <button class="interview-table-content-btn " onclick="openForm(${loop.count})">View CV</button>
                                </div>
                                <c:if test="${i.status=='Hasn\'t Interviewed'}">
                                    <div class="interview-record set-can" style="text-align: left;">
                                        <textarea rows="5" cols="100" name="comment" form="record" placeholder="Enter text here..."
                                                  required></textarea>
                                        <form id="record">
                                            <input type="number" name="score" value="${score}" min='0' max='100' required=""
                                                   style="width: 5%"/> &nbsp; /100
                                            <button type="submit" class="interview-record-btn">Submit</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </nav>
                </div>
            </c:if>
            <c:if test="${empty interview}">
                <h2>There's no interview's schedule!</h2>
            </c:if>
        </div>
        <script>
            function openForm(count) {
                document.getElementById("myForm" + count).style.display = "block";
            }

            function closeForm(count) {
                document.getElementById("myForm" + count).style.display = "none";
            }
        </script>
    </body>
</html>

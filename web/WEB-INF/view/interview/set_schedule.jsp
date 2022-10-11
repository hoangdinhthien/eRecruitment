<%-- 
    Document   : set-schedule
    Created on : Sep 29, 2022, 10:33:41 AM
    Author     : Thien
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
        <%--css--%>
        <link rel="stylesheet" href="<c:url value='/css/thien.css'/>" type="text/css">
    </head>
    <body>
        <div class="container">
            <form action="<c:url value="/interview"/>" style="float: left; width: 100%;text-align: left;margin-top: 2%">
                <select name="major_id">
                    <c:forEach var="major" items="${listOfMajor}">
                        <c:choose>
                            <c:when test="${not empty choosenMajor}">
                                <option ${choosenMajor == major.major_id?'selected':''} value="${major.major_id}">${major.major_name}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${major.major_id}">${major.major_name}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <button type="submit" name="op" value="set_schedule_handler">Filter</button>
            </form>
            <c:if test="${not empty sublist}">
                <div class="container" style="margin: 10% 0% 5% 0%; ">
                    <div class="row" style="position: relative">
                        <c:forEach var="can" items="${sublist}">
                            <div class="col-md-6" style="padding: 2% 2% 5% 5%;text-align: left;background-color: #d1ecf1">
                                <h3>
                                    Name: ${can.name} <br/>
                                </h3> 
                                <p>
                                    Email: ${can.email} <br/>
                                </p>    
                                <p>
                                    Major: ${listOfMajor[choosenMajor-1].major_name} <br/>
                                </p>
                                <p>
                                    Phone:${can.phone} <br/>
                                </p>
                            </div>
                        </c:forEach>
                        <!--<a href="#" class="btn" style="float: right">Set Schedule</a>-->
                        <!--<button style="float: right">Set Schedule</button>-->
                        <button class="open-button" onclick="openForm()" style="float: right">Set Schedule</button>

                        <div class="form-popup" id="myForm">
                            <form action="/action_page.php" class="form-container">
                                <h1>Login</h1>

                                <label for="email"><b>Email</b></label>
                                <input type="text" placeholder="Enter Email" name="email" required>

                                <label for="psw"><b>Password</b></label>
                                <input type="password" placeholder="Enter Password" name="psw" required>

                                <button type="button" class="btn cancel" onclick="closeForm()" style="float: right">Close</button><br/>
                                <button type="submit" class="btn" style="">Login</button>
                            </form>
                        </div>
                    </div>
                </div>
                <ul class="pagination">
                    <c:forEach var="p" items="${noOfPage}" varStatus="loop">
                        <li class="${page == loop.count?'active':''}">
                            <a href="<c:url value="/interview?op=set_schedule_handler&major_id=${major_id}&page=${loop.count}"/>">${loop.count}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>

        <%--//Script--%>
        <script>
            function openForm() {
                document.getElementById("myForm").style.display = "block";
            }

            function closeForm() {
                document.getElementById("myForm").style.display = "none";
            }
        </script>
    </body>
</html>

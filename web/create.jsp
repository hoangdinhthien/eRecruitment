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
    </head>
    <body>
        <form id="mainform" onsubmit="return validateForm()">
            <input type="text" placeholder="Question" name="question" required="true"/><br/>
            <select name="major">
                <option value="123">dcmvcl</option>
                <c:forEach var="major" items="${listMajor}">
                    <option value="${major.major_id}">${major.major_id}</option>
                </c:forEach>
            </select>
            
            <hr/>
            <div id = "main">
                <input type="radio" value="1" class="radoOption" name="correctOptions" required="true"/><input type="text" placeholder="Name" class="someInput" name="option1" required="true"/>
                <br>
                <input type="radio" value="2" class="radoOption" name="correctOptions" required="true"/><input type="text" placeholder="Name" class="someInput" name="option2" required="true"/>
                <br>
            </div>
            <input type="hidden" id="countInput" name="count" value="2"/>
            <input type="button" id="addButton" value="Add" onclick="add(2)" />
            <input type="button" id="removeButton" value="Remove" onclick="remove(2)" hidden="true"/>
            <input type="submit"/>
        </form>

        <script src="script.js"></script> 
    </body>
</html>
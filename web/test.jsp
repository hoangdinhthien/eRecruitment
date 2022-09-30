
<%-- 
    Document   : test
    Created on : Sep 27, 2022, 3:26:24 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form id="mainform" onsubmit="return validateForm()">
            <div id = "main">
                <input type="radio" value="1" class="radoOption" name="options" required="true"/><input type="text" placeholder="Name" class="someInput" name="1" required="true"/>
                <br>
                <input type="radio" value="2" class="radoOption" name="options" required="true"/><input type="text" placeholder="Name" class="someInput" name="2" required="true"/>
                <br>
            </div>
            <input type="button" id="addButton" value="Add" onclick="add(2)" />
            <input type="button" id="removeButton" value="Remove" onclick="remove(2)" hidden="true"/>
            <input type="submit"/>
        </form>

        <script src="script.js"></script> 
    </body>
</html>
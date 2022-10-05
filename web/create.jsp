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
<!--        <link href="<c:url value="/site2.css"/>" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .opbutton {
                padding: 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 2px 2px;
                cursor: pointer;
                border-radius: 8px;
            }
        </style>

    </head>
    <body>
        <div class="container">
            <form action="<c:url value="/ExamController"/>" id="mainform" onsubmit="return validateForm()">
                <textarea type="text" placeholder="Question" name="question" cols="100" rows="5" size ="1000" style="resize: none;" required="true"></textarea><br/>
                <select name="major">
                    <c:forEach var="major" items="${listMajor}">
                        <option value="${major.major_id}">${major.major_name}</option>
                    </c:forEach>
                </select>

                <hr/>
                <table>
                    <tbody id = "main">
                        <tr>
                            <td class="text-center" >
                                <input type="radio" value="1"  name="correctOptions" required="true"/>
                            </td>
                            <td class="text-center" >
                                <input type="text" placeholder="Option"  style="width: 680px;" name="option1" required="true"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-center" >
                                <input type="radio" value="2" class="radoOption" name="correctOptions" required="true"/>
                            </td >
                            <td>
                                <input type="text" placeholder="Option" style="width: 680px;" class="someInput" name="option2" required="true"/>
                            </td>
                        </tr>
                    </tbody>
                    <input type="hidden" id="countInput" name="count" value="2"/>
                    <tr>
                        <td class="text-center" >
                            <input type="button" id="addButton" class="opbutton" value="+" onclick="add(2)" />
                        </td>
                        <td >
                            <input type="button" id="removeButton"  value="-" onclick="remove(2)" hidden="true"/>
                        </td>
                    </tr>
                </table>
                <input type="submit" name="action" value="Create">
            </form>
        </div>

        <script src="script.js"></script> 
    </body>
</html>
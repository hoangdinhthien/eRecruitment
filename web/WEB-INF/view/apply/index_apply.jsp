<%-- 
    Document   : index_apply
    Created on : Oct 18, 2022, 8:06:22 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="apply" method="post" enctype="multipart/form-data">
            <table width="400px" align="center" border=2>
                <tr>
                    <td align="center" colspan="2">Form Details</td>
                </tr>
                <tr>
                    <td>Select File :</td>
                    <td>
                        <input type="file" required="" name="file">
                    </td>
                </tr>
                <tr style="text-align: center">
                <c:if test="${requestScope.msg!=null}">
                    <h3><c:out value="${requestScope.msg}"></c:out></h3>
                </c:if><br>
                <br>
                <c:if test="${sessionScope.fileName!=null}">
                    <c:set var="file" scope="session" value="${sessionScope.fileName}"/>
                </c:if>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="op" value="uploadFile"></td>
                </tr>
            </table> 

        </form>
    </body>
</html>

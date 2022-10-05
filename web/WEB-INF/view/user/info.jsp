<%-- 
    Document   : view
    Created on : Oct 5, 2022, 4:27:07 PM
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
        <table>
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
            <c:if test="${user.role_id!=4}">
                <tr>
                    <td>
                        Role :
                    </td>
                    <td>
                        ${user.role_id}
                    </td>
                </tr>
            </c:if>
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
    </table>
</body>
</html>

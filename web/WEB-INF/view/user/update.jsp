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
        <form action="<c:url value="/user/updateHandler.do"/>">
            <table>
                <tbody>
                    <tr>
                        <td>
                            Email :
                        </td>
                        <td>
                            ${user.email}
                            <input type="hidden" value="${user.email}" name="email"/>
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
                            <input type="text" value="${user.phone}" name="phone" placeholder="Phone Number" pattern="[0]{1}[1-9]{2}[0-9]{8}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address : 
                        </td> 
                        <td>
                            <input type="text" value="${user.address}" name="address" placeholder="address"/>
                        </td>
                    </tr>
                </tbody>
                <tr>
                        <td>
                            <input type="hidden" name="action" value="updateHandler"/>
                        </td> 
                        <td>
                            <input type="submit" />
                        </td>
                    </tr>
            </table>
        </form>
    </body>
</html>

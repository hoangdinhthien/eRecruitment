<%-- 
    Document   : index
    Created on : Sep 23, 2022, 9:35:34 AM
    Author     : Thien's
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty info}">
                Id: ${info.id} <br/>
                Email: ${info.email}<br/>
                Verified-Email: ${info.verified_email}<br/>
                Name: ${info.name}<br/>
                Given Name: ${info.given_name}<br/>
                Family Name: ${info.family_name}<br/>
                Picture: <img alt="" src="${info.picture}"><br/>
            </c:when>
            <c:otherwise>
                <a href="https://accounts.google.com/o/oauth2/auth?scope=email  profile&redirect_uri=http://localhost:8084/recruitment-system/login&response_type=code
                   &client_id=779040387699-c58vkqmlf6cmvtv3som469pl5k78lgar.apps.googleusercontent.com&approval_prompt=force">Login With Google</a> 
            </c:otherwise>
        </c:choose>
    </body>
</html>

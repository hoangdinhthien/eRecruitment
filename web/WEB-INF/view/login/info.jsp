<%-- 
    Document   : info
    Created on : Sep 22, 2022, 1:35:10 PM
    Author     : Thien's
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        Id: ${info.id} <br/>
        Email: ${info.email}<br/>
        Verified-Email: ${info.verified_email}<br/>
        Name: ${info.name}<br/>
        Given Name: ${info.given_name}<br/>
        Family Name: ${info.family_name}<br/>
        Link: ${info.link}<br/>
        phone: ${info.phone}<br/>
        Picture: <img alt="" src="${info.picture}"><br/>
    </body>
</html>

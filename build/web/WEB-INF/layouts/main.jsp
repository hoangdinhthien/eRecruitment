<%-- 
    Document   : main
    Created on : Sep 23, 2022, 9:34:15 AM
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
        <div class="container-fluid text-center row ">
            <div class="col" style="min-height: 500px">
                <jsp:include page="/WEB-INF/view/${controller}/${action}.jsp"/>
            </div>
        </div>
    </body>
</html>

<%-- 
    Document   : result
    Created on : Oct 15, 2022, 2:33:55 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        
        <style>
            .result{
                text-align: center;
                padding: 25px 0;
            }
        </style>
        
    </head>
    <body>

        <div class="container">
            <div class="result">
                <h2>${message}</h2>
                <a class="return-home-btn" href="<c:url value="/exam?op=QuestionBank"/>">
                    <button class=" btn btn-info">Return to home page</button>
                </a>
            </div>
        </div>

    </body>
</html>

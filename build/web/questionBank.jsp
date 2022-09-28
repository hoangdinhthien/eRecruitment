<%-- 
    Document   : questionBank
    Created on : Sep 27, 2022, 3:12:55 PM
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

        <form id = "test">

        </form>
        <br>

        <p>Click the button to add a "Kiwi" option at the end of the dropdown list.</p>

        <button type="button" onclick="myFunction()">Insert option</button>

        <script>
            function myFunction() {
                var x = document.getElementById("test");
                var option = document.createElement("input");
                option.setAttribute("type", "text");
                option.setAttribute("value", "Hello World!");
                var br = document.createElement("br");
                x.appendChild(option);
                x.appendChild(br)
            }
        </script>

    </body>
</html>
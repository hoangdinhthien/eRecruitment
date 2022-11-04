<%-- 
    Document   : index_apply
    Created on : Oct 18, 2022, 8:06:22 PM
    Author     : ADMIN
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <div class="container" style="text-align: left">

            <form  action="<c:url value="/apply?op=uploadFile"/>" enctype="multipart/form-data" method="post">
                <input type="hidden" value="${job_id}" name="job_id">
                <input type="hidden" value="${cv}" name="cv">
                <p>Select Your CV:</p>
                <div class="custom-file mb-3" style="width: 45%">
                    <input type="file" class="custom-file-input" id="customFile" name="filename" accept="image/*" onchange="validateFileType()">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
                <i>*Only accept image file</i>>
                <div >
                    <button type="submit" class="btn btn-success" id="submitbutton">Apply CV</button>
                </div>
            </form>

        </div>
        <c:if test="${not empty cv}">
            <script>
                $(".custom-file-input").siblings(".custom-file-label").addClass("selected").html("${cv}");
            </script>
        </c:if>
        <script>
// Add the following code if you want the name of the file appear on select
//            $(document).ready(function () {
//                $(".custom-file-input").siblings(".custom-file-label").addClass("selected").html(${cv});
//            });
            $(".custom-file-input").on("change", function () {
                var fileName = $(this).val().split("\\").pop();
                $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
            });
            function validateFileType() {
                var fileName = document.getElementById("files").value;
                var idxDot = fileName.lastIndexOf(".") + 1;
                var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();
                if (extFile == "jpg" || extFile == "jpeg" || extFile == "png"
                        || extFile == "apng" || extFile == "avif" || extFile == "jfif"
                        || extFile == "pjpeg" || extFile == "pjp" || extFile == "svg"
                        || extFile == "webp") {
                    document.getElementById('submitbutton').disabled = false;
                } else {
                    alert("Only image files are allowed (except .gif file)!");
                    document.getElementById('submitbutton').disabled = true;
                }
            }
        </script>
    </body>
</html>

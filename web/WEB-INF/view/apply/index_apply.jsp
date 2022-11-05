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
    </head>
    <body>
        <form action="<c:url value='apply'/>" method="post" name="myForm"  enctype="multipart/form-data" >

            <table width="400px" align="center" border=2>
                <tr>
                    <td align="center" colspan="2">Form Details</td>
                </tr>
                <tr>
                <input type="hidden" value="uploadFile" name="op">
                <input type="" value="${job_id}" name="job_id">
                <input type="" value="${job_name}" name="job_name">
                <td>Select File :</td>
                <td>

                    <input type="file" required="" name="file" accept="image/*" >
                </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <!--<button type="submit" name="op" value="uploadFile">Upload File</button>-->
                        <button
                            <c:choose>
                                <c:when test="${not empty info}"> href="<c:url value="/apply?op=index&job_id=${job.job_id}&job_name=${job.job_name}"/>"
                                </c:when>
                                <c:otherwise>  href="<c:url value="https://accounts.google.com/o/oauth2/auth?scope=email  profile&redirect_uri=http://localhost:8084/recruitment-system/login?op=login&response_type=code&client_id=779040387699-c58vkqmlf6cmvtv3som469pl5k78lgar.apps.googleusercontent.com&approval_prompt=force"/>"</c:otherwise> 
                            </c:choose>>Apply
                        </button>
                    </td>
                </tr>
            </table> 

        </form>
    </body>
</html>

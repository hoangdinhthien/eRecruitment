<%-- 
    Document   : update_job
    Created on : Oct 28, 2022, 9:03:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            textarea {
                resize: none;
            }
        </style>
        <script>
            function validateForm() {
                var x = document.forms["myForm"]["job_id"].value;
                var y = document.forms["myForm"]["job_name"].value;
                var z = document.forms["myForm"]["job_vacancy"].value;
                var a = document.forms["myForm"]["job_description"].value;
                var b = document.forms["myForm"]["salary"].value;
//                if (x == "" || x == null) {
//                    alert("ID must be filled out");
//                    return false;
//                }
                if (y == "" || y == null) {
                    alert("Name must be filled out");
                    return false;
                }
                if (z == "" || z == null) {
                    alert("Vacancy must be filled out");
                    return false;
                }
                if (a == "" || a == null) {
                    alert("Description must be filled out");
                    return false;
                }
                if (b == "" || b == null) {
                    alert("Salary must be filled out");
                    return false;
                }
//                if (!/^[a-zA-Z]*$/g.test(document.myForm.job_description.value)) {
//                    alert("Invalid job description");
//                    document.myForm.job_description.focus();
//                    return false;
//                }
            }
        </script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">-->

    </head>
    <body>
        <a class="link" style="float: right" href="<c:url value="/job?op=delete_job&job_id=${job.job_id}"/>">Delete job</a><br/>
        <div class="container " >
            <div class="input-group " style="justify-content: center; align-items: center;">
                <form action="<c:url value="/job"/>" style="" name="myForm" onsubmit="return validateForm()" method="post" required >
                    <input placeholder="Enter Job ID" class="form-control" type="hidden" name="job_id" min="0" value="${job.job_id}" />
                    <div class="input-group mb-3">
                        <span class="input-group-text" >Job name:</span>
                        <input placeholder="Enter Job Name" class="form-control" type="text" name="job_name" value="${job.job_name}"/>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Major ID:</span>
                        <select name="major_id" class="form-control">
                            <option value="1"<c:if test="${job.major_id==1}">selected="true"</c:if>>Marketing</option>
                            <option value="2"<c:if test="${job.major_id==2}">selected="true"</c:if>>Logistic</option>
                            <option value="3"<c:if test="${job.major_id==3}">selected="true"</c:if>>Data Science and Analytics</option>
                            <option value="4"<c:if test="${job.major_id==4}">selected="true"</c:if>>Information Technology</option>
                            <option value="5"<c:if test="${job.major_id==5}">selected="true"</c:if>>Graphic Design</option>
                            <option value="6"<c:if test="${job.major_id==6}">selected="true"</c:if>>Engineering</option>
                            <option value="7"<c:if test="${job.major_id==7}">selected="true"</c:if>>Risk Manager</option>
                            <option value="8"<c:if test="${job.major_id==8}">selected="true"</c:if>>Economic Finance</option>
                            <option value="9"<c:if test="${job.major_id==9}">selected="true"</c:if>>Business Intelligence and Development</option>
                            <option value="10"<c:if test="${job.major_id==10}">selected="true"</c:if>>Operations</option>
                            </select>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">Job vacancy:</span>
                            <input placeholder="Enter Job Vacancy" class="form-control" type="number" name="job_vacancy" min="0" cols="50" value="${job.job_vacancy}"/>
                    </div>
                    <div class="input-group mb-3" s>
                        <span class="input-group-text">Job Description</span>
                        <textarea placeholder="Enter Job Description" class="form-control" type="text" name="job_description" rows="1" cols="50">${job.job_description}</textarea>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Level ID:</span>
                        <select name="level_id" class="form-control">
                            <option value="1"<c:if test="${job.level_id==1}">selected="true"</c:if>>Intern</option>
                            <option value="2"<c:if test="${job.level_id==2}">selected="true"</c:if>>Fresher</option>
                            <option value="3"<c:if test="${job.level_id==3}">selected="true"</c:if>>Junior</option>
                            <option value="4"<c:if test="${job.level_id==4}">selected="true"</c:if>>Senior</option>
                            <option value="5"<c:if test="${job.level_id==5}">selected="true"</c:if>>Manager</option>
                            <option value="6"<c:if test="${job.level_id==6}">selected="true"</c:if>>Leader</option>
                            </select><br/>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">Salary:</span>
                            <input placeholder="Enter Job Salary" class="form-control" type="number" name="salary" min="0" value="${job.salary}"/>
                    </div>
                    <button class="btn btn-primary" type="submit" name="op" value="update_job_handler">Change</button>
                </form>
            </div>
        </div>
    </body>
</html>


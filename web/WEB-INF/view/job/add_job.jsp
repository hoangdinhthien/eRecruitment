<%-- 
    Document   : add_job
    Created on : Oct 13, 2022, 4:20:11 PM
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
                if (x == "" || x == null) {
                    alert("ID must be filled out");
                    return false;
                }
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
                if (!/^[a-zA-Z &nbsp]*$/g.test(document.myForm.job_name.value)) {
                    alert("Invalid job name");
                    document.myForm.job_name.focus();
                    return false;
                }
//                if (!/^[a-zA-Z &nbsp\p{Punct}?]*$/g.test(document.myForm.job_description.value)) {
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
        <div class="container " >
            <div class="input-group " style="justify-content: center; align-items: center;">

                <form action="<c:url value="/job"/>" style="" name="myForm" onsubmit="return validateForm()" method="post" required >
                    <div class="input-group mb-3">
                        <span class="input-group-text">Job ID:</span>    
                        <input placeholder="Enter Job ID" class="form-control" type="number" name="job_id" min="0"/>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text" >Job name:</span>
                        <input placeholder="Enter Job Name" class="form-control" type="text" name="job_name"/>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Major ID:</span>
                        <select name="major_id" class="form-control ">
                            <option value="1">Marketing</option>
                            <option value="2">Logistic</option>
                            <option value="3">Data Science and Analytics</option>
                            <option value="4">Information Technology</option>
                            <option value="5">Graphic Design</option>
                            <option value="6">Engineering</option>
                            <option value="7">Risk Manager</option>
                            <option value="8">Economic Finance</option>
                            <option value="9">Business Intelligence and Development</option>
                            <option value="10">Operations</option>
                        </select>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Job vacancy:</span>
                        <input placeholder="Enter Job Vacancy" class="form-control" type="number" name="job_vacancy" min="0" cols="50"/>
                    </div>
                    <div class="input-group mb-3" s>
                        <span class="input-group-text">Job Description</span>
                        <textarea placeholder="Enter Job Description" class="form-control" type="text" name="job_description" rows="1" cols="50"></textarea>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Level ID:</span>
                        <select name="level_id" class="form-control ">
                            <option value="1">Intern</option>
                            <option value="2">Fresher</option>
                            <option value="3">Junior</option>
                            <option value="4">Senior</option>
                            <option value="5">Manager</option>
                            <option value="6">Leader</option>
                        </select><br/>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Salary:</span>
                        <input placeholder="Enter Job Salary" class="form-control" type="number" name="salary" min="0"/>
                    </div>
                    <button class="btn btn-primary" type="submit" name="op" value="add_job_handler">ADD</button>
                </form>
            </div>
        </div>
    </body>
</html>



<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        body {font-family: Arial, Helvetica, sans-serif;}
        * {box-sizing: border-box;}

        /* Set a style for all buttons */
        button {
            background-color: #04AA6D;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            opacity: 0.9;
        }

        button:hover {
            opacity:1;
        }

        /* Float cancel and delete buttons and add an equal width */
        .cancelbtn, .deletebtn {
            float: left;
            width: 50%;
        }

        /* Add a color to the cancel button */
        .cancelbtn {
            background-color: #ccc;
            color: black;
        }

        /* Add a color to the delete button */
        .deletebtn {
            background-color: #f44336;
        }

        /* Add padding and center-align text to the container */
        .container {
            padding: 16px;
            text-align: center;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 40%; /* Full width */
            height: 25%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: powderblue;
            padding-top: 50px;
            /*position: absolute;*/
            top:0;
            bottom: 0;
            left: 0;
            right: 0;
            
            margin: auto;
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        /* Style the horizontal ruler */
        hr {
            border: 1px solid #f1f1f1;
            margin-bottom: 25px;
        }

        /* The Modal Close Button (x) */
        .close {
            position: absolute;
            right: 35px;
            top: 15px;
            font-size: 40px;
            font-weight: bold;
            color: #f1f1f1;
        }

        .close:hover,
        .close:focus {
            color: #f44336;
            cursor: pointer;
        }

        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

        /* Change styles for cancel button and delete button on extra small screens */
        @media screen and (max-width: 300px) {
            .cancelbtn, .deletebtn {
                width: 100%;
            }
        }
    </style>
    <body>

        <h2>Delete Modal</h2>

        <button onclick="document.getElementById('id01').style.display = 'block'">Open Modal</button>

        <div id="id01" class="modal">
            <span onclick="document.getElementById('id01').style.display = 'none'" class="close" title="Close Modal">×</span>
            <form action="<c:url value='apply'/>" method="post"  enctype="multipart/form-data" >
             
            <table width="400px" align="center" border=2>
                <tr>
                    <td align="center" colspan="2">Form Details</td>
                </tr>
                <tr>
                    <input type="hidden" value="uploadFile" name="op">
                    <input type="hidden" value="${job_id}" name="job_id">
                    <td>Select File :</td>
                    <td>
                        
                        <input type="file" required="" name="file">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="op" value="uploadFile"></td>
                </tr>
            </table> 

        </form>
        </div>

        <script>
            // Get the modal
            var modal = document.getElementById('id01');

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>

    </body>
</html>

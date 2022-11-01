<%-- 
    Document   : view
    Created on : Oct 5, 2022, 4:27:07 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<c:url value="/css/style.css"/>" type="text/css">
        <title>JSP Page</title>

    </head>
    <body>
        <main class=" user-profile">
            <h2>My profile</h2>
            <div class="container">
                <div class="row">
                    <!-- ben trai  -->
                    <div class="col-2">
                        <figure>
                            <img src="${info.picture}" class="user-img"/>
                        </figure>

                        <!-- user name -->
                        <h4>User name</h4>
                    </div>

                    <!--ben phai-->
                    <div class="col-10">
                        <div class="user-content">
                            <h5 class="user-content-item">
                                Email: ${user.email}
                            </h5>
                            <h5 class="user-content-item">
                                Name: ${user.name}
                            </h5>
                            <h5 class="user-content-item">
                                Phone Number: ${user.phone}
                            </h5>
                            <h5 class="user-content-item">
                                Address: ${user.address}
                            </h5>
                            <c:if test="${user.roleId!=5}">
                                <h5 class="user-content-item">
                                    Role: <c:forEach items="${listRole}" var="role">
                                        <c:if test="${role.id==user.roleId}">${role.name}</c:if>
                                    </c:forEach>
                                </h5>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="account-management">
            <h3>
                Account management
            </h3>

            <span class="account-management-item">-Edit your info <button onclick="document.querySelector('dialog').showModal()" >Update </button></span>
            <dialog >
                <p>Update Infomation</p>
                <form action="<c:url value="/user"/>" method="post">
                    <input type="hidden" value="${user.email}" name="email"/>
                    <input class="input" type="text" value="${user.name}" name="name" placeholder="Name"/><br/>
                    <input class="input" type="text" value="${user.phone}" name="phone" placeholder="Phone Number" pattern="[0]{1}[1-9]{1}[0-9]{8}"/><br/>
                    <input class="input" type="text" value="${user.address}" name="address" placeholder="address"/><br/>
                    <input type="hidden" name="op" value="updatehandler"/>
                    <button type="submit" >Update</button>
                </form> 
                <button onclick="document.querySelector('dialog').close()" class="btn btn-secondary"  >Cancel</button>
            </dialog>
        </div>

<!--                <table>
                    <tbody>
                        <tr>
                            <td>
                                Email :
                            </td>
                            <td>
        ${user.email}
    </td>
</tr>
<tr>
    <td>
        Name :
    </td>
    <td>
        ${user.name}
    </td>
</tr>
        <%--<c:if test="${user.role_id!=4}">--%>
            <tr>
                <td>
                    Role :
                </td>
                <td>
            ${user.roleId}
        </td>
    </tr>
        <%--</c:if>--%>
        <tr>
            <td>
                Phone Number :
            </td>
            <td>
        ${user.phone}
    </td>
</tr>
<tr>
    <td>
        Address : 
    </td> 
    <td>
        ${user.address}
    </td>
</tr>
</tbody>
</table>-->
    </body>
</html>

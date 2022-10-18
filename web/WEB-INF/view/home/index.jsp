<%-- 
    Document   : index
    Created on : Sep 23, 2022, 9:35:34 AM
    Author     : Thien's
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- Featured Section Begin -->
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="login-content">
                        <h5>
                            Join a dynamic team of 3HTD professionals at
                            one of the world’s leading providers of Audit,
                            Tax and Advisory services.
                        </h5>
                    </div>
                    <c:if test="${empty info}">
                        <div class="row">
                            <div class="col login">
                                <h3>Join Us</h3>
                                <br>
                                <div class="google-btn">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email  profile&redirect_uri=http://localhost:8084/recruitment-system/login?op=login&response_type=code&client_id=779040387699-c58vkqmlf6cmvtv3som469pl5k78lgar.apps.googleusercontent.com&approval_prompt=force">
                                        <div class="google-icon-wrapper">
                                            <img class="google-icon"
                                                 src="https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg" />
                                        </div>
                                        <p class="btn-text"><b>Sign in with google</b></p>
                                    </a>
                                </div>
                                <h5>-----------OR-----------</h5>
                                <p>You are our staff ?</p>
                                <button class="login-staff-btn">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email  profile&redirect_uri=http://localhost:8084/recruitment-system/login?op=login&response_type=code&client_id=779040387699-c58vkqmlf6cmvtv3som469pl5k78lgar.apps.googleusercontent.com&approval_prompt=force">
                                        STAFF
                                    </a>
                                </button>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div style="border-radius: 10px;" class="hero__item set-bg col-lg-9"
                     data-setbg="img/banner/recruitment-banner-2.jpg">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Find Your Passion</h2>
                    </div>
                    <ul class="department-list">
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                        <li class="department-item">
                            <div class="department-item-title">Business Development and Partnerships</div>
                            <div class="department-item-count">66 opening</div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>


        <!-- Js Plugins -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.nice-select.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/popUp.js"></script>


    </body>
</html>

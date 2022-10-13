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
        <!--         Page Preloder 
                <div id="preloder">
                    <div class="loader"></div>
                </div>
        
                 Humberger Begin 
                <div class="humberger__menu__overlay"></div>
                <div class="humberger__menu__wrapper">
                    <div class="humberger__menu__logo">
                        <a href="#"><img src="img/logo.png" alt=""></a>
                    </div>
                    <div class="humberger__menu__cart">
                        <ul>
                            <li><i class="fa fa-bell"></i></li>
                        </ul>
                    </div>
                    <div class="humberger__menu__widget">
                        <div class="header__top__right__auth">
                            <a href="#" class="popup" onclick="popUp1()"><i class="fa fa-user"></i> Login
                                <span class="popuptext" id="myPopup1">A Simple Popup!</span>
                            </a>
                        </div>
                    </div>
                    <nav class="humberger__menu__nav mobile-menu">
                        <ul>
                            <li class="active"><a href="./index.html">Home</a></li>
                            <li><a href="./shop-grid.html">Jobs</a></li>
                            <li><a href="#">Pages</a>
                                <ul class="header__menu__dropdown">
                                    <li><a href="./shop-details.html">Shop Details</a></li>
                                    <li><a href="./shoping-cart.html">Shoping Cart</a></li>
                                    <li><a href="./checkout.html">Check Out</a></li>
                                    <li><a href="./blog-details.html">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="./blog.html">About Us</a></li>
                            <li><a href="./contact.html">Contact</a></li>
                        </ul>
                    </nav>
                    <div id="mobile-menu-wrap"></div>
                    <div class="header__top__right__social">
                        <a href="#"><i class="fa fa-facebook"></i></a>
                        <a href="#"><i class="fa fa-twitter"></i></a>
                        <a href="#"><i class="fa fa-linkedin"></i></a>
                        <a href="#"><i class="fa fa-pinterest-p"></i></a>
                    </div>
                    <div class="humberger__menu__contact">
                        <ul>
                            <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
                            <li>Free Shipping for all Order of $99</li>
                        </ul>
                    </div>
                </div>
                 Humberger End 
        
                 Header Section Begin 
                <header class="header">
                    <div class="header__top">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-6 col-md-6">
                                    <div class="header__top__left">
                                        <ul>
                                            <li><i class="fa fa-envelope"></i> hello@colorlib.com</li>
                                            <li>Free Shipping for all Order of $99</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <div class="header__top__right">
                                        <div class="header__top__right__social">
                                            <a href="#"><i class="fa fa-facebook"></i></a>
                                            <a href="#"><i class="fa fa-twitter"></i></a>
                                            <a href="#"><i class="fa fa-linkedin"></i></a>
                                            <a href="#"><i class="fa fa-pinterest-p"></i></a>
                                        </div>
                                        <div class="header__top__right__auth">
                                            <div href="#" class="popup" onclick="popUp()"><i class="fa fa-user"></i> Login
                                                <span class="popuptext" id="myPopup">A Simple Popup!</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3">
                                <div class="header__logo">
                                    <a href="./index.html"><img src="img/banner/logo-recruitment2.png" alt=""></a>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <nav class="header__menu">
                                    <ul>
                                        <li class="active"><a href="./index.html">Home</a></li>
                                        <li><a href="./shop-grid.html">Jobs</a></li>
                                        <li><a href="#">Pages</a>
                                            <ul class="header__menu__dropdown">
                                                <li><a href="./shop-details.html">Shop Details</a></li>
                                                <li><a href="./shoping-cart.html">Shoping Cart</a></li>
                                                <li><a href="./checkout.html">Check Out</a></li>
                                                <li><a href="./blog-details.html">Blog Details</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="./blog.html">About Us</a></li>
                                        <li><a href="./contact.html">Contact</a></li>
                                    </ul>
                                </nav>
                            </div>
                            <div class="col-lg-3">
                                <div class="header__cart">
                                    <ul>
                                        <li><i class="fa fa-bell"></i></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="humberger__open">
                            <i class="fa fa-bars"></i>
                        </div>
                    </div>
                </header>
                 Header Section End 
        
                 Hero Section Begin 
                <section class="hero">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3">
                                <li class="dropdown dropdown-1">
                                    <div>
                                        <i class="fa fa-bars"></i>
                                        <span>All departments</span>
                                        <span class="arrow_carrot-down"></span>
                                    </div>
                                    <ul class="dropdown_menu dropdown_menu-1">
                                        <li class="dropdown_item-1"><a href=" #">Fresh Meat</a></li>
                                        <li class="dropdown_item-2"><a href=" #">Vegetables</a></li>
                                        <li class="dropdown_item-3"><a href=" #">Fruit & Nut Gifts</a></li>
                                        <li class="dropdown_item-4"><a href=" #">Fresh Berries</a></li>
                                        <li class="dropdown_item-5"><a href=" #">Ocean Foods</a></li>
                                        <li class="dropdown_item-6"><a href=" #">Butter & Eggs</a></li>
                                        <li class="dropdown_item-7"><a href=" #">Fastfood</a></li>
                                        <li class="dropdown_item-8"><a href=" #">Fresh Onion</a></li>
                                        <li class="dropdown_item-9"><a href=" #">Papayaya & Crisps</a></li>
                                        <li class="dropdown_item-10"><a href=" #">Oatmeal</a></li>
                                        <li class="dropdown_item-11"><a href=" #">Fresh Bananas</a></li>
                                    </ul>
                                </li>
                            </div>
                            <div class="col-lg-9">
                                <div class="hero__search">
                                    <div class="hero__search__form">
                                        <form action="#">
                                            <input type="text" placeholder="What do yo u need?">
                                            <button type="submit" class="site-btn">SEARCH</button>
                                        </form>
                                    </div>
                                    <div class="hero__search__phone">
                                        <div class="hero__search__phone__icon">
                                            <i class="fa fa-phone"></i>
                                        </div>
                                        <div class="hero__search__phone__text">
                                            <h5>+65 11.188.888</h5>
                                            <span>support 24/7 time</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->
        <!-- Hero Section End -->

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
        <!-- <div class="featured__controls">
            <ul>
                <li class="active" data-filter="*">All</li>
                <li data-filter=".oranges">Tên Ngành</li>
                <li data-filter=".fresh-meat">Tên Ngành</li>
                <li data-filter=".vegetables">Tên Ngành</li>
                <li data-filter=".fastfood">Tên Ngành</li>
            </ul>
        </div>
    </div>
</div>
<div class="row featured__filter">
    <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-1.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix vegetables fastfood">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-2.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix vegetables fresh-meat">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-3.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix fastfood oranges">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-4.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix fresh-meat vegetables">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-5.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fastfood">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-6.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix fresh-meat vegetables">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-7.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mix fastfood vegetables">
        <div class="featured__item">
            <div class="featured__item__pic set-bg" data-setbg="img/featured/feature-8.jpg">
                <ul class="featured__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                </ul>
            </div>
            <div class="featured__item__text">
                <h6><a href="#">Crab Pool Security</a></h6>
                <h5>$30.00</h5>
            </div>
        </div>
        -->                    
        <!-- Featured Section End -->

        <!-- Banner Begin -->
        <!-- <div class="banner">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="banner__pic">
                            <img src="img/banner/banner-1.jpg" alt="">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="banner__pic">
                            <img src="img/banner/banner-2.jpg" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Banner End -->

        <!-- Latest Product Section Begin -->
        <!-- <section class="latest-product spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Latest Products</h4>
                            <div class="latest-product__slider owl-carousel">
                                <div class="latest-prdouct__slider__item">
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-1.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-2.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-3.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                </div>
                                <div class="latest-prdouct__slider__item">
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-1.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-2.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-3.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Top Rated Products</h4>
                            <div class="latest-product__slider owl-carousel">
                                <div class="latest-prdouct__slider__item">
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-1.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-2.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-3.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                </div>
                                <div class="latest-prdouct__slider__item">
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-1.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-2.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-3.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="latest-product__text">
                            <h4>Review Products</h4>
                            <div class="latest-product__slider owl-carousel">
                                <div class="latest-prdouct__slider__item">
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-1.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-2.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-3.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                </div>
                                <div class="latest-prdouct__slider__item">
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-1.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-2.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                    <a href="#" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="img/latest-product/lp-3.jpg" alt="">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>Crab Pool Security</h6>
                                            <span>$30.00</span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section> -->
        <!-- Latest Product Section End -->

        <!-- Blog Section Begin -->
        <!-- <section class="from-blog spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title from-blog__title">
                            <h2>From The Blog</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="img/blog/blog-1.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                    <li><i class="fa fa-comment-o"></i> 5</li>
                                </ul>
                                <h5><a href="#">Cooking tips make cooking simple</a></h5>
                                <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam
                                    aliquam quaerat </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="img/blog/blog-2.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                    <li><i class="fa fa-comment-o"></i> 5</li>
                                </ul>
                                <h5><a href="#">6 ways to prepare breakfast for 30</a></h5>
                                <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam
                                    aliquam quaerat </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="img/blog/blog-3.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                    <li><i class="fa fa-comment-o"></i> 5</li>
                                </ul>
                                <h5><a href="#">Visit the clean farm in the US</a></h5>
                                <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam
                                    aliquam quaerat </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section> -->
        <!--Blog Section End--> 

        <!-- Footer Section Begin -->
        <!--                    <footer class="footer spad">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-lg-3 col-md-6 col-sm-6">
                                            <div class="footer__about">
                                                <div class="footer__about__logo">
                                                    <a href="./index.html"><img src="img/logo.png" alt=""></a>
                                                </div>
                                                <ul>
                                                    <li>Address: 60-49 Road 11378 New York</li>
                                                    <li>Phone: +65 11.188.888</li>
                                                    <li>Email: hello@colorlib.com</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-1">
                                            <div class="footer__widget">
                                                <h6>Useful Links</h6>
                                                <ul>
                                                    <li><a href="#">About Us</a></li>
                                                    <li><a href="#">About Our Shop</a></li>
                                                    <li><a href="#">Secure Shopping</a></li>
                                                    <li><a href="#">Delivery infomation</a></li>
                                                    <li><a href="#">Privacy Policy</a></li>
                                                    <li><a href="#">Our Sitemap</a></li>
                                                </ul>
                                                <ul>
                                                    <li><a href="#">Who We Are</a></li>
                                                    <li><a href="#">Our Services</a></li>
                                                    <li><a href="#">Projects</a></li>
                                                    <li><a href="#">Contact</a></li>
                                                    <li><a href="#">Innovation</a></li>
                                                    <li><a href="#">Testimonials</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-12">
                                            <div class="footer__widget">
                                                <h6>Join Our Newsletter Now</h6>
                                                <p>Get E-mail updates about our latest shop and special offers.</p>
                                                <form action="#">
                                                    <input type="text" placeholder="Enter your mail">
                                                    <button type="submit" class="site-btn">Subscribe</button>
                                                </form>
                                                <div class="footer__widget__social">
                                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                                    <a href="#"><i class="fa fa-pinterest"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="footer__copyright">
                                                <div class="footer__copyright__text">
                                                    <p>
                                                         Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. 
                                                        Copyright &copy;
                                                        <script>document.write( new Date().getFullYear() );</script>
                                                    </p>
                                                </div>
                                                <div class="footer__copyright__payment"><img src="img/payment-item.png" alt="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </footer>-->
        <!-- Footer Section End -->

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

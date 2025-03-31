<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng Sách Online - Book Haven</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&family=Dancing+Script&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .logout-btn {
            background-color: #FF7F50;
            color: #FFFFFF;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #FFD700;
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <div class="container">
        <div class="logo">
            <h1>Book Haven</h1>
        </div>
        <nav>
            <ul>
                <li><a href="products">Trang chủ</a></li>
                <c:if test="${not empty sessionScope.user and sessionScope.user.role eq 'admin'}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Quản lý
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="users">Quản lý người dùng</a></li>
                            <li><a class="dropdown-item" href="productmanagement">Quản lý sản phẩm</a></li>
                            <li><a class="dropdown-item" href="#">Quản lý đơn hàng</a></li>
                        </ul>
                    </li>
                </c:if>
                <li><a href="#">Cửa hàng</a></li>
                <li><a href="#">Liên hệ</a></li>
            </ul>
        </nav>
        <div class="icons">
            <div class="search-container">
                <img src="img/icon/search.png" alt="Search" class="icon search-icon">
                <div class="search-bar">
                    <label>
                        <input type="text" placeholder="Tìm kiếm sách...">
                    </label>
                    <button type="submit">🔍</button>
                </div>
            </div>
            <img src="img/icon/cart.png" alt="Cart" class="icon">
            <img src="img/icon/heart.png" alt="Heart" class="icon">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="logout" class="logout-btn">Logout</a>
                </c:when>
                <c:otherwise>
                    <button class="sign-in-btn"><a href="login.jsp" style="text-decoration: none; color: inherit;">Sign In</a></button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

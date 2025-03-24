<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Book Haven</title>
    <link rel="stylesheet" href="css/register.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&family=Dancing+Script&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<img src="img/banner/banner_1.jpg" alt="Background" class="background-image">
<div class="overlay"></div> <!-- Thêm lớp mờ -->

<!-- Register Section -->
<main>
    <section class="register-container">
        <div class="register-box">
            <h2>Đăng Ký</h2>

            <!-- Hiển thị lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <form action="register" method="post" class="register-form">
                <div class="form-group">
                    <label for="fullname">Họ và tên:</label>
                    <i class="fas fa-user"></i>
                    <input type="text" id="fullname" name="fullname" required placeholder="Nhập họ và tên">
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" required placeholder="Nhập email của bạn">
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu:</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                </div>
                <div class="form-group">
                    <label for="confirm-password">Xác nhận mật khẩu:</label>
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirm-password" name="confirm-password" required placeholder="Xác nhận mật khẩu">
                </div>
                <button type="submit" class="submit-btn">Đăng Ký</button>
                <p class="login-link">Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
            </form>
        </div>
    </section>
</main>
</body>
</html>
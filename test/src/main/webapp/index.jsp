<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bookshop - Cửa hàng sách online</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Font + Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .featured-books {
            padding: 60px 0;
            background-color: #f8f9fa;
        }

        .featured-books h3 {
            text-align: center;
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 50px;
            font-weight: 700;
            position: relative;
        }

        .featured-books h3:after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: #e67e22;
            margin: 15px auto;
            border-radius: 2px;
        }

        .featured-books .row {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 30px;
        }

        .product__item {
            background: white;
            border: 2px solid #e67e22;
            border-radius: 15px;
            transition: all 0.3s ease;
            margin-bottom: 40px;
            overflow: hidden;
            height: 100%;
            display: flex;
            flex-direction: column;
            box-shadow: 0 5px 15px rgba(230, 126, 34, 0.1);
            padding: 20px;
        }

        .product__item:hover {
            cursor: pointer;
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(230, 126, 34, 0.2);
            border-color: #d35400;
        }

        .product__item__pic {
            height: 300px;
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 12px;
            margin-bottom: 25px;
            position: relative;
            padding: 10px;
        }

        .product__item__pic img {
            max-height: 100%;
            width: auto;
            object-fit: contain;
            transition: transform 0.3s ease;
            filter: drop-shadow(0 5px 10px rgba(0,0,0,0.1));
        }

        .product__item__text {
            padding: 15px;
            text-align: center;
            position: relative;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-color: #fff;
            border-radius: 10px;
        }

        .product__item__text h6 {
            margin-bottom: 15px;
        }

        .product__item__text h6 a {
            color: #2c3e50;
            font-size: 1.3rem;
            font-weight: 700;
            text-decoration: none;
            transition: color 0.3s ease;
            line-height: 1.4;
        }

        .product__item__text h6 a:hover {
            color: #e67e22;
        }

        .product__item__text p {
            color: #666;
            margin: 10px 0;
            font-size: 1rem;
            font-weight: 500;
            line-height: 1.6;
        }

        .product__item__price {
            color: #e67e22;
            font-size: 1.6rem;
            font-weight: bold;
            margin: 20px 0;
            transition: all 0.3s ease;
            text-shadow: 1px 1px 0 rgba(0,0,0,0.05);
        }

        .cart_add {
            margin-top: 20px;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }

        .product__item:hover .cart_add {
            opacity: 1;
            transform: translateY(0);
        }

        .cart_add a {
            display: inline-block;
            padding: 15px 35px;
            background-color: #e67e22;
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            border: 2px solid #e67e22;
            letter-spacing: 0.5px;
        }

        .cart_add a:hover {
            background-color: #fff;
            color: #e67e22;
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(230, 126, 34, 0.3);
        }

        .cart_add a::after {
            content: " →";
            opacity: 0;
            transform: translateX(-5px);
            transition: all 0.3s ease;
            display: inline-block;
        }

        .cart_add a:hover::after {
            opacity: 1;
            transform: translateX(5px);
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            margin: -20px;
        }

        .col-lg-3 {
            padding: 20px;
            flex: 0 0 25%;
            max-width: 25%;
        }

        @media (max-width: 1200px) {
            .featured-books .row {
                padding: 0 20px;
            }
        }

        @media (max-width: 991px) {
            .col-lg-3 {
                flex: 0 0 33.333333%;
                max-width: 33.333333%;
            }
            
            .featured-books h3 {
                font-size: 2.2rem;
            }
        }

        @media (max-width: 768px) {
            .col-lg-3 {
                flex: 0 0 50%;
                max-width: 50%;
            }
            
            .product__item__pic {
                height: 280px;
            }
            
            .product__item__text h6 a {
                font-size: 1.2rem;
            }
            
            .product__item__price {
                font-size: 1.4rem;
            }

            .featured-books {
                padding: 40px 0;
            }

            .featured-books .row {
                padding: 0 15px;
            }
        }

        @media (max-width: 480px) {
            .col-lg-3 {
                flex: 0 0 100%;
                max-width: 100%;
            }
            
            .product__item {
                padding: 15px;
                margin-bottom: 30px;
            }
            
            .product__item__pic {
                height: 250px;
            }
            
            .cart_add a {
                padding: 12px 30px;
                font-size: 1rem;
            }

            .featured-books h3 {
                font-size: 2rem;
                margin-bottom: 30px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<!-- Banner -->
<section class="banner">
    <img src="img/banner/banner_1.jpg" class="banner-img" alt="Banner Bookshop">
    <div class="banner-text">
        <h2>Khám phá thế giới tri thức tại Bookshop</h2>
        <p>Mỗi cuốn sách là một cuộc phiêu lưu mới!</p>
        <button onclick="window.location.href='products'">Xem bộ sưu tập</button>
    </div>
</section>

<!-- Danh mục -->
<section class="categories">
    <h3>Danh mục nổi bật</h3>
    <div class="category-list">
        <div class="category">Tiểu thuyết</div>
        <div class="category">Khoa học</div>
        <div class="category">Trẻ em</div>
        <div class="category">Lịch sử</div>
        <div class="category">Self-help</div>
    </div>
</section>

<!-- Sách nổi bật -->
<section class="featured-books">
    <h3>Danh sách sách tại Bookshop</h3>
    <div class="row" id="product-list">

        <c:if test="${empty bookList}">
            <p style="color:red; text-align: center;">⚠ Không có sách nào để hiển thị.</p>
        </c:if>

        <c:forEach var="book" items="${bookList}">
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="product__item">
                    <div class="product__item__pic">
                        <img src="${book.imageUrl}" alt="${book.name}" />
                    </div>
                    <div class="product__item__text">
                        <h6>
                            <a href="product-details?product_id=${book.productId}">
                                ${book.name}
                            </a>
                        </h6>
                        <c:if test="${not empty book.author}">
                            <p>Tác giả: ${book.author}</p>
                        </c:if>
                        <p>Danh mục: ${book.categoryName}</p>
                        <div class="product__item__price">
                            <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="VNĐ"/>
                        </div>
                        <div class="cart_add">
                            <c:choose>
                                <c:when test="${not empty sessionScope.username}">
                                    <a href="#" onclick="addToCart(${book.productId}); return false;">Thêm vào giỏ hàng</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="login.jsp">Thêm vào giỏ hàng</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
</section>

<!-- Đánh giá -->
<section class="reviews">
    <h3>Khách hàng nói gì</h3>
    <div class="swiper review-slider">
        <div class="swiper-wrapper">
            <div class="swiper-slide review-card">
                <div class="review-content">
                    <img src="img/customer/customer_1.jpg" alt="Customer" class="review-avatar">
                    <div class="review-info">
                        <h4>Nguyen Van A
                            <span class="rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </span>
                        </h4>
                        <p class="review-country">Vietnam</p>
                        <p class="review-text">"Sách rất hay, giao hàng nhanh!"</p>
                    </div>
                </div>
            </div>
            <div class="swiper-slide review-card">
                <div class="review-content">
                    <img src="img/customer/customer_2.jpg" alt="Customer" class="review-avatar">
                    <div class="review-info">
                        <h4>Tran Thi B
                            <span class="rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </span>
                        </h4>
                        <p class="review-country">USA</p>
                        <p class="review-text">"Tôi rất thích bộ sưu tập sách ở đây."</p>
                    </div>
                </div>
            </div>
            <div class="swiper-slide review-card">
                <div class="review-content">
                    <img src="img/customer/customer_3.jpg" alt="Customer" class="review-avatar">
                    <div class="review-info">
                        <h4>Le Van C
                            <span class="rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            </span>
                        </h4>
                        <p class="review-country">Japan</p>
                        <p class="review-text">"Dịch vụ tuyệt vời, sẽ quay lại!"</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="swiper-pagination"></div>
    </div>
</section>

<jsp:include page="footer.jsp" />

<!-- JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/11.0.5/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>

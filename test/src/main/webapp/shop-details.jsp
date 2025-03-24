<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/shop-details.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="header.jsp"/>
<!-- Tiêu đề -->
<section class="product-title-section py-5 text-center bg-light">
    <h1 class="fw-bold" style="font-family: 'Playfair Display', serif; font-style: italic;">Product detail</h1>
</section>

<div class="container my-5" style="margin-top: 120px;">
    <div class="row align-items-center">
        <!-- Ảnh sản phẩm -->
        <div class="col-md-5 text-center">
            <img src="${product.imageUrl}" alt="${product.name}" class="img-fluid rounded shadow-sm" style="max-height: 500px;">
        </div>

        <!-- Chi tiết sản phẩm -->
        <div class="col-md-7">
            <h2 class="mb-3">${product.name}</h2>
            <p><strong>Tác giả:</strong> ${product.author}</p>
            <p><strong>Danh mục:</strong> ${product.categoryName}</p>
            <p><strong>Nhà cung cấp:</strong> ${product.supplierName}</p>
            <p><strong>Mô tả:</strong> ${product.description}</p>

            <p><strong>Giá:</strong> <span class="text-warning fw-bold">
                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ"/>
            </span></p>

            <p><strong>Tồn kho:</strong> ${product.stock}</p>

            <div class="d-flex align-items-center gap-3 my-3">
                <div class="input-group" style="width: 120px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(-1)">-</button>
                    <input type="number" class="form-control text-center" id="quantity" value="1" min="1">
                    <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(1)">+</button>
                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <button class="btn btn-warning" onclick="addToCart(${product.productId})">
                            <i class="fas fa-cart-plus me-1"></i> Thêm vào giỏ hàng
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="btn btn-outline-warning">Đăng nhập để mua</a>
                    </c:otherwise>
                </c:choose>

                <button class="btn btn-outline-danger" id="fav-btn" onclick="toggleFavorite()">
                    <i class="fa-regular fa-heart"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="product-tabs mt-5">
        <nav>
            <span class="tab-btn active" data-tab="description">Mô tả</span>
            <span class="tab-btn" data-tab="review">Đánh giá</span>
        </nav>

        <div class="tab-content" id="description">
            <p>${product.description}</p>
        </div>

        <div class="tab-content" id="review" style="display: none;">
            <p>⭐⭐⭐⭐☆</p>
            <p>“Cuốn sách này thật sự đã thay đổi cách nhìn của tôi về giao tiếp!”</p>
            <p>- Một người dùng ẩn danh</p>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/script.js"></script>

<!-- Custom JavaScript -->
<script>
    function updateQuantity(change) {
        const input = document.getElementById('quantity');
        let current = parseInt(input.value) || 1;
        current = Math.max(1, current + change);
        input.value = current;
    }

    function toggleFavorite() {
        const btn = document.getElementById('fav-btn').querySelector('i');
        btn.classList.toggle('fa-regular');
        btn.classList.toggle('fa-solid');
        btn.classList.toggle('text-danger');
    }

    // Tabs
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.style.display = 'none');
            btn.classList.add('active');
            document.getElementById(btn.dataset.tab).style.display = 'block';
        });
    });
</script>

</body>
</html>

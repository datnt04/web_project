<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Cập Nhật Sản Phẩm</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../header.jsp" />
<div class="container mt-5">
    <h2 class="text-center">Cập Nhật Sản Phẩm</h2>
    <form action="productmanagement?action=update" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${product.productId}">
        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" class="form-control" name="name" value="${product.name}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="number" class="form-control" name="price" step="0.01" value="${product.price}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Số lượng</label>
            <input type="number" class="form-control" name="stock" value="${product.stock}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" rows="3">${product.description}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <select name="categoryName" class="form-control">
                <c:forEach var="category" items="${categoryList}">
                    <option value="${category.getCategoryName()}" ${category.getCategoryName() == product.categoryName ? 'selected' : ''}>
                            ${category.getCategoryName()}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Nhà cung cấp</label>
            <select name="supplierName" class="form-control">
                <c:forEach var="supplier" items="${supplierList}">
                    <option value="${supplier.getSupplierName()}" ${supplier.getSupplierName() == product.supplierName ? 'selected' : ''}>
                            ${supplier.getSupplierName()}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Ảnh sản phẩm</label>
            <input type="file" class="form-control" name="imageFile" accept="image/*">
            <small class="text-muted">Ảnh hiện tại: ${product.imageUrl}</small>
            <input type="hidden" name="currentImageUrl" value="${product.imageUrl}">
        </div>

        <div class="mb-3">
            <label class="form-label">Tác giả</label>
            <input type="text" class="form-control" name="author" value="${product.author}">
        </div>

        <button type="submit" class="btn btn-primary">Cập Nhật</button>
        <a href="productmanagement" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>
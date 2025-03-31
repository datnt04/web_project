<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm Sản Phẩm</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../header.jsp" />
<div class="container mt-5">
    <h2 class="text-center">Thêm Sản Phẩm Mới</h2>
    <form action="productmanagement?action=create" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action" value="create">
        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" class="form-control" name="name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="number" class="form-control" name="price" step="0.01" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Số lượng</label>
            <input type="number" class="form-control" name="stock" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" rows="3"></textarea>
        </div>.
        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <c:if test="${empty categoryList}">
                <p class="text-danger">Danh mục không tồn tại hoặc chưa được truyền!</p>
            </c:if>
            <select name="categoryName" class="form-control">
                <c:forEach var="category" items="${categoryList}">
                    <option value="${category.getCategoryName()}">${category.getCategoryName()}</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Nhà cung cấp</label>
            <select name="supplierName" class="form-control">
                <c:forEach var="supplier" items="${supplierList}">
                    <option value="${supplier.getSupplierName()}">${supplier.getSupplierName()}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Ảnh sản phẩm</label>
            <input type="file" class="form-control" name="imageFile" accept="image/*">
        </div>

        <div class="mb-3">
            <label class="form-label">Tác giả</label>
            <input type="text" class="form-control" name="author">
        </div>

        <button type="submit" class="btn btn-success">Thêm Sản Phẩm</button>
        <a href="productmanagement" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>
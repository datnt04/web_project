<%--
  Created by IntelliJ IDEA.
  User: trung
  Date: 28/03/2025
  Time: 18:48:PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="../css/style.css">
    <!-- Font + Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin-top: 100px;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .table {
            font-size: 14px;
        }
        .table th {
            font-weight: bold;
        }
        .search-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />
<h3 style="color: red">${param.mess}</h3>
<div class="container my-5" style="margin-top: 120px !important;">
    <h2 class="text-center mb-4">Quản Lý Sản Phẩm</h2>
    <c:if test="${empty bookList}">
        <div class="alert alert-warning">Không có sản phẩm nào.</div>
    </c:if>
    <c:if test="${not empty bookList}">
        <div class="row mb-3">
            <div class="col-md-6">
                <button id="deleteMultipleBtn" class="btn btn-danger" disabled data-bs-toggle="modal" data-bs-target="#multiDeleteModal">
                    <i class="fas fa-trash"></i> Xóa Sản Phẩm Đã Chọn
                </button>
            </div>
            <div class="col-md-6">
                <div class="search-section">
                    <form action="productmanagement" method="GET" class="d-flex flex-column flex-md-row gap-2">
                        <input type="hidden" name="action" value="search">
                        <div class="d-flex flex-grow-1">
                            <input value="${searchName}" class="form-control form-control-sm me-2" name="searchName" placeholder="Nhập tên cần tìm">
                            <select name="categoryId" class="form-select form-select-sm" style="width: 200px;">
                                <option value="">-- Tất cả thể loại --</option>
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.getCategoryId()}" ${String.valueOf(category.getCategoryId()).equals(categoryId) ? 'selected' : ''}>${category.getCategoryName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button class="btn btn-primary btn-sm" type="submit">Tìm Kiếm</button>
                    </form>
                </div>
            </div>
        </div>
        <form id="productForm" action="productmanagement" method="get">
            <input type="hidden" name="action" value="deleteMultiple">
            <input type="hidden" id="selectedIds" name="selectedIds" value="">

            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center">
                    <thead class="table-dark">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" class="form-check-input">
                        </th>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Nhà cung cấp</th>
                        <th>Ảnh</th>
                        <th>Tác giả</th>
                        <th>Sửa</th>
                        <th>Xóa</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="book" items="${bookList}">
                        <tr>
                            <td>
                                <input type="checkbox" class="form-check-input product-checkbox" value="${book.productId}">
                            </td>
                            <td>${book.productId}</td>
                            <td>${book.name}</td>
                            <td>${book.price}</td>
                            <td>${book.stock}</td>
                            <td>${book.description}</td>
                            <td>${book.categoryName}</td>
                            <td>${book.supplierName}</td>
                            <td><img src="${book.imageUrl}" width="50" height="50" alt="Image"/></td>
                            <td>${book.author}</td>
                            <td>
                                <a href="productmanagement?action=update&id=${book.productId}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                            </td>
                            <td>
                                <button onclick="thongTinXoa('${book.productId}', '${book.name}')" type="button"
                                        class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Xoá
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
    </c:if>
    <a href="productmanagement?action=create" class="btn btn-success">Thêm Sản Phẩm</a>
</div>

<!-- Modal Xoá Một Sản Phẩm -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/productmanagement" method="get">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Xóa sách</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteId" name="deleteId">
                    <span>Bạn có muốn xóa sách có tên </span><span id="deleteName"></span>?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="submit" class="btn btn-danger">Xoá</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Modal Xóa Nhiều Sản Phẩm -->
<div class="modal fade" id="multiDeleteModal" tabindex="-1" aria-labelledby="multiDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="multiDeleteModalLabel">Xóa nhiều sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <span>Bạn có chắc chắn muốn xóa <span id="selectedCount">0</span> sản phẩm đã chọn?</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                <button type="button" id="confirmMultiDelete" class="btn btn-danger">Xoá</button>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/11.0.5/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/script.js"></script>
<script>
    // JavaScript để xử lý checkbox và xóa nhiều sản phẩm
    document.addEventListener('DOMContentLoaded', function() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const productCheckboxes = document.querySelectorAll('.product-checkbox');
        const deleteMultipleBtn = document.getElementById('deleteMultipleBtn');
        const selectedCountSpan = document.getElementById('selectedCount');
        const selectedIdsInput = document.getElementById('selectedIds');
        const confirmMultiDeleteBtn = document.getElementById('confirmMultiDelete');
        const productForm = document.getElementById('productForm');

        // Kiểm tra nếu có sản phẩm trong danh sách
        if (productCheckboxes.length > 0) {
            // Xử lý check/uncheck tất cả
            selectAllCheckbox.addEventListener('change', function() {
                const isChecked = this.checked;
                productCheckboxes.forEach(checkbox => {
                    checkbox.checked = isChecked;
                });
                updateDeleteButton();
            });

            // Xử lý khi checkbox riêng lẻ thay đổi
            productCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    updateDeleteButton();

                    // Kiểm tra nếu tất cả đều được chọn
                    const allChecked = Array.from(productCheckboxes).every(cb => cb.checked);
                    selectAllCheckbox.checked = allChecked;
                });
            });
        }

        // Cập nhật trạng thái nút xóa nhiều
        function updateDeleteButton() {
            const checkedCount = document.querySelectorAll('.product-checkbox:checked').length;
            deleteMultipleBtn.disabled = checkedCount === 0;
            selectedCountSpan.textContent = checkedCount;
        }

        // Xử lý khi nhấn nút xác nhận xóa nhiều
        if (confirmMultiDeleteBtn) {
            confirmMultiDeleteBtn.addEventListener('click', function() {
                const selectedCheckboxes = document.querySelectorAll('.product-checkbox:checked');
                const selectedIds = Array.from(selectedCheckboxes).map(cb => cb.value).join(',');

                if (selectedIds) {
                    selectedIdsInput.value = selectedIds;
                    productForm.submit();
                }
            });
        }
    });

    // Giữ lại function xóa một sản phẩm
    function thongTinXoa(id, name) {
        document.getElementById("deleteId").value = id;
        document.getElementById("deleteName").textContent = name;
    }
</script>
</body>
</html>
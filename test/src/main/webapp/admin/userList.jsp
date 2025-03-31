<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="../css/style.css">
    <!-- Font + Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin-top: 100px;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp" />
<h3 style="color: red">${param.mess}</h3>
<div class="container my-5">
    <c:if test="${empty usersList}">
        <p class="text-danger text-center">Không có người dùng nào.</p>
    </c:if>

    <form action="users" method="GET" class="d-flex justify-content-end mb-3">
        <input type="hidden" name="action" value="search">
        <input value="${searchName}" class="form-control form-control-sm w-25" name="searchName" placeholder="Nhập tên cần tìm">
        <button class="btn btn-primary btn-sm ms-2" type="submit">Tìm Kiếm</button>
    </form>

    <table class="table table-bordered text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Email</th>
            <th>Địa chỉ</th>
            <th>Vai trò</th>
            <th>Thời gian tạo</th>
            <th>Sửa</th>
            <th>Xóa</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${usersList}">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.address}</td>
                <td>${user.role}</td>
                <td>${user.createdAt}</td>
                <td>
                    <a href="users?action=update&id=${user.id}" class="btn btn-warning btn-sm">
                        <i class="fas fa-edit"></i> Sửa
                    </a>
                </td>
                <td>
                    <button onclick="thongTinXoa('${user.id}', '${user.name}')" type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal">
                        Xoá
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<a href="/users?action=create">Thêm mới</a>
<!-- Modal Xóa -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/users" method="get">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Xóa người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteId" name="deleteId">
                    <span>Bạn có muốn xóa người dùng có tên </span><span id="deleteName"></span>?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                    <button type="submit" class="btn btn-danger">Xoá</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/11.0.5/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/script.js"></script>
</body>
</html>

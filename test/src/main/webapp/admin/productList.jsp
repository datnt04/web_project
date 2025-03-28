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
    body{
      margin-top:100px;
    }
  </style>
</head>
<body>
<jsp:include page="../header.jsp" />
<h3 style="color: red">${param.mess}</h3>
<div class="container my-5" style="margin-top: 120px;">
  <c:if test="${empty bookList}">
    <p class="text-danger text-center">Không có sản phẩm nào.</p>
  </c:if>

  <table class="table table-bordered text-center">
    <thead class="table-dark">
    <tr>
      <th>ID</th>
      <th>Tên</th>
      <th>Giá</th>
      <th>Số lượng</th>
      <th>Số lượng</th>
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
        <td>${book.productId}</td>
        <td>${book.name}</td>
        <td>${book.price} VNĐ</td>
        <td>${book.stock}</td>
        <td>${book.description}</td>
        <td>${book.categoryName}</td>
        <td>${book.supplierName}</td>
        <td><img src="${book.imageUrl}" width="50" height="50"></td>
        <td>${book.author}</td>
        <td>
          <a href="productmanagement?action=delete&deleteId=${book.productId}" class="btn btn-warning btn-sm">
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
<!-- Modal Xoá-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form action="/productmanagement" method="get">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Xóa sách</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <input hidden="hidden" name="action" value="delete">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ,ction" value="delete">
          <input hidden="hidden" id="deleteId" name="deleteId">
          <span>Bạn có muốn sách có tên </span><span id="deleteName"></span>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
          <button type="submit" class="btn btn-danger">Xoá</button>
        </div>
      </div>
    </form>

  </div>
</div>


<!-- JS -->
<script>
  function thongTinXoa(id, name) {
    console.log("ID cần xóa:", id, "Tên sách:", name);
    document.getElementById("deleteId").value = id;
    document.getElementById("deleteName").innerText = name;
  }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/11.0.5/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/script.js"></script>
</body>
</html>

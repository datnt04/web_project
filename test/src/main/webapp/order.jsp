<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/26/2025
  Time: 9:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Order</title>
</head>
  <style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 900px;
    margin: 40px auto;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

.input-group {
    margin-bottom: 20px;
}

.input-group input {
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    font-size: 16px;
}

.input-group button {
    background: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.input-group button:hover {
    background: #0056b3;
}

.table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
}

.table thead {
    background: #343a40;
    color: white;
}

.table th, .table td {
    padding: 12px;
    border: 1px solid #dee2e6;
    text-align: center;
}
  
   </style>
<body>
<div class="container mt-4">
        <h2 class="mb-4">Danh Sách Đơn Hàng</h2>

        <form class="mb-3" action="orders" method="get">
            <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Nhập Id khách hàng hoặc mã đơn hàng">
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </div>
        </form>
		<table class="table table-bordered table-striped">
			<tr>
				<th>Mã đơn hàng</th>
				<th>Mã khách hàng</th>
				<th>Ngày đặt</th>
				<th>Tổng tiền</th>
				<th>Đơn hàng ghi chú</th>
				<th>Phiếu mã</th>
				<th>Giảm giá số tiền</th>
				<th>Phương thức thanh toán</th>
				<th>Trạng thái</th>
			</tr>
			<c:forEach items="${ordersList}" var="order">
				<tr>
					<td>${order.getOrderId()}</td>
					<td>${order.getCustomerId()}</td>
					<td>${order.getOrderDate()}</td>
					<td>${order.getTotalAmount()}</td>
					<td>${order.getOrderNotes()}</td>
					<td>${order.getCouponCode()}</td>
					<td>${order.getDiscountAmount()}</td>
					<td>${order.getPaymentMethod()}</td>
					<td>${order.getStatus()}</td>
					 <td>
                <a href="/orders?action=viewById&orderId=${Orders.orderId}">Xem</a>
                |
                <form action="${pageContext.request.contextPath}/orders" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa đơn hàng này?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <button type="submit" style="background-color: red; color: white; border: none; padding: 5px;">Xóa</button>
                </form>
            </td>
				</tr>
			</c:forEach>
			<td>
    <a href="/orderdetails?orderId=${Orders.orderId}" class="btn btn-info">Xem Chi Tiết Đơn Hàng</a>
     </td>
		</table>
	</div>
</body>
</html>

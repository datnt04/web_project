<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
body, h2, table {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}


.container {
    width: 80%;
    margin: 20px auto;
    padding: 20px;
    background: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}


h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}


.table {
    width: 100%;
    border-collapse: collapse;
    background: white;
}

.table th, .table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}

.table th {
    background-color: #007bff;
    color: white;
}

.table tr:nth-child(even) {
    background-color: #f2f2f2;
}

/* Nút hành động */
.action-links {
    text-align: center;
}

.action-links a {
    text-decoration: none;
    padding: 6px 12px;
    margin: 5px;
    border-radius: 5px;
}

.action-links a.view {
    background-color: #28a745;
    color: white;
}

.action-links a.delete {
    background-color: #dc3545;
    color: white;
}

/* Nút quay lại */
.back-btn {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 15px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}

.back-btn:hover {
    background-color: #0056b3;
}</style>
<body>
        <h2>Chi Tiết Đơn Hàng</h2>
        <table class="table table-bordered">
            <tr>
                <th>Mã Đơn Hàng</th>
                <th>Mã Sản Phẩm</th>
                <th>Số Lượng</th>
                <th>Đơn Giá</th>
            </tr>
            <c:forEach items="${orderDetails}" var="detail">
                <tr>
                    <td>${detail.orderId}</td>
                    <td>${detail.productId}</td>
                    <td>${detail.quantity}</td>
                    <td>${detail.unitPrice}</td>
                </tr>
            </c:forEach>
        </table>
        <a href="/order.jsp">Quay lại danh sách đơn hàng</a>
    </div>
</table>
</body>
</html>
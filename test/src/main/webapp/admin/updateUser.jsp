<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Người Dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container mt-5">
    <h3 class="text-center mb-4">Chỉnh Sửa Người Dùng</h3>
    <form action="users?action=update" method="POST" class="w-50 mx-auto border p-4 rounded">
        <input type="hidden" name="id" value="${user.id}">
        <div class="mb-3">
            <label for="username" class="form-label">Họ và tên</label>
            <input type="text" id="username" name="username" class="form-control" required value="${user.name}">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" required value="${user.email}">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu (Để trống nếu không đổi)</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu mới">
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" id="address" name="address" class="form-control" required value="${user.address}">
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Vai trò</label>
            <select id="role" name="role" class="form-select" required>
                <option value="customer" ${user.role == 'customer' ? 'selected' : ''}>Customer</option>
                <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary w-100">Cập Nhật</button>
    </form>
</div>
</body>
</html>

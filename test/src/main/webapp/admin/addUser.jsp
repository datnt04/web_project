<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Người Dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
<div class="container mt-5">
    <h3 class="text-center mb-4">Thêm Người Dùng</h3>
    <form action="users?action=create" method="POST" class="w-50 mx-auto border p-4 rounded">
        <div class="mb-3">
            <label for="username" class="form-label">Họ và tên</label>
            <input type="text" id="username" name="username" class="form-control" required placeholder="Nhập họ và tên">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" required placeholder="Nhập email">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password" id="password" name="password" class="form-control" required placeholder="Nhập mật khẩu">
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" id="address" name="address" class="form-control" required placeholder="Nhập địa chỉ">
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Vai trò</label>
            <select id="role" name="role" class="form-select" required>
                <option value="customer" selected>Customer</option>
                <option value="admin">Admin</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success w-100">Thêm Người Dùng</button>
    </form>
</div>
</body>
</html>
package controller;

import model.User;
import repository.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        User user = new User(
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getString("password"),
                                rs.getString("address"),
                                rs.getString("role"),
                                rs.getTimestamp("created_at")
                        );

                        if ("customer".equals(user.getRole())) {
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user); // Đặt toàn bộ user object
                            session.setAttribute("username", user.getName()); // Đặt thêm username riêng nếu JSP dùng

                            // 👉 Redirect về trang trước nếu có
                            String previousUrl = (String) session.getAttribute("previousUrl");
                            if (previousUrl != null) {
                                session.removeAttribute("previousUrl");
                                response.sendRedirect(previousUrl);
                            } else {
                                response.sendRedirect("products");
                            }

                        } else {
                            request.setAttribute("error", "Tài khoản này không có quyền truy cập!");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối CSDL: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

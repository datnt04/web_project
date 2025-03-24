package controller;

import model.User;
import repository.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (e.getMessage().contains("Duplicate entry")) {
                request.setAttribute("error", "Email đã tồn tại, vui lòng chọn email khác!");
            } else {
                request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
            }
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
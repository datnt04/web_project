package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        String email = (String) session.getAttribute("email");
        RequestDispatcher dispatcher = null;

        // Kiểm tra mật khẩu nhập lại có khớp không
        if (newPassword != null && confPassword != null && newPassword.equals(confPassword) && email != null) {
            try {
                // Kết nối với SQL Server
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/book_haven", "root", "123456789");


                // Cập nhật mật khẩu trong bảng users
                PreparedStatement pst = con.prepareStatement("UPDATE users SET password = ? WHERE email = ?");
                pst.setString(1, newPassword);
                pst.setString(2, email);

                int rowCount = pst.executeUpdate();
                dispatcher = request.getRequestDispatcher("login.jsp");

                if (rowCount > 0) {
                    request.setAttribute("status", "resetSuccess");
                } else {
                    request.setAttribute("status", "resetFailed");
                }
                dispatcher.forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
                dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("status", "passwordMismatch");
            dispatcher = request.getRequestDispatcher("reset-password.jsp");
            dispatcher.forward(request, response);
        }
    }


}
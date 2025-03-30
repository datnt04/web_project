package filter;

import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/productmanagement") // Chặn tất cả các URL bắt đầu bằng "/admin/"
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Kiểm tra nếu user không tồn tại hoặc không phải admin
        if (user == null || !"admin".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/login.jsp"); // Chuyển hướng về trang đăng nhập
            return;
        }

        chain.doFilter(request, response); // Tiếp tục nếu hợp lệ
    }
}

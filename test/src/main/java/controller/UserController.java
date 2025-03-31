package controller;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name="UserController", value = "/users")
public class UserController extends HttpServlet {
    private final UserService userService = new UserService();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
                showFormAdd(req,resp);
                break;
            case "update":
                showFormUpadte(req,resp);
                break;
            case "delete":
                deleteById(req,resp);
                break;
            case "search":
                findByName(req,resp);
                break;
            default:
                showList(req, resp);
                break;
        }
    }

    private void showFormUpadte(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                User user = userService.getById(id);
                if (user != null) {
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/admin/updateUser.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect("users?mess=User not found");
    }

    private void showFormAdd(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
        req.getRequestDispatcher("admin/addUser.jsp").forward(req, resp);
    }

    private void findByName(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchName = req.getParameter("searchName");
        List<User> usersList = userService.findByName(searchName);
        req.setAttribute("usersList", usersList);
        req.setAttribute("searchName", searchName);
        try {
            req.getRequestDispatcher("/admin/userList.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void deleteById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String deleteIdParam = req.getParameter("deleteId");

        if (deleteIdParam == null || deleteIdParam.isEmpty()) {
            resp.sendRedirect("users?mess=Invalid ID");
            return;
        }

        try {
            int deleteId = Integer.parseInt(deleteIdParam);
            boolean isDeleteSuccess = userService.delete(deleteId);
            String mess = isDeleteSuccess ? "Delete Success" : "Delete Failed";

            // Chuyển hướng về trang danh sách với thông báo
            resp.sendRedirect("users?mess=" + mess);
        } catch (NumberFormatException e) {
            resp.sendRedirect("users?mess=Invalid ID Format");
        }
    }


    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> usersList = userService.findAll();
        System.out.println(usersList);
        req.setAttribute("usersList", usersList);
        req.getRequestDispatcher("admin/userList.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
                save(req,resp);
                break;
            case "update":
                updateUser(req,resp);
                break;
            case "delete":

                break;
            case "search":

                break;
            default:
                showList(req, resp);
                break;
        }
    }
    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String username = req.getParameter("username");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String address = req.getParameter("address");
            String role = req.getParameter("role");

            User user = userService.getById(id);
            if (user != null) {
                user.setName(username);
                user.setEmail(email);
                if (!password.isEmpty()) { // Nếu người dùng nhập mật khẩu mới thì cập nhật
                    user.setPassword(password);
                }
                user.setAddress(address);
                user.setRole(role);

                boolean isUpdated = userService.update(user);
                if (isUpdated) {
                    resp.sendRedirect("users?mess=Update success");
                } else {
                    req.setAttribute("errorMessage", "Cập nhật thất bại!");
                    req.setAttribute("user", user);
                    req.getRequestDispatcher("/admin/updateUser.jsp").forward(req, resp);
                }
            } else {
                resp.sendRedirect("users?mess=User not found");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("users?mess=Invalid user ID");
        }
    }
    private void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String role = req.getParameter("role");

        // Tạo user mới từ dữ liệu form nhập vào
        User newUser = new User();
        newUser.setName(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setAddress(address);
        newUser.setRole(role);

        boolean isAdded = userService.add(newUser);

        if (isAdded) {
            resp.sendRedirect("users?mess=Add success"); // Chuyển hướng về danh sách người dùng
        } else {
            req.setAttribute("errorMessage", "Thêm người dùng thất bại!");
            req.getRequestDispatcher("/admin/addUser.jsp").forward(req, resp);
        }
    }
}

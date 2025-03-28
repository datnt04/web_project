package controller;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/productmanagement")
public class ProductManagement extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
//                showCreateForm(req, resp);
                break;
            case "update":
//                showUpdateForm(req, resp);
                break;
            case "delete":
                deleteById(req, resp);
                break;
            case "search":
//                searchProduct(req, resp);
                break;
            default:
                showList(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
//                createProduct(req, resp);
                break;
            case "update":
//                updateProduct(req, resp);
                break;
            case "search":
//                searchProduct(req, resp);
                break;
            default:
                showList(req, resp);
                break;
        }
    }

    /**
     * Hiển thị danh sách sản phẩm
     */
    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> bookList = productService.getAllBooks();
        req.setAttribute("bookList", bookList);
        req.getRequestDispatcher("admin/productList.jsp").forward(req, resp);
    }

    /**
     * Hiển thị form tạo sản phẩm
     */
//    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.getRequestDispatcher("views/product_create.jsp").forward(req, resp);
//    }

    /**
     * Thêm sản phẩm mới
     */
//    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String name = req.getParameter("name");
//        double price = Double.parseDouble(req.getParameter("price"));
//        int stock = Integer.parseInt(req.getParameter("stock"));
//        String description = req.getParameter("description");
//        String categoryName = req.getParameter("categoryName");
//        String supplierName = req.getParameter("supplierName");
//        String imageUrl = req.getParameter("imageUrl");
//        String author = req.getParameter("author");
//
//        Product newProduct = new Product(0, name, price, stock, description, categoryName, supplierName, imageUrl, author);
//        productService.addProduct(newProduct);
//
//        resp.sendRedirect("productmanagement");
//    }

    /**
     * Hiển thị form cập nhật sản phẩm
     */
//    private void showUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        int id = Integer.parseInt(req.getParameter("id"));
//        Product product = productService.getProductById(id);
//        req.setAttribute("product", product);
//        req.getRequestDispatcher("views/product_update.jsp").forward(req, resp);
//    }

    /**
     * Cập nhật thông tin sản phẩm
     */
//    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        int id = Integer.parseInt(req.getParameter("id"));
//        String name = req.getParameter("name");
//        double price = Double.parseDouble(req.getParameter("price"));
//        int stock = Integer.parseInt(req.getParameter("stock"));
//        String description = req.getParameter("description");
//        String categoryName = req.getParameter("categoryName");
//        String supplierName = req.getParameter("supplierName");
//        String imageUrl = req.getParameter("imageUrl");
//        String author = req.getParameter("author");
//
//        Product updatedProduct = new Product(id, name, price, stock, description, categoryName, supplierName, imageUrl, author);
//        productService.updateProduct(updatedProduct);
//
//        resp.sendRedirect("productmanagement");
//    }

    /**
     * Xóa sản phẩm
     */
    private void deleteById(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String deleteIdParam = req.getParameter("deleteId");

        System.out.println("DEBUG: Giá trị deleteId nhận được: " + deleteIdParam); // Kiểm tra giá trị nhận được từ JSP

        if (deleteIdParam == null || deleteIdParam.isEmpty()) {
            resp.sendRedirect("/productmanagement?mess=Invalid ID");
            return;
        }

        int deleteId;
        try {
            deleteId = Integer.parseInt(deleteIdParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect("/productmanagement?mess=Invalid ID format");
            return;
        }

        boolean isDeleteSuccess = productService.deleteBook(deleteId);
        System.out.println("DEBUG: Kết quả xóa: " + isDeleteSuccess); // Kiểm tra kết quả xóa

        String mess = isDeleteSuccess ? "Delete success" : "Delete not success";
        resp.sendRedirect("/productmanagement?mess=" + mess);
    }

    /**
     * Tìm kiếm sản phẩm
//     */
//    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String keyword = req.getParameter("keyword");
//        List<Product> searchResults = productService.searchProducts(keyword);
//        req.setAttribute("bookList", searchResults);
//        req.getRequestDispatcher("views/product_list.jsp").forward(req, resp);
//    }
}

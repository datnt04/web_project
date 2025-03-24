package controller;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
@WebServlet("/product-details")
public class ProductDetailServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("product_id");
        if (idParam != null) {
            int productId = Integer.parseInt(idParam);
            Product book = productService.getProductById(productId);

            if (book != null) {
                req.setAttribute("product", book);
                req.getRequestDispatcher("shop-details.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("index.jsp"); // nếu không tìm thấy sách
            }
        } else {
            resp.sendRedirect("index.jsp"); // nếu thiếu id
        }
    }
}

package controller;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("🌀 [ProductServlet] doGet called");

        List<Product> bookList = productService.getAllBooks();

        if (bookList == null) {
            System.out.println("❌ [ProductServlet] bookList is null");
        } else {
            System.out.println("✅ [ProductServlet] bookList size: " + bookList.size());
            for (Product p : bookList) {
                System.out.println("📚 " + p.getName() + " - " + p.getAuthor());
            }
        }

        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

}

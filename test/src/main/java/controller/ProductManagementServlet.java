package controller;

import model.Category;
import model.Product;
import model.Supplier;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/productmanagement")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,   // 10 MB
        maxRequestSize = 1024 * 1024 * 50  // 50 MB
)
public class ProductManagementServlet extends HttpServlet {
    private final ProductService productService = new ProductService();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(req, resp);
                break;
            case "update":
                showFormUpdate(req,resp);
                break;
            case "delete":
                deleteById(req, resp);
                break;
            case "search":
                searchProduct(req, resp);
                break;
            case "deleteMultiple":
                deleteMultipleProducts(req, resp);
                break;
            default:
                showList(req, resp);
                break;
        }
    }
    private void showFormUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect("productmanagement?mess=Invalid ID");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect("productmanagement?mess=Invalid ID format");
            return;
        }
        Product product = productService.getProductById(id);
        if (product == null) {
            resp.sendRedirect("productmanagement?mess=Product not found");
            return;
        }
        req.setAttribute("product", product);
        req.setAttribute("categoryList", productService.getAllCategories());
        req.setAttribute("supplierList", productService.getSuppliers());
        req.getRequestDispatcher("admin/updateProduct.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
                createProduct(req, resp);
                break;
            case "update":
                updateProduct(req, resp);
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
        List<Category> categoryList = productService.getAllCategories();
        req.setAttribute("categoryList", categoryList);
        req.setAttribute("bookList", bookList);
        req.getRequestDispatcher("admin/productList.jsp").forward(req, resp);
    }
    /**
     * Hiển thị form tạo sản phẩm
     */
    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categoryList = productService.getAllCategories();
        List<Supplier> supplierList = productService.getSuppliers();
        System.out.println("DEBUG: Danh sách category = " + categoryList);
        req.setAttribute("categoryList", categoryList);
        req.setAttribute("supplierList", supplierList);
        req.getRequestDispatcher("admin/addProduct.jsp").forward(req, resp);
    }

    /**
     * Thêm sản phẩm mới
     */
    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String description = req.getParameter("description");
        String categoryName = req.getParameter("categoryName");
        String supplierName = req.getParameter("supplierName");
        String author = req.getParameter("author");
        // Xử lý file ảnh
        String imageUrl = "";
        Part filePart = req.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "product";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            filePart.write(uploadPath + File.separator + fileName);
            imageUrl = "img" + File.separator + "product" + File.separator + fileName;
        }
        Product newProduct = new Product(0, name, price, stock, description, categoryName, supplierName, imageUrl, author);
        productService.addProduct(newProduct);
        resp.sendRedirect("productmanagement");
    }
    /**
     * Cập nhật thông tin sản phẩm
     */
    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String description = req.getParameter("description");
        String categoryName = req.getParameter("categoryName");
        String supplierName = req.getParameter("supplierName");
        String author = req.getParameter("author");
        // Xử lý file ảnh nếu được tải lên
        String imageUrl = req.getParameter("currentImageUrl"); // Giữ ảnh cũ nếu không có ảnh mới
        Part filePart = req.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            // Tạo thư mục lưu trữ nếu chưa tồn tại
            String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "product";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            filePart.write(uploadPath + File.separator + fileName);
            imageUrl = "img" + File.separator + "product" + File.separator + fileName;
        }
        Product updatedProduct = new Product(id, name, price, stock, description, categoryName, supplierName, imageUrl, author);
        productService.updateProduct(updatedProduct);

        resp.sendRedirect("productmanagement");
    }
    // Hàm lấy tên file từ Part
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");

        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
    private void deleteById(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String deleteIdParam = req.getParameter("deleteId");
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
        String mess = isDeleteSuccess ? "Delete success" : "Delete not success";
        resp.sendRedirect("/productmanagement?mess=" + mess);
    }
    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchName = req.getParameter("searchName");
        String categoryId = req.getParameter("categoryId");

        System.out.println("Search parameters - searchName: [" + searchName + "], categoryId: [" + categoryId + "]");

        List<Category> categoryList = productService.getAllCategories();
        List<Product> bookList = productService.searchProducts(searchName, categoryId);
        if (bookList.isEmpty() &&
                ((searchName == null || searchName.trim().isEmpty()) &&
                        (categoryId == null || categoryId.trim().isEmpty()))) {
            bookList = productService.getAllBooks();
        }
        boolean noResultsFound = bookList.isEmpty();
        req.setAttribute("searchName", searchName != null ? searchName : "");
        req.setAttribute("categoryId", categoryId);
        req.setAttribute("bookList", bookList);
        req.setAttribute("categoryList", categoryList);
        req.setAttribute("noResultsFound", noResultsFound);
        req.getRequestDispatcher("/admin/productList.jsp").forward(req, resp);
    }
    private void deleteMultipleProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String selectedIds = req.getParameter("selectedIds");
        if (selectedIds != null && !selectedIds.isEmpty()) {
            String[] idArray = selectedIds.split(",");
            int successCount = 0;
            for (String idStr : idArray) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    boolean success = productService.deleteBook(id);
                    if (success) {
                        successCount++;
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/productmanagement");
        } else {
            resp.sendRedirect(req.getContextPath() + "/productmanagement?mess=Không có sản phẩm nào được chọn để xóa!");
        }
    }
}

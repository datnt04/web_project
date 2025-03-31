package repository;

import model.Category;
import model.Product;
import model.Supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {

    public List<Product> findAllBooks() {
        List<Product> bookList = new ArrayList<>();
        String sql = "SELECT p.Product_ID, p.Name AS Product_Name, p.Price, p.Stock, p.Product_Description, " +
                "pc.Name AS Category_Name, s.Name AS Supplier_Name, p.Product_img, p.Author " +
                "FROM Product p " +
                "LEFT JOIN Product_Category pc ON p.Product_Category_ID = pc.Category_ID " +
                "LEFT JOIN Supplier s ON p.Supplier_ID = s.ID";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Product_Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description"),
                        rs.getString("Category_Name"),
                        rs.getString("Supplier_Name"),
                        rs.getString("Product_img"),
                        rs.getString("Author")
                );
                bookList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookList;
    }

    public Product findById(int id) {
        Product product = null;

        String sql = "SELECT " +
                "p.Product_ID, " +
                "p.Name, " +
                "p.Price, " +
                "p.Stock, " +
                "p.Product_Description, " +
                "pc.Name AS Category_Name, " +
                "s.Name AS Supplier_Name, " +
                "p.Product_img, " +
                "p.Author " +
                "FROM Product p " +
                "LEFT JOIN Product_Category pc ON p.Product_Category_ID = pc.Category_ID " +
                "LEFT JOIN Supplier s ON p.Supplier_ID = s.ID " +
                "WHERE p.Product_ID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description") != null ? rs.getString("Product_Description") : "Không có mô tả.",
                        rs.getString("Category_Name") != null ? rs.getString("Category_Name") : "Chưa có",
                        rs.getString("Supplier_Name") != null ? rs.getString("Supplier_Name") : "Không rõ",
                        rs.getString("Product_img") != null ? rs.getString("Product_img") : "",
                        rs.getString("Author") != null ? rs.getString("Author") : "Không rõ"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    public boolean deleteBookById(int bookId) {
        String query = "DELETE FROM book_haven.product WHERE Product_ID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, bookId);
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProduct(Product product) {
        String getCategoryIdSql = "SELECT Category_ID FROM Product_Category WHERE Name = ?";
        String getSupplierIdSql = "SELECT ID FROM Supplier WHERE Name = ?";
        String updateSql = "UPDATE Product SET Name = ?, Price = ?, Stock = ?, Product_Description = ?, " +
                "Product_Category_ID = ?, Supplier_ID = ?, Product_img = ?, Author = ? WHERE Product_ID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement categoryStmt = conn.prepareStatement(getCategoryIdSql);
             PreparedStatement supplierStmt = conn.prepareStatement(getSupplierIdSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

            // Lấy categoryId từ categoryName
            categoryStmt.setString(1, product.getCategoryName());
            ResultSet categoryRs = categoryStmt.executeQuery();
            int categoryId = categoryRs.next() ? categoryRs.getInt("Category_ID") : -1;

            // Lấy supplierId từ supplierName
            supplierStmt.setString(1, product.getSupplierName());
            ResultSet supplierRs = supplierStmt.executeQuery();
            int supplierId = supplierRs.next() ? supplierRs.getInt("ID") : -1;

            // Kiểm tra nếu không tìm thấy ID
            if (categoryId == -1 || supplierId == -1) {
                System.out.println("Lỗi: Không tìm thấy danh mục hoặc nhà cung cấp.");
                return false;
            }

            // Thiết lập giá trị cập nhật sản phẩm
            updateStmt.setString(1, product.getName());
            updateStmt.setDouble(2, product.getPrice());
            updateStmt.setInt(3, product.getStock());
            updateStmt.setString(4, product.getDescription());
            updateStmt.setInt(5, categoryId);
            updateStmt.setInt(6, supplierId);
            updateStmt.setString(7, product.getImageUrl());
            updateStmt.setString(8, product.getAuthor());
            updateStmt.setInt(9, product.getProductId());

            int affectedRows = updateStmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Product> searchProducts(String name, String categoryId) {
        List<Product> searchList = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder(
                "SELECT p.Product_ID, p.Name, p.Price, p.Stock, p.Product_Description, " +
                        "pc.Name AS Category_Name, pc.Category_ID, s.Name AS Supplier_Name, p.Product_img, p.Author " +
                        "FROM Product p " +
                        "LEFT JOIN Product_Category pc ON p.Product_Category_ID = pc.Category_ID " +
                        "LEFT JOIN Supplier s ON p.Supplier_ID = s.ID " +
                        "WHERE 1=1");

        // Thêm điều kiện tìm kiếm
        if (name != null && !name.trim().isEmpty()) {
            sqlBuilder.append(" AND p.Name LIKE ?");
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            sqlBuilder.append(" AND pc.Category_ID = ?");
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {

            int paramIndex = 1;
            if (name != null && !name.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + name.trim() + "%");
            }
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                stmt.setInt(paramIndex, Integer.parseInt(categoryId.trim()));
            }

            System.out.println("SQL Query: " + sqlBuilder.toString());

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("Product_ID"),
                            rs.getString("Name"),
                            rs.getDouble("Price"),
                            rs.getInt("Stock"),
                            rs.getString("Product_Description"),
                            rs.getString("Category_Name"),
                            rs.getString("Supplier_Name"),
                            rs.getString("Product_img"),
                            rs.getString("Author")
                    );
                    searchList.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sản phẩm: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.err.println("Lỗi chuyển đổi categoryId: " + e.getMessage());
        }

        return searchList;
    }
    public List<Supplier> getSuppliers() {
        List<Supplier> supplierList = new ArrayList<>();
        String sql = "SELECT id, Name FROM Supplier"; // Lấy cả ID nếu cần

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                supplierList.add(new Supplier(rs.getInt("id"), rs.getString("name"))); // Sửa "ID" thành "Supplier_ID"
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return supplierList;
    }
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT Category_ID, Name FROM Product_Category";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getInt("Category_ID"), rs.getString("Name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
    public boolean addProduct(Product product) {
        String getCategoryIdSql = "SELECT Category_ID FROM Product_Category WHERE Name = ?";
        String getSupplierIdSql = "SELECT ID FROM Supplier WHERE Name = ?";
        String insertSql = "INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img, Author) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement categoryStmt = conn.prepareStatement(getCategoryIdSql);
             PreparedStatement supplierStmt = conn.prepareStatement(getSupplierIdSql);
             PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {

            // Lấy categoryId từ categoryName
            categoryStmt.setString(1, product.getCategoryName());
            ResultSet categoryRs = categoryStmt.executeQuery();
            int categoryId = categoryRs.next() ? categoryRs.getInt("Category_ID") : -1;

            // Lấy supplierId từ supplierName
            supplierStmt.setString(1, product.getSupplierName());
            ResultSet supplierRs = supplierStmt.executeQuery();
            int supplierId = supplierRs.next() ? supplierRs.getInt("ID") : -1;

            // Kiểm tra nếu không tìm thấy ID
            if (categoryId == -1 || supplierId == -1) {
                System.out.println("Lỗi: Không tìm thấy danh mục hoặc nhà cung cấp.");
                return false;
            }

            // Thêm sản phẩm
            insertStmt.setString(1, product.getName());
            insertStmt.setDouble(2, product.getPrice());
            insertStmt.setInt(3, product.getStock());
            insertStmt.setString(4, product.getDescription());
            insertStmt.setInt(5, categoryId);
            insertStmt.setInt(6, supplierId);
            insertStmt.setString(7, product.getImageUrl());
            insertStmt.setString(8, product.getAuthor());

            int affectedRows = insertStmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}

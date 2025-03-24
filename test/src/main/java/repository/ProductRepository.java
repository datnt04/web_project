package repository;

import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}

package repository;

import com.mysql.cj.x.protobuf.MysqlxCrud;
import model.Orders;
import model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository {
   public List<Orders> findAllOrders() {
       List<Orders> orders = new ArrayList<>();
       String sql = "SELECT o.Order_ID, u.name AS Customer_Id, o.Order_Date, o.Total_Amount, o.Status " +
               "FROM Orders o JOIN users u ON o.Customer_ID = u.id";
       try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
           while (rs.next()) {
               orders.add(new Orders(
            		   rs.getString("customerId"),
                       rs.getInt("orderId"),
                       rs.getString("orderDate"),
                       rs.getDouble("totalAmount"),
                       rs.getString("orderNotes"),
                       rs.getString("couponCode"),
                       rs.getDouble("discountAmount"),
                       rs.getString("paymentMethod")

               ));
           }
       }catch (SQLException e) {
           e.printStackTrace();
       }
       return orders;
   }
   public List<Orders> findByCustomerId (String customerId) {
       List<Orders> orders = new ArrayList<>();
       String sql = "SELECT o.Order_ID, u.name AS Customer_Id, o.Order_Date, o.Total_Amount, o.Status " +
               "FROM Orders o JOIN users u ON o.Customer_ID = u.id WHERE u.name LIKE ?";
       try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)){
           stmt.setString(1, "%" + customerId + "%");
           ResultSet rs = stmt.executeQuery();
           while (rs.next()) {
               orders.add(new Orders(
                       rs.getString("customerId"),
                       rs.getInt("orderId"),
                       rs.getString("orderDate"),
                       rs.getDouble("totalAmount"),
                       rs.getString("orderNotes"),
                       rs.getString("couponCode"),
                       rs.getDouble("discountAmount"),
                       rs.getString("paymentMethod")
               ));
           }
       }catch (SQLException e) {
           e.printStackTrace();
       }
       return orders;
   }
    public  Orders findById(int orderId) {
        String sql = "SELECT o.Order_ID, u.name AS Customer_Id, o.Order_Date, o.Total_Amount, o.Status " +
                "FROM Orders o JOIN users u ON o.Customer_ID = u.id WHERE o.Order_ID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Orders(
                		  rs.getString("customerId"),
                        rs.getInt("orderId"),
                      
                        rs.getString("orderDate"),
                        rs.getDouble("totalAmount"),
                        rs.getString("orderNotes"),
                        rs.getString("couponCode"),
                        rs.getDouble("discountAmount"),
                        rs.getString("paymentMethod")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Orders> searchOrders(String keyword) {
        List<Orders> filteredOrders = new ArrayList<>();
        for (Orders order : findAllOrders()) {
            if (order.getCustomerId().toLowerCase().contains(keyword.toLowerCase())) {
                filteredOrders.add(order);
            }
        }
        return filteredOrders;
    }
}

package repository;

import com.mysql.cj.x.protobuf.MysqlxCrud;

import model.OrderDetails;
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
       String sql = "SELECT o.Order_ID as orderId, u.name AS customerId,o.Order_Notes as orderNotes, o.Coupon_Code as couponCode, o.Discount_Amount as discountAmount, o.Payment_Method as paymentMethod, o.Order_Date as orderDate, o.Total_Amount as totalAmount, o.Status as status  " +
               "FROM Orders o JOIN users u ON o.Customer_ID = u.id";
       try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
           while (rs.next()) {
        	   String ddd = rs.getString("orderNotes");
               orders.add(new Orders(
            		   rs.getString("customerId"),
                       rs.getInt("orderId"),
                       rs.getString("orderDate"),
                       rs.getDouble("totalAmount"),
                       rs.getString("orderNotes"),
                       rs.getString("couponCode"),
                       rs.getDouble("discountAmount"),
                       rs.getString("paymentMethod"),
                       rs.getString("status")
                       
               ));
           }
       }catch (SQLException e) {
           e.printStackTrace();
       }
       return orders;
   }
   public List<Orders> findByCustomerId (String customerId) {
       List<Orders> orders = new ArrayList<>();
       String sql = "SELECT o.Order_ID as orderId, u.name AS customerId, o.Order_Date as orderDate, o.Order_Notes as orderNotes, o.Coupon_Code as couponCode, o.Discount_Amount as discountAmount, o.Payment_Method as paymentMethod, o.Total_Amount as totalAmount , o.Status as status  " +
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
                       rs.getString("paymentMethod"),
                       rs.getString("status")
               ));
           }
       }catch (SQLException e) {
           e.printStackTrace();
       }
       return orders;
   }
    public  Orders findById(int orderId) {
        String sql = "SELECT o.Order_ID as orderId, u.name AS customerId, o.Order_Date as orderDate,,o.Order_Notes as orderNotes, o.Coupon_Code as couponCode, o.Discount_Amount as discountAmount, o.Payment_Method as paymentMethod, o.Total_Amount as totalAmount, o.Status as status  " +
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
                        rs.getString("paymentMethod"),
                        rs.getString("status")
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
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM Orders WHERE Order_ID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
}
    public boolean approveOrder(int orderId) {
        String sql = "UPDATE Orders SET Status = 'Approved' WHERE Order_ID = ? AND Status = 'Pending'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
	
}

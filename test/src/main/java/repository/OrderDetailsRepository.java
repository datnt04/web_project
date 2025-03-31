package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.OrderDetails;

public class OrderDetailsRepository {
	 public static List<OrderDetails> findOrderDetailsByOrderId(int orderId) {
		 List<OrderDetails> detailsList = new ArrayList<>();
	        String sql = "SELECT * FROM OrderDetails WHERE Order_ID = ?";

	        try (Connection conn = DatabaseConnection.getConnection();
	                PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setInt(1, orderId);
	            ResultSet rs = stmt.executeQuery();

	            while (rs.next()) {
	                detailsList.add(new OrderDetails(
	                		rs.getInt("orderDetailID"),
	                		rs.getInt("orderId"),
	                		rs.getInt("productID"),
	                		rs.getInt("quantity"),
	                		rs.getDouble("unitPrice"),
	                		rs.getDouble("Subtotal")
	                ));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return detailsList;
	    }
}

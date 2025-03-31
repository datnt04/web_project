package repository;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepository implements IUserRepository {
    private final String SELECT_ALL = "SELECT * FROM users";
    private final String DELETE_BY_ID = "DELETE FROM users WHERE id = ?";
    private final String INSERT_INTO = "INSERT INTO users (name, email, password, address, role) VALUES (?, ?, ?, ?, ?)";
    private final String FIND_BY_NAME = "SELECT * FROM users WHERE name LIKE ?";
    private final String FIND_BY_ID = "SELECT * FROM users WHERE id = ?";
    private final String UPDATE_USER = "UPDATE users SET name=?, email=?, password=?, address=?, role=? WHERE id=?";
    @Override
    public List<User> findAll() {
        List<User> userList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at")
                );
                userList.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách người dùng: " + e.getMessage());
        }
        System.out.println("Lấy danh sách user từ DB: " + userList);
        return userList;
    }

    @Override
    public boolean add(User user) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_INTO)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getRole());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm người dùng: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean update(User user) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_USER)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // Nếu để trống thì cần xử lý giữ nguyên mật khẩu cũ
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getRole());
            stmt.setInt(6, user.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_BY_ID)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0; // Trả về true nếu có bản ghi bị xóa
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa user: " + e.getMessage());
        }

        return false; // Trả về false nếu xóa không thành công
    }

    @Override
    public List<User> findByName(String name) {
        List<User> userList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(FIND_BY_NAME)) {
            stmt.setString(1, "%" + name + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("address"),
                            rs.getString("role")
                    );
                    userList.add(user);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm người dùng: " + e.getMessage());
        }
        return userList;
    }


    public User getById(int id) {
        User user = null;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(FIND_BY_ID)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}

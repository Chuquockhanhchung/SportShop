package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class UserAdminDAO extends DBContext {

    public List<UserAdmin> getAll() {
        List<UserAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER]";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UserAdmin u = new UserAdmin();
                u.setUserId(rs.getInt("User_id"));
                u.setUserName(rs.getString("User_name"));
                u.setUserFullName(rs.getString("User_full_name"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhoneNumber(rs.getString("Phone_number"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setUserAvatar(rs.getString("User_avatar"));

                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserAdmin> getUsersByRole(String role) {
        List<UserAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserAdmin u = new UserAdmin();
                u.setUserId(rs.getInt("User_id"));
                u.setUserName(rs.getString("User_name"));
                u.setUserFullName(rs.getString("User_full_name"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhoneNumber(rs.getString("Phone_number"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setUserAvatar(rs.getString("User_avatar"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserAdmin> searchByName(String name) {
        List<UserAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] WHERE User_full_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserAdmin u = new UserAdmin();
                u.setUserId(rs.getInt("User_id"));
                u.setUserName(rs.getString("User_name"));
                u.setUserFullName(rs.getString("User_full_name"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhoneNumber(rs.getString("Phone_number"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setUserAvatar(rs.getString("User_avatar"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserAdmin> searchByEmail(String email) {
        List<UserAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] WHERE Email LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + email + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserAdmin u = new UserAdmin();
                u.setUserId(rs.getInt("User_id"));
                u.setUserName(rs.getString("User_name"));
                u.setUserFullName(rs.getString("User_full_name"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhoneNumber(rs.getString("Phone_number"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setUserAvatar(rs.getString("User_avatar"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserAdmin> sortByFullnameAZ() {
        List<UserAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] ORDER BY RIGHT(User_full_name, CHARINDEX(' ', REVERSE(User_full_name)) - 1) ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserAdmin u = new UserAdmin();
                u.setUserId(rs.getInt("User_id"));
                u.setUserName(rs.getString("User_name"));
                u.setUserFullName(rs.getString("User_full_name"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhoneNumber(rs.getString("Phone_number"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setUserAvatar(rs.getString("User_avatar"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserAdmin> sortByFullnameZA() {
        List<UserAdmin> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] ORDER BY RIGHT(User_full_name, CHARINDEX(' ', REVERSE(User_full_name)) - 1) DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserAdmin u = new UserAdmin();
                u.setUserId(rs.getInt("User_id"));
                u.setUserName(rs.getString("User_name"));
                u.setUserFullName(rs.getString("User_full_name"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhoneNumber(rs.getString("Phone_number"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setUserAvatar(rs.getString("User_avatar"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public UserAdmin getById(int id) {
        String sql = "SELECT * FROM [USER] WHERE User_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserAdmin u = new UserAdmin();
                    u.setUserId(rs.getInt("User_id"));
                    u.setUserName(rs.getString("User_name"));
                    u.setUserFullName(rs.getString("User_full_name"));
                    u.setEmail(rs.getString("Email"));
                    u.setPassword(rs.getString("Password"));
                    u.setPhoneNumber(rs.getString("Phone_number"));
                    u.setGender(rs.getString("Gender"));
                    u.setDateOfBirth(rs.getDate("DateOfBirth"));
                    u.setRole(rs.getString("Role"));
                    u.setAddress(rs.getString("Address"));
                    u.setUserAvatar(rs.getString("User_avatar"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void create(String userName, String userFullName, String email, String password,
            String phoneNumber, String gender, Date dateOfBirth, String role,
            String address, String userAvatar) {
        String sql = "INSERT INTO [USER] (User_name, User_full_name, Email, Password, Phone_number, Gender, DateOfBirth, Role, Address, User_avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.setString(2, userFullName != null ? userFullName : null);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, phoneNumber != null ? phoneNumber : null);
            ps.setString(6, gender != null ? gender : null);
            ps.setDate(7, dateOfBirth != null ? dateOfBirth : null);
            ps.setString(8, role != null ? role : "Customer");
            ps.setString(9, address != null ? address : null);
            ps.setString(10, userAvatar != null ? userAvatar : null);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(int userId, String userName, String userFullName, String email, String password,
            String phoneNumber, String gender, Date dateOfBirth, String role,
            String address, String userAvatar) {
        String sql = "UPDATE [USER] SET User_name=?, User_full_name=?, Email=?, Password=COALESCE(?, Password), Phone_number=?, Gender=?, DateOfBirth=?, Role=?, Address=?, User_avatar=? WHERE User_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.setString(2, userFullName != null ? userFullName : null);
            ps.setString(3, email);
            ps.setString(4, (password != null && !password.isEmpty()) ? password : null);
            ps.setString(5, phoneNumber != null ? phoneNumber : null);
            ps.setString(6, gender != null ? gender : null);
            ps.setDate(7, dateOfBirth != null ? dateOfBirth : null);
            ps.setString(8, role != null ? role : "Customer");
            ps.setString(9, address != null ? address : null);
            ps.setString(10, userAvatar != null ? userAvatar : null);
            ps.setInt(11, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức phụ: Xóa tất cả dữ liệu liên quan đến user
private void deleteUserRelatedData(int userId) throws SQLException {
    // 1. Xóa ORDER_DETAILS
    String sqlOD = "DELETE FROM ORDER_DETAILS WHERE Order_id IN (SELECT Order_id FROM [ORDER] WHERE User_id=?)";
    try (PreparedStatement ps = connection.prepareStatement(sqlOD)) {
        ps.setInt(1, userId);
        int count = ps.executeUpdate();
        System.out.println("Đã xóa " + count + " ORDER_DETAILS");
    }

    // 2. Xóa PAYMENT
    String sqlP = "DELETE FROM PAYMENT WHERE Order_id IN (SELECT Order_id FROM [ORDER] WHERE User_id=?)";
    try (PreparedStatement ps = connection.prepareStatement(sqlP)) {
        ps.setInt(1, userId);
        int count = ps.executeUpdate();
        System.out.println("Đã xóa " + count + " PAYMENT");
    }

    // 3. Xóa ORDER
    String sqlO = "DELETE FROM [ORDER] WHERE User_id=?";
    try (PreparedStatement ps = connection.prepareStatement(sqlO)) {
        ps.setInt(1, userId);
        int count = ps.executeUpdate();
        System.out.println("Đã xóa " + count + " ORDER");
    }

    // 4. Xóa CART_ITEMS
    String sqlCI = "DELETE FROM CART_ITEMS WHERE Cart_id IN (SELECT Cart_id FROM CART WHERE User_id=?)";
    try (PreparedStatement ps = connection.prepareStatement(sqlCI)) {
        ps.setInt(1, userId);
        int count = ps.executeUpdate();
        System.out.println("Đã xóa " + count + " CART_ITEMS");
    }

    // 5. Xóa CART
    String sqlC = "DELETE FROM CART WHERE User_id=?";
    try (PreparedStatement ps = connection.prepareStatement(sqlC)) {
        ps.setInt(1, userId);
        int count = ps.executeUpdate();
        System.out.println("Đã xóa " + count + " CART");
    }
}

// Phương thức chính: Xóa user
public void delete(int userId) {
    try {
        connection.setAutoCommit(false); // Bắt đầu transaction
        
        System.out.println("Bắt đầu xóa user ID: " + userId);
        
        // Xóa tất cả dữ liệu liên quan trước
        deleteUserRelatedData(userId);
        
        // Cuối cùng xóa USER
        String sql = "DELETE FROM [USER] WHERE User_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int count = ps.executeUpdate();
            System.out.println("Đã xóa " + count + " USER");
            
            if (count == 0) {
                throw new SQLException("Không tìm thấy user ID: " + userId);
            }
        }
        
        connection.commit(); // Commit transaction
        System.out.println("Xóa user ID " + userId + " thành công!");
        
    } catch (SQLException e) {
        System.err.println("Lỗi khi xóa user ID " + userId + ": " + e.getMessage());
        e.printStackTrace();
        try {
            connection.rollback(); // Rollback nếu có lỗi
            System.out.println("Đã rollback transaction");
        } catch (SQLException ex) {
            System.err.println("Lỗi rollback: " + ex.getMessage());
            ex.printStackTrace();
        }
    } finally {
        try {
            connection.setAutoCommit(true); // Khôi phục chế độ auto-commit
        } catch (SQLException ex) {
            System.err.println("Lỗi setAutoCommit: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
}

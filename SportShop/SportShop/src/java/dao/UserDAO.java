package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.DBContext;
import model.User;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public User findUserByUserName(String username) {
    String sql = "SELECT * FROM [User] WHERE User_name = ?";
    try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
        pstmt.setString(1, username);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("User_id"));
                user.setUserName(rs.getString("User_name"));
                user.setUserFullName(rs.getString("User_full_name")); // thêm
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setPhoneNumber(rs.getString("Phone_number"));
                user.setGender(rs.getString("Gender"));
                user.setRole(rs.getString("Role"));
                user.setAddress(rs.getString("Address")); // thêm
                user.setDateOfBirth(rs.getDate("DateOfBirth"));
                user.setUserAvatar(rs.getString("User_avatar"));
                return user;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

public User findUserByEmail(String email) {
    String sql = "SELECT * FROM [User] WHERE Email = ?";
    try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
        pstmt.setString(1, email);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("User_id"));
                user.setUserName(rs.getString("User_name"));
                user.setUserFullName(rs.getString("User_full_name")); // thêm
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setPhoneNumber(rs.getString("Phone_number"));
                user.setGender(rs.getString("Gender"));
                user.setRole(rs.getString("Role"));
                user.setAddress(rs.getString("Address")); // thêm
                user.setDateOfBirth(rs.getDate("DateOfBirth"));
                user.setUserAvatar(rs.getString("User_avatar"));
                return user;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}


    // Các phương thức khác như insertUser cũng nên theo cấu trúc try-catch-finally tương tự
    public boolean insertUserAccount(User user) {
        // BƯỚC 1: Khai báo biến JDBC
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "INSERT INTO [User] (Email, Password, User_name, User_full_name, Phone_Number, Gender, DateOfBirth, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // BƯỚC 2: Lấy kết nối
            pstmt = connection.prepareStatement(sql);

            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getUserName());
            // 4. User_full_name
            pstmt.setString(4, user.getUserFullName());
            // 5. Phone_Number
            pstmt.setString(5, user.getPhoneNumber());
            // 6. Gender
            pstmt.setString(6, user.getGender());
            // 7. DateOfBirth
            pstmt.setDate(7, user.getDateOfBirth());
            // 8. Address
            pstmt.setString(8, user.getAddress());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // true nếu chèn thành công

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false; // Trả về false nếu thất bại
    }

    public boolean updatePassword(User user) {
        // BƯỚC 1: Khai báo biến JDBC
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "UPDATE [USER] SET Password = ? WHERE USER_name = ?";

        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getUserName());

            int rows = pstmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER]";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
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

    public List<User> getUsersByRole(String role) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
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

    public List<User> searchByName(String name) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] WHERE User_full_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
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

    public List<User> searchByEmail(String email) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] WHERE Email LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + email + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
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

    public List<User> sortByFullnameAZ() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] ORDER BY RIGHT(User_full_name, CHARINDEX(' ', REVERSE(User_full_name)) - 1) ASC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
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

    public List<User> sortByFullnameZA() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [USER] ORDER BY RIGHT(User_full_name, CHARINDEX(' ', REVERSE(User_full_name)) - 1) DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
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

    public User getById(int id) {
        String sql = "SELECT * FROM [USER] WHERE User_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
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

    public void delete(int id) {
        String sql = "DELETE FROM [USER] WHERE User_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.DBContext;
import model.category;

public class CategoryDAO extends DBContext {

    // Lấy tất cả category
    public List<category> getAllCategories() {
        List<category> list = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORIES"; // tên bảng trong DB
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                category c = new category();
                c.setCategoryID(rs.getInt("Category_id"));       // tên cột trong DB
                c.setCategoryName(rs.getString("Category_name"));
                c.setDescription(rs.getString("Description"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy category theo ID
    public category getCategoryById(int id) {
        String sql = "SELECT * FROM CATEGORIES WHERE Category_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    category c = new category();
                    c.setCategoryID(rs.getInt("Category_id"));
                    c.setCategoryName(rs.getString("Category_name"));
                    c.setDescription(rs.getString("Description"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm category
    public void createCategory(String name, String description) {
        String sql = "INSERT INTO CATEGORIES (Category_name, Description) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật category
    public void updateCategory(int id, String name, String description) {
        String sql = "UPDATE CATEGORIES SET Category_name=?, Description=? WHERE Category_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa category
    public void deleteCategory(int id) {
        String sql = "DELETE FROM CATEGORIES WHERE Category_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

package dao;

import java.sql.*;
import java.util.*;
import model.*;

public class ProductsAdminDAO extends DBContext {

    public void create(String name, double price, int categoryId, int quantity, String description, String color, String gender, String imageUrl) {
        String sql = "INSERT INTO PRODUCTS (Product_name, Price, Category_id, Quantity, Description, Color, Gender, Image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("=== ProductsAdminDAO.create() ===");
        System.out.println("SQL: " + sql);
        System.out.println("Parameters:");
        System.out.println("  1. Product_name: " + name);
        System.out.println("  2. Price: " + price);
        System.out.println("  3. Category_id: " + categoryId);
        System.out.println("  4. Quantity: " + quantity);
        System.out.println("  5. Description: " + description);
        System.out.println("  6. Color: " + color);
        System.out.println("  7. Gender: " + gender);
        System.out.println("  8. Image_url: " + imageUrl);
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, categoryId);
            ps.setInt(4, quantity);
            ps.setString(5, description);
            ps.setString(6, color);
            ps.setString(7, gender);
            ps.setString(8, imageUrl);
            
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows inserted: " + rowsAffected);
            
            if (rowsAffected > 0) {
                System.out.println("✓ Product created successfully in database!");
            } else {
                System.err.println("✗ No rows were inserted!");
            }
        } catch (SQLException e) {
            System.err.println("✗ SQL Error in create()");
            System.err.println("  Message: " + e.getMessage());
            System.err.println("  SQL State: " + e.getSQLState());
            System.err.println("  Error Code: " + e.getErrorCode());
            e.printStackTrace();
        }
    }

    public List<ProductsAdmin> getAll() {
        List<ProductsAdmin> list = new ArrayList<>();
        String sql = "SELECT p.*, c.Category_name FROM PRODUCTS p JOIN CATEGORIES c ON p.Category_id = c.Category_id";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductsAdmin p = new ProductsAdmin();
                p.setProductId(rs.getInt("Product_id"));
                p.setCategoryId(rs.getInt("Category_id"));
                p.setProductName(rs.getString("Product_name"));
                p.setDescription(rs.getString("Description"));
                p.setImageUrl(rs.getString("Image_url"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setColor(rs.getString("Color"));
                p.setSize(rs.getString("Size"));
                p.setGender(rs.getString("Gender"));
                p.setTrending(rs.getBoolean("Trending"));
                p.setCategoryName(rs.getString("Category_name"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ProductsAdmin getById(int id) {
        String sql = "SELECT p.*, c.Category_name FROM PRODUCTS p JOIN CATEGORIES c ON p.Category_id = c.Category_id WHERE p.Product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductsAdmin p = new ProductsAdmin();
                p.setProductId(rs.getInt("Product_id"));
                p.setProductName(rs.getString("Product_name"));
                p.setDescription(rs.getString("Description"));
                p.setImageUrl(rs.getString("Image_url"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setColor(rs.getString("Color"));
                p.setSize(rs.getString("Size"));
                p.setGender(rs.getString("Gender"));
                p.setTrending(rs.getBoolean("Trending"));
                p.setCategoryName(rs.getString("Category_name"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void update(int id, String name, double price, int categoryId, int quantity, String description, String color, String gender, String imageUrl) {
        String sql = "UPDATE PRODUCTS SET Product_name=?, Price=?, Category_id=?, Quantity=?, Description=?, Color=?, Gender=?, Image_url=? WHERE Product_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, categoryId);
            ps.setInt(4, quantity);
            ps.setString(5, description);
            ps.setString(6, color);
            ps.setString(7, gender);
            ps.setString(8, imageUrl);
            ps.setInt(9, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void delete(int id) {
        String sql = "DELETE FROM PRODUCTS WHERE Product_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ProductsAdmin> searchByName(String keyword) {
        List<ProductsAdmin> list = new ArrayList<>();
        String sql = "SELECT p.*, c.Category_name FROM PRODUCTS p JOIN CATEGORIES c ON p.Category_id = c.Category_id WHERE p.Product_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsAdmin p = new ProductsAdmin();
                p.setProductId(rs.getInt("Product_id"));
                p.setCategoryId(rs.getInt("Category_id"));
                p.setProductName(rs.getString("Product_name"));
                p.setDescription(rs.getString("Description"));
                p.setImageUrl(rs.getString("Image_url"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setColor(rs.getString("Color"));
                p.setSize(rs.getString("Size"));
                p.setGender(rs.getString("Gender"));
                p.setTrending(rs.getBoolean("Trending"));
                p.setCategoryName(rs.getString("Category_name"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductsAdmin> searchByCategory(String categoryName) {
    List<ProductsAdmin> list = new ArrayList<>();
    String sql = "SELECT p.*, c.Category_name " +
                 "FROM PRODUCTS p " +
                 "JOIN CATEGORIES c ON p.Category_id = c.Category_id " +
                 "WHERE c.Category_name LIKE ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, "%" + categoryName + "%");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProductsAdmin p = new ProductsAdmin();
            p.setProductId(rs.getInt("Product_id"));
            p.setCategoryId(rs.getInt("Category_id"));
            p.setProductName(rs.getString("Product_name"));
            p.setDescription(rs.getString("Description"));
            p.setImageUrl(rs.getString("Image_url"));
            p.setPrice(rs.getDouble("Price"));
            p.setQuantity(rs.getInt("Quantity"));
            p.setColor(rs.getString("Color"));
            p.setSize(rs.getString("Size"));
            p.setGender(rs.getString("Gender"));
            p.setTrending(rs.getBoolean("Trending"));
            p.setCategoryName(rs.getString("Category_name"));
            list.add(p);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

    public List<ProductsAdmin> sortById() {
        return sort("Product_id ASC");
    }

    public List<ProductsAdmin> sortByNameAZ() {
        return sort("Product_name ASC");
    }

    public List<ProductsAdmin> sortByNameZA() {
        return sort("Product_name DESC");
    }

    public List<ProductsAdmin> sortByPriceLowHigh() {
        return sort("Price ASC");
    }

    public List<ProductsAdmin> sortByPriceHighLow() {
        return sort("Price DESC");
    }

    private List<ProductsAdmin> sort(String order) {
        List<ProductsAdmin> list = new ArrayList<>();
        String sql = "SELECT p.*, c.Category_name FROM PRODUCTS p JOIN CATEGORIES c ON p.Category_id = c.Category_id ORDER BY " + order;
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductsAdmin p = new ProductsAdmin();
                p.setProductId(rs.getInt("Product_id"));
                p.setCategoryId(rs.getInt("Category_id"));
                p.setProductName(rs.getString("Product_name"));
                p.setDescription(rs.getString("Description"));
                p.setImageUrl(rs.getString("Image_url"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setColor(rs.getString("Color"));
                p.setSize(rs.getString("Size"));
                p.setGender(rs.getString("Gender"));
                p.setTrending(rs.getBoolean("Trending"));
                p.setCategoryName(rs.getString("Category_name"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

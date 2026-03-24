package dao;

import java.sql.*;
import java.util.*;
import model.DBContext;
import model.Products;

public class ProductsDAO extends DBContext {

    public void create(String name, double price, int categoryId, int quantity, String description, String color) {
        String sql = "INSERT INTO PRODUCTS (Product_name, Price, Category_id, Quantity, Description, Color) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, categoryId);
            ps.setInt(4, quantity);
            ps.setString(5, description);
            ps.setString(6, color);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Products> getAll() {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT p.*, c.Category_name "
                + "FROM PRODUCTS p LEFT JOIN CATEGORIES c ON p.Category_id = c.Category_id";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("Product_id"));
                p.setCategoryId(rs.getInt("Category_id"));
                p.setCategoryName(rs.getString("Category_name")); // thêm dòng này
                p.setProductName(rs.getString("Product_name"));
                p.setDescription(rs.getString("Description"));
                p.setImageUrl(rs.getString("Image_url"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setColor(rs.getString("Color"));
                p.setSize(rs.getString("Size"));
                p.setGender(rs.getString("Gender"));
                p.setTrending(rs.getBoolean("Trending"));
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Products getById(int id) {
        String sql = "SELECT * FROM PRODUCTS WHERE Product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Products p = new Products();
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
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void update(int id, String name, double price, int categoryId, int quantity, String description, String color) {
        String sql = "UPDATE PRODUCTS SET Product_name=?, Price=?, Category_id=?, Quantity=?, Description=?, Color=? WHERE Product_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, categoryId);
            ps.setInt(4, quantity);
            ps.setString(5, description);
            ps.setString(6, color);
            ps.setInt(7, id);
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

    public List<Products> searchByName(String keyword) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCTS WHERE Product_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
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
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Products> searchByCategory(int categoryId) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCTS WHERE Category_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
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
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Products> sortById() {
        return sort("Product_id ASC");
    }

    public List<Products> sortByNameAZ() {
        return sort("Product_name ASC");
    }

    public List<Products> sortByNameZA() {
        return sort("Product_name DESC");
    }

    public List<Products> sortByPriceLowHigh() {
        return sort("Price ASC");
    }

    public List<Products> sortByPriceHighLow() {
        return sort("Price DESC");
    }

    public List<Products> sortByTrending() {
        return sort("Trending DESC, Product_id DESC");
    }

    public List<Products> sortByNewest() {
        return sort("Product_id DESC");
    }

    private List<Products> sort(String order) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCTS ORDER BY " + order;
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Products p = new Products();
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
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Products> getBestSelling(int limit) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT TOP (?) p.Product_id, p.Product_name, p.Image_url, p.Price, p.Category_id "
                + "FROM PRODUCTS p "
                + "JOIN ORDER_DETAILS od ON p.Product_id = od.Product_id "
                + "JOIN [ORDER] o ON od.Order_id = o.Order_id "
                + "WHERE o.Status IN ('shipping','completed')"
                + "GROUP BY p.Product_id, p.Product_name, p.Image_url, p.Price, p.Category_id "
                + "ORDER BY SUM(od.Quantity) DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("Product_id"));
                p.setProductName(rs.getString("Product_name"));
                p.setImageUrl(rs.getString("Image_url"));
                p.setPrice(rs.getDouble("Price"));
                p.setCategoryId(rs.getInt("Category_id"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Products> getLatestById(int limit) {
    List<Products> list = new ArrayList<>();
    String sql = """
        SELECT Product_id, Product_name, Price, Color, Quantity, Description, Image_url
        FROM PRODUCTS
        ORDER BY Product_id DESC
        OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, limit);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("Product_id"));
                p.setProductName(rs.getString("Product_name"));
                p.setPrice(rs.getDouble("Price"));
                p.setColor(rs.getString("Color"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setDescription(rs.getString("Description"));
                p.setImageUrl(rs.getString("Image_url"));
                list.add(p);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}

}

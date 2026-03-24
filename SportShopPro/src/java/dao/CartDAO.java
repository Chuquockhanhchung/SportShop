package dao;

import java.sql.*;
import java.util.*;
import model.*;

public class CartDAO extends DBContext {

    // Lấy giỏ hàng theo userId
    public Cart getCartByUserId(int userId) {
        Cart cart = null;
        try {
            String sqlCart = "SELECT * FROM CART WHERE User_id = ?";
            PreparedStatement ps = connection.prepareStatement(sqlCart);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cart = new Cart();
                cart.setCartId(rs.getInt("Cart_id"));
                cart.setUserId(userId);
                cart.setItems(new ArrayList<>());

                // Lấy các item của giỏ hàng
                String sqlItems = "SELECT ci.Cart_item_id, ci.Product_id, ci.Quantity, "
                        + "p.Product_name, p.Price, p.Image_url AS ImageUrl "
                        + "FROM CART_ITEMS ci "
                        + "JOIN PRODUCTS p ON ci.Product_id = p.Product_id "
                        + "WHERE ci.Cart_id = ?";

                PreparedStatement ps2 = connection.prepareStatement(sqlItems);
                ps2.setInt(1, cart.getCartId());
                ResultSet rs2 = ps2.executeQuery();

                while (rs2.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs2.getInt("Cart_item_id"));
                    item.setProductId(rs2.getInt("Product_id"));
                    item.setProductName(rs2.getString("Product_name"));
                    item.setQuantity(rs2.getInt("Quantity"));
                    item.setUnitPrice(rs2.getDouble("Price"));
                    item.setImageUrl(rs2.getString("ImageUrl")); // ← Lấy ảnh từ PRODUCTS
                    cart.getItems().add(item);
                }
                rs2.close();
                ps2.close();
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }
    public int getProductQuantity(int productId) throws SQLException {
    String sql = "SELECT Quantity FROM PRODUCTS WHERE Product_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, productId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Quantity");
            }
        }
    }
    return 0;
}

    // Thêm sản phẩm vào giỏ hàng
    // Thêm sản phẩm vào giỏ hàng với log chi tiết
    public void addItemToCart(int cartId, CartItem item) throws SQLException {
        if (cartId <= 0) {
            System.out.println("[CartDAO] Invalid cartId: " + cartId);
            throw new IllegalArgumentException("Cart ID không hợp lệ: " + cartId);
        }
        if (item.getQuantity() <= 0) {
            System.out.println("[CartDAO] Invalid quantity: " + item.getQuantity());
            throw new IllegalArgumentException("Quantity phải > 0: " + item.getQuantity());
        }

        System.out.println("[CartDAO] Adding productId=" + item.getProductId()
                + " qty=" + item.getQuantity() + " to cartId=" + cartId);

        String checkSql = "SELECT Quantity FROM CART_ITEMS WHERE Cart_id = ? AND Product_id = ?";
        try (PreparedStatement checkPs = connection.prepareStatement(checkSql)) {
            checkPs.setInt(1, cartId);
            checkPs.setInt(2, item.getProductId());
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                int newQuantity = rs.getInt("Quantity") + item.getQuantity();
                String updateSql = "UPDATE CART_ITEMS SET Quantity = ? WHERE Cart_id = ? AND Product_id = ?";
                try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                    updatePs.setInt(1, newQuantity);
                    updatePs.setInt(2, cartId);
                    updatePs.setInt(3, item.getProductId());
                    int rows = updatePs.executeUpdate();
                    System.out.println("[CartDAO] Updated rows: " + rows);
                }
            } else {
                String insertSql = "INSERT INTO CART_ITEMS(Cart_id, Product_id, Quantity) VALUES(?, ?, ?)";
                try (PreparedStatement insertPs = connection.prepareStatement(insertSql)) {
                    insertPs.setInt(1, cartId);
                    insertPs.setInt(2, item.getProductId());
                    insertPs.setInt(3, item.getQuantity());
                    int rows = insertPs.executeUpdate();
                    System.out.println("[CartDAO] Inserted rows: " + rows);
                }
            }
        }
    }

    // Cập nhật số lượng sản phẩm trong giỏ
    public void updateCartItem(int cartId, CartItem item) {
        try {
            String sql = "UPDATE CART_ITEMS SET Quantity = ? WHERE Cart_id = ? AND Product_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, item.getQuantity());
            ps.setInt(2, cartId);
            ps.setInt(3, item.getProductId());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void deleteItemFromCart(int cartId, int productId) {
        try {
            String sql = "DELETE FROM CART_ITEMS WHERE Cart_id = ? AND Product_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa tất cả sản phẩm trong giỏ
    public void clearCart(int cartId) {
        try {
            String sql = "DELETE FROM CART_ITEMS WHERE Cart_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Tạo giỏ hàng mới cho user
    public int insertCart(int userId) {
        int cartId = 0;
        try {
            String sql = "INSERT INTO CART(User_id) VALUES(?)";
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                cartId = rs.getInt(1);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartId;
    }
}

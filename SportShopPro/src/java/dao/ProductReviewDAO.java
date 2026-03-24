package dao;

import java.sql.*;
import java.util.*;
import model.DBContext;
import model.ProductReview;

public class ProductReviewDAO extends DBContext {

    public boolean hasPurchased(int userId, int productId) {
//        String sql = """
//            SELECT COUNT(*) 
//            FROM [ORDER] o 
//            JOIN ORDER_DETAILS od ON o.Order_id = od.Order_id
//            WHERE o.User_id = ? AND od.Product_id = ?
//        """;
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, userId);
//            ps.setInt(2, productId);
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) return rs.getInt(1) > 0;
//            }
//        } catch (SQLException e) { e.printStackTrace(); }
        return true;
    }

    public void addReview(ProductReview r) {
        String sql = "INSERT INTO PRODUCT_REVIEWS(Product_id, User_id, Rating, Comment, Is_approved) VALUES(?,?,?,?,0)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, r.getProductId());
            ps.setInt(2, r.getUserId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        ProductReviewDAO d = new ProductReviewDAO();
        d.approve(14, true);
    }

    public List<ProductReview> getAllForAdminPaged(int page, int pageSize) {
        List<ProductReview> list = new ArrayList<>();
        String sql = """
        SELECT r.*, u.User_full_name, u.User_avatar, p.Product_name
        FROM PRODUCT_REVIEWS r
        JOIN [USER] u ON r.User_id = u.User_id
        JOIN PRODUCTS p ON r.Product_id = p.Product_id
        ORDER BY r.Created_at DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM PRODUCT_REVIEWS";
        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ProductReview> getApprovedByProduct(int productId) {
        List<ProductReview> list = new ArrayList<>();
        String sql = """
            SELECT r.*, u.User_full_name, u.User_avatar, p.Product_name
            FROM PRODUCT_REVIEWS r
            JOIN [USER] u ON r.User_id = u.User_id
            JOIN PRODUCTS p ON r.Product_id = p.Product_id
            WHERE r.Product_id = ? AND r.Is_approved = 1
            ORDER BY r.Created_at DESC
        """;
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductReview r = map(rs);
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductReview> getAllForAdmin() {
        List<ProductReview> list = new ArrayList<>();
        String sql = """
            SELECT r.*, u.User_full_name, u.User_avatar, p.Product_name
            FROM PRODUCT_REVIEWS r
            JOIN [USER] u ON r.User_id = u.User_id
            JOIN PRODUCTS p ON r.Product_id = p.Product_id
            ORDER BY r.Created_at DESC
        """;
        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void approve(int reviewId, boolean approved) {
        String sql = "UPDATE PRODUCT_REVIEWS SET Is_approved=? WHERE Review_id=?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, approved);
            ps.setInt(2, reviewId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int reviewId) {
        String sql = "DELETE FROM PRODUCT_REVIEWS WHERE Review_id=?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private ProductReview map(ResultSet rs) throws SQLException {
        ProductReview r = new ProductReview();
        r.setReviewId(rs.getInt("Review_id"));
        r.setProductId(rs.getInt("Product_id"));
        r.setUserId(rs.getInt("User_id"));
        r.setRating(rs.getInt("Rating"));
        r.setComment(rs.getString("Comment"));
        r.setCreatedAt(rs.getTimestamp("Created_at"));
        r.setApproved(rs.getBoolean("Is_approved"));
        r.setUserFullName(rs.getString("User_full_name"));
        r.setUserAvatar(rs.getString("User_avatar"));
        r.setProductName(rs.getString("Product_name"));
        return r;
    }
}

package dao;

import java.sql.*;
import java.util.*;
import model.*;

public class OrderAdminDAO extends DBContext {

    public List<OrderAdmin> getAll() {
        List<OrderAdmin> list = new ArrayList<>();
        String sql = "SELECT o.*, u.User_full_name AS userFullName FROM [ORDER] o JOIN [USER] u ON o.User_id = u.User_id";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderAdmin o = new OrderAdmin();
                o.setOrderId(rs.getInt("Order_id"));
                o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                o.setUserId(rs.getInt("User_id"));
                o.setOrderDate(rs.getTimestamp("Order_date"));
                o.setAddress(rs.getString("Address"));
                o.setTotalPrice(rs.getDouble("Total_price"));
                o.setStatus(rs.getString("Status"));
                o.setTrackingNumber(rs.getString("Tracking_number"));
                o.setUserFullName(rs.getString("userFullName"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderAdmin> searchById(int id) {
        List<OrderAdmin> list = new ArrayList<>();
        String sql = "SELECT o.*, u.User_full_name AS userFullName FROM [ORDER] o JOIN [USER] u ON o.User_id = u.User_id WHERE o.Order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderAdmin o = new OrderAdmin();
                    o.setOrderId(rs.getInt("Order_id"));
                    o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                    o.setUserId(rs.getInt("User_id"));
                    o.setOrderDate(rs.getTimestamp("Order_date"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotalPrice(rs.getDouble("Total_price"));
                    o.setStatus(rs.getString("Status"));
                    o.setTrackingNumber(rs.getString("Tracking_number"));
                    o.setUserFullName(rs.getString("userFullName"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderAdmin> searchByCustomerName(String name) {
        List<OrderAdmin> list = new ArrayList<>();
        String sql = "SELECT o.*, u.User_full_name AS userFullName FROM [ORDER] o JOIN [USER] u ON o.User_id = u.User_id WHERE u.User_full_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderAdmin o = new OrderAdmin();
                    o.setOrderId(rs.getInt("Order_id"));
                    o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                    o.setUserId(rs.getInt("User_id"));
                    o.setOrderDate(rs.getTimestamp("Order_date"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotalPrice(rs.getDouble("Total_price"));
                    o.setStatus(rs.getString("Status"));
                    o.setTrackingNumber(rs.getString("Tracking_number"));
                    o.setUserFullName(rs.getString("userFullName"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderAdmin> getByStatus(String status) {
        List<OrderAdmin> list = new ArrayList<>();
        String sql = "SELECT o.*, u.User_full_name AS userFullName FROM [ORDER] o JOIN [USER] u ON o.User_id = u.User_id WHERE o.Status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderAdmin o = new OrderAdmin();
                    o.setOrderId(rs.getInt("Order_id"));
                    o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                    o.setUserId(rs.getInt("User_id"));
                    o.setOrderDate(rs.getTimestamp("Order_date"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotalPrice(rs.getDouble("Total_price"));
                    o.setStatus(rs.getString("Status"));
                    o.setTrackingNumber(rs.getString("Tracking_number"));
                    o.setUserFullName(rs.getString("userFullName"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderAdmin> sortByDate(boolean newest) {
        List<OrderAdmin> list = new ArrayList<>();
        String sql = "SELECT o.*, u.User_full_name AS userFullName FROM [ORDER] o JOIN [USER] u ON o.User_id = u.User_id ORDER BY o.Order_date " + (newest ? "DESC" : "ASC");
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderAdmin o = new OrderAdmin();
                o.setOrderId(rs.getInt("Order_id"));
                o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                o.setUserId(rs.getInt("User_id"));
                o.setOrderDate(rs.getTimestamp("Order_date"));
                o.setAddress(rs.getString("Address"));
                o.setTotalPrice(rs.getDouble("Total_price"));
                o.setStatus(rs.getString("Status"));
                o.setTrackingNumber(rs.getString("Tracking_number"));
                o.setUserFullName(rs.getString("userFullName"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void update(int id, String status) {
        String sql = "UPDATE [ORDER] SET Status=? WHERE Order_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM [ORDER] WHERE Order_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

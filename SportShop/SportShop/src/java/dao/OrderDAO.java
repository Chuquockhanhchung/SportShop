package dao;

import java.sql.*;
import java.util.*;
import model.DBContext;
import model.Order;
import model.OrderItem;

public class OrderDAO extends DBContext {
// ✅ Thêm đơn hàng mới
    public int insertOrder(Order order) throws Exception {
        int orderId = -1;
        String sql = "INSERT INTO [ORDER] (Cart_id, User_id, Address, Total_price, Status, Tracking_number) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {


            System.out.println("🧩 [DEBUG] insertOrder() using DB: " + connection.getCatalog());

            ps.setInt(1, order.getCartId());
            ps.setInt(2, order.getUserId());
            ps.setString(3, order.getAddress());
            ps.setDouble(4, order.getTotal());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getTrackingNumber());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) orderId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("⚠️ SQLException khi insertOrder:");
            e.printStackTrace();
            throw e;
        }

        System.out.println("✅ OrderID mới tạo: " + orderId);
        return orderId;
    }

    // ✅ Thêm chi tiết đơn hàng
    public void insertOrderDetails(int orderId, List<OrderItem> items) throws Exception {
        String sql = "INSERT INTO [ORDER_DETAILS] (Order_id, Product_id, Quantity, Unit_price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {


            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();
            }
            ps.executeBatch();

            System.out.println("✅ insertOrderDetails(): " + items.size() + " items saved for Order " + orderId);

        } catch (SQLException e) {
            System.out.println("⚠️ SQLException khi insertOrderDetails:");
            e.printStackTrace();
        }
    }

    // ✅ Lấy sản phẩm theo Order_id
    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws Exception {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT od.Order_detail_id, od.Product_id, p.Product_name, od.Quantity, od.Unit_price " +
                     "FROM ORDER_DETAILS od " +
                     "JOIN PRODUCTS p ON od.Product_id = p.Product_id " +
                     "WHERE od.Order_id = ?";

        System.out.println("🧩 [DEBUG] getOrderItemsByOrderId() -> Order_id input = " + orderId);

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {


            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("Order_detail_id"));
                item.setProductId(rs.getInt("Product_id"));
                item.setProductName(rs.getString("Product_name"));
                item.setQuantity(rs.getInt("Quantity"));
                item.setUnitPrice(rs.getDouble("Unit_price"));
                list.add(item);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getOrdersByUserId(int userId) throws Exception {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [ORDER] WHERE User_id = ? ORDER BY Order_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("Order_id"));
                o.setCartId(rs.getInt("Cart_id"));
                o.setUserId(rs.getInt("User_id"));
                o.setAddress(rs.getString("Address"));
                o.setTotal(rs.getDouble("Total_price"));
                o.setStatus(rs.getString("Status"));
                o.setTrackingNumber(rs.getString("Tracking_number"));
                o.setOrderDate(rs.getTimestamp("Order_date"));

                List<OrderItem> items = getOrderItemsByOrderId(o.getOrderId());
                o.setItems(items);
                orders.add(o);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderById(int id) throws Exception {
        Order o = null;
        String sql = "SELECT * FROM [ORDER] WHERE Order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                o = new Order();
                o.setOrderId(rs.getInt("Order_id"));
                o.setCartId(rs.getInt("Cart_id"));
                o.setUserId(rs.getInt("User_id"));
                o.setAddress(rs.getString("Address"));
                o.setTotal(rs.getDouble("Total_price"));
                o.setStatus(rs.getString("Status"));
                o.setTrackingNumber(rs.getString("Tracking_number"));
                o.setOrderDate(rs.getTimestamp("Order_date"));
                o.setItems(getOrderItemsByOrderId(id));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return o;
    }

    public List<Order> getAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [ORDER]";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("Order_id"));
                o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                o.setUserId(rs.getInt("User_id"));
                o.setOrderDate(rs.getTimestamp("Order_date"));
                o.setAddress(rs.getString("Address"));
                o.setTotal(rs.getDouble("Total_price"));
                o.setStatus(rs.getString("Status"));
                o.setTrackingNumber(rs.getString("Tracking_number"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> searchById(int id) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [ORDER] WHERE Order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("Order_id"));
                    o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                    o.setUserId(rs.getInt("User_id"));
                    o.setOrderDate(rs.getTimestamp("Order_date"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotal(rs.getDouble("Total_price"));
                    o.setStatus(rs.getString("Status"));
                    o.setTrackingNumber(rs.getString("Tracking_number"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> searchByCustomerName(String name) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.* FROM [ORDER] o JOIN [USER] u ON o.User_id = u.User_id WHERE u.User_full_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("Order_id"));
                    o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                    o.setUserId(rs.getInt("User_id"));
                    o.setOrderDate(rs.getTimestamp("Order_date"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotal(rs.getDouble("Total_price"));
                    o.setStatus(rs.getString("Status"));
                    o.setTrackingNumber(rs.getString("Tracking_number"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getByStatus(String status) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [ORDER] WHERE Status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("Order_id"));
                    o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                    o.setUserId(rs.getInt("User_id"));
                    o.setOrderDate(rs.getTimestamp("Order_date"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotal(rs.getDouble("Total_price"));
                    o.setStatus(rs.getString("Status"));
                    o.setTrackingNumber(rs.getString("Tracking_number"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
   public void cancelOrder(int orderId) throws SQLException {
    String updateStatusSql = "UPDATE [ORDER] SET Status = ? WHERE Order_id = ? AND Status <> ?";
    String restockSql =
        "UPDATE p " +
        "SET p.Quantity = p.Quantity + od.Quantity " +
        "FROM PRODUCTS p " +
        "JOIN ORDER_DETAILS od ON p.Product_id = od.Product_id " +
        "WHERE od.Order_id = ?";

    try {
        connection.setAutoCommit(false);

        try (PreparedStatement ps = connection.prepareStatement(updateStatusSql)) {
            ps.setString(1, "Cancelled");
            ps.setInt(2, orderId);
            ps.setString(3, "Cancelled");
            ps.executeUpdate();
        }

        try (PreparedStatement ps = connection.prepareStatement(restockSql)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        }

        connection.commit();
    } catch (SQLException ex) {
        connection.rollback();
        throw ex;
    } finally {
        connection.setAutoCommit(true);
    }
}

    public List<Order> sortByDate(boolean newest) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [ORDER] ORDER BY Order_date " + (newest ? "DESC" : "ASC");
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("Order_id"));
                o.setCartId(rs.getObject("Cart_id") != null ? rs.getInt("Cart_id") : null);
                o.setUserId(rs.getInt("User_id"));
                o.setOrderDate(rs.getTimestamp("Order_date"));
                o.setAddress(rs.getString("Address"));
                o.setTotal(rs.getDouble("Total_price"));
                o.setStatus(rs.getString("Status"));
                o.setTrackingNumber(rs.getString("Tracking_number"));
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

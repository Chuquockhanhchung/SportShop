package dao;

import java.sql.*;
import model.Payment;
import java.math.BigDecimal;
import model.DBContext; // kế thừa kết nối DB

public class PaymentDAO extends DBContext {

    // Thêm payment mới
    public void addPayment(Payment payment) throws SQLException {
    String insertPaymentSql = "INSERT INTO PAYMENT (Order_id, Method, Status, Amount) VALUES (?, ?, ?, ?)";
    String updateStockSql =
        "UPDATE p " +
        "SET p.Quantity = p.Quantity - od.Quantity " +
        "FROM PRODUCTS p " +
        "JOIN ORDER_DETAILS od ON p.Product_id = od.Product_id " +
        "WHERE od.Order_id = ?";

    try {
        connection.setAutoCommit(false);

        try (PreparedStatement ps = connection.prepareStatement(insertPaymentSql)) {
            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getMethod());
            ps.setString(3, payment.getStatus());
            ps.setDouble(4, payment.getAmount());
            ps.executeUpdate();
        }

        try (PreparedStatement ps = connection.prepareStatement(updateStockSql)) {
            ps.setInt(1, payment.getOrderId());
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

    // Lấy payment theo Order_id (nếu cần)
    public Payment getPaymentByOrderId(int orderId) throws SQLException {
        String sql = "SELECT * FROM PAYMENT WHERE Order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("Payment_id"));
                p.setOrderId(rs.getInt("Order_id"));
                p.setMethod(rs.getString("Method"));
                p.setStatus(rs.getString("Status"));
                p.setAmount(rs.getDouble("Amount"));
                return p;
            }
        }
        return null;
    }
}

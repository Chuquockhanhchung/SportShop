/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.DBContext;

/**
 *
 * @author LE DUC ANH
 */
public class DashBoardDAO extends DBContext {

    // ✅ Lấy tổng số đơn hàng trong khoảng ngày (không tính %)
    public int sumOrdersByDateRange(String startDate, String endDate) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Sử dụng BETWEEN để lọc theo khoảng ngày
        String sql = "SELECT COUNT(*) AS totalOrders FROM [ORDER] WHERE Order_date >= ? AND Order_date < DATEADD(day, 1, ?)";

        try {
            // Bước 1: Kết nối DB
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);

            // Bước 3: Thực thi truy vấn
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("totalOrders");
            }

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

        return 0; // Nếu không có đơn hàng nào
    }

    public int sumItemsSoldByDateRange(String startDate, String endDate) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // SQL: Tính tổng Quantity từ ORDER_DETAILS,
        // kết nối với [ORDER] để lọc theo ngày và trạng thái
        String sql = "SELECT SUM(od.Quantity) AS totalItemsSold "
                + "FROM ORDER_DETAILS od "
                + "JOIN [ORDER] o ON od.Order_id = o.Order_id "
                + "WHERE o.Order_date >= ? AND o.Order_date < DATEADD(day, 1, ?) "
                + "AND o.Status != 'Cancelled'"; // Chỉ tính các đơn hàng thành công

        try {
            // Bước 1: Kết nối DB
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);

            // Bước 3: Thực thi truy vấn
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // getInt sẽ trả về 0 nếu kết quả SUM là NULL (không có bản ghi nào)
                return rs.getInt("totalItemsSold");
            }

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

        return 0; // Nếu không có sản phẩm nào được bán
    }

    /**
     * ✅ [ĐÃ SỬA] Lấy thống kê đơn hàng cho biểu đồ THEO KHOẢNG NGÀY. Nhóm theo
     * Tháng/Năm.
     *
     * @return Map<String, Integer> với Key="Tháng/Năm", Value="Số đơn"
     */
    public java.util.Map<String, Integer> getOrderStatsByDateRange(String startDate, String endDate) {
        java.util.Map<String, Integer> orderStats = new java.util.LinkedHashMap<>();

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT "
                + "    FORMAT(Order_date, 'MM/yyyy') AS MonthYear, "
                + "    COUNT(Order_id) AS OrderCount "
                + "FROM [ORDER] "
                + "WHERE "
                // Lọc theo ngày người dùng chọn
                + "    Order_date >= ? AND Order_date < DATEADD(day, 1, ?) "
                + "    AND Status != 'Cancelled' "
                + "GROUP BY "
                + "    YEAR(Order_date), MONTH(Order_date), FORMAT(Order_date, 'MM/yyyy') "
                + "ORDER BY "
                + "    YEAR(Order_date), MONTH(Order_date);";

        try {
            pstmt = connection.prepareStatement(sql);

            // Set tham số ngày
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                orderStats.put(
                        rs.getString("MonthYear"),
                        rs.getInt("OrderCount")
                );
            }
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
        return orderStats;
    }

    /**
     * ✅ [ĐÃ SỬA] Lấy thống kê sản phẩm đã bán theo danh mục THEO KHOẢNG NGÀY.
     *
     * @return Map<String, Integer> với Key="Tên Category", Value="Số lượng bán"
     */
    public java.util.Map<String, Integer> getSalesByCategoryByDateRange(String startDate, String endDate) {
        java.util.Map<String, Integer> salesStats = new java.util.LinkedHashMap<>();

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT "
                + "    c.Category_name, "
                + "    SUM(od.Quantity) AS TotalSold "
                + "FROM "
                + "    ORDER_DETAILS od "
                + "JOIN "
                + "    [ORDER] o ON od.Order_id = o.Order_id "
                + "JOIN "
                + "    PRODUCTS p ON od.Product_id = p.Product_id "
                + "JOIN "
                + "    CATEGORIES c ON p.Category_id = c.Category_id "
                + "WHERE "
                // Lọc theo ngày người dùng chọn
                + "    o.Order_date >= ? AND o.Order_date < DATEADD(day, 1, ?) "
                + "    AND o.Status != 'Cancelled' "
                + "GROUP BY "
                + "    c.Category_name "
                + "ORDER BY "
                + "    TotalSold DESC;";

        try {
            pstmt = connection.prepareStatement(sql);

            // Set tham số ngày
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                salesStats.put(
                        rs.getString("Category_name"),
                        rs.getInt("TotalSold")
                );
            }
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
        return salesStats;
    }

    /**
     * ✅ Lấy tổng số lượng hàng tồn kho (hiện tại).
     *
     * @return Tổng số lượng (Quantity) từ bảng PRODUCTS
     */
    public int getTotalInventory() {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Đơn giản là tính tổng cột Quantity
        String sql = "SELECT SUM(Quantity) AS totalInventory FROM PRODUCTS";

        try {
            // Bước 1: Kết nối DB
            pstmt = connection.prepareStatement(sql);

            // Bước 3: Thực thi truy vấn
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // getInt sẽ trả về 0 nếu SUM là NULL
                return rs.getInt("totalInventory");
            }

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
        return 0; // Nếu có lỗi
    }

    /**
     * ✅ Lấy tổng DOANH THU (Revenue) theo khoảng ngày. Chỉ tính các đơn hàng
     * 'Shipped' hoặc 'Delivered'.
     *
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @return Tổng doanh thu (double)
     */
    public double getRevenueByDateRange(String startDate, String endDate) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Tính tổng Total_price từ các đơn hàng đã hoàn thành
        String sql = "SELECT SUM(Total_price) AS TotalRevenue "
                + "FROM [ORDER] "
                + "WHERE Order_date >= ? AND Order_date < DATEADD(day, 1, ?) "
                + "AND Status IN ('Shipped', 'Delivered')"; // Chỉ tính doanh thu thực

        try {
            // Bước 1: Kết nối DB
            pstmt = connection.prepareStatement(sql);;
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);

            // Bước 3: Thực thi truy vấn
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Doanh thu là kiểu double (tiền)
                return rs.getDouble("TotalRevenue");
            }

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
        return 0.0; // Nếu không có doanh thu
    }
}

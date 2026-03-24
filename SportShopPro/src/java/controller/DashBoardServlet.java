/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DashBoardDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;
import model.DashBoardStats;

/**
 *
 * @author LE DUC ANH
 */
@WebServlet(name = "DashBoardServlet", urlPatterns = {"/dashboard"})
public class DashBoardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
            startDate = "2020-01-01";
            endDate = "2025-12-31";
            request.setAttribute("startDate", null);
            request.setAttribute("endDate", null);
        } else {
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
        }

        DashBoardDAO dao = new DashBoardDAO();
        int totalOrders = dao.sumOrdersByDateRange(startDate, endDate);
        int totalItemsSold = dao.sumItemsSoldByDateRange(startDate, endDate);
        int totalInventory = dao.getTotalInventory();
        
        double totalRevenue = dao.getRevenueByDateRange(startDate, endDate);
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat numberFormat = NumberFormat.getNumberInstance(localeVN);
        numberFormat.setMaximumFractionDigits(0); // Không lấy số lẻ
        String formattedRevenueString = numberFormat.format(totalRevenue);
        
        DashBoardStats stats = new DashBoardStats();
        
        stats.setTotalOrders(totalOrders);
        stats.setTotalItemsSold(totalItemsSold);
        stats.setTotalInventory(totalInventory);
        stats.setFormattedRevenue(formattedRevenueString);
        
        request.setAttribute("dashboardStats", stats);

        Map<String, Integer> orderStats = dao.getOrderStatsByDateRange(startDate, endDate);

        List<String> orderLabels = new ArrayList<>();
        for (String key : orderStats.keySet()) {
            orderLabels.add("\"" + key + "\""); 
        }
        String orderLabelsJson = "[" + String.join(",", orderLabels) + "]";

        List<Integer> orderData = new ArrayList<>(orderStats.values());
        String orderDataJson = "[" + orderData.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(",")) + "]";

        request.setAttribute("ordersChartLabels", orderLabelsJson);
        request.setAttribute("ordersChartData", orderDataJson);

      
        Map<String, Integer> salesStats = dao.getSalesByCategoryByDateRange(startDate, endDate);

        List<String> salesLabels = new ArrayList<>();
        for (String key : salesStats.keySet()) {
            salesLabels.add("\"" + key + "\"");
        }
        String salesLabelsJson = "[" + String.join(",", salesLabels) + "]";

        List<Integer> salesData = new ArrayList<>(salesStats.values());
        String salesDataJson = "[" + salesData.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(",")) + "]";

        request.setAttribute("salesChartLabels", salesLabelsJson);
        request.setAttribute("salesChartData", salesDataJson);

        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
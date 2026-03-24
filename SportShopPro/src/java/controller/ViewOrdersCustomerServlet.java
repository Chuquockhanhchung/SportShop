package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.User;

@WebServlet(name = "ViewOrdersCustomerServlet", urlPatterns = {"/viewoders"})
public class ViewOrdersCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("account");
        int userId = user.getUserId();

        try {
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getOrdersByUserId(userId);

            // ===== PAGINATION =====
            int pageSize = 2;
            int currentPage = 1;
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
                if (currentPage < 1) currentPage = 1;
            } catch (Exception e) {
                currentPage = 1;
            }

            int totalOrders = orders.size();
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

            int start = (currentPage - 1) * pageSize;
            int end = Math.min(start + pageSize, totalOrders);

            List<Order> pageList = new ArrayList<>();
            if (start < end) {
                pageList = orders.subList(start, end);
            }

            request.setAttribute("orders", pageList);

            // pagination attrs
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("baseUrl", "viewoders?");

            request.getRequestDispatcher("viewoders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
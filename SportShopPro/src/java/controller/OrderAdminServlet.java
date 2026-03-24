package controller;

import dao.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import model.OrderAdmin;
import java.util.ArrayList;

@WebServlet("/order")
public class OrderAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderAdminDAO dao = new OrderAdminDAO();
        String search = request.getParameter("search");
        String statusFilter = request.getParameter("statusFilter");
        String sort = request.getParameter("sort");
        String action = request.getParameter("action");
        List<OrderAdmin> list = dao.getAll();
        try {
            if (search != null && !search.isEmpty()) {
                try {
                    int id = Integer.parseInt(search);
                    list = dao.searchById(id);
                } catch (NumberFormatException e) {
                    list = dao.searchByCustomerName(search);
                }
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                list = dao.getByStatus(statusFilter);
            }
            if (sort != null && !sort.isEmpty()) {
                boolean newest = sort.equals("date-desc");
                list.sort((o1, o2) -> {
                    if (o1.getOrderDate() == null || o2.getOrderDate() == null) {
                        return 0;
                    }
                    return newest
                            ? o2.getOrderDate().compareTo(o1.getOrderDate())
                            : o1.getOrderDate().compareTo(o2.getOrderDate());
                });
            }

            if (action != null && action.equals("view")) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    try {
                        int id = Integer.parseInt(idStr);
                        List<OrderAdmin> orderListById = dao.searchById(id);
                        if (!orderListById.isEmpty()) {
                            OrderAdmin selected = orderListById.get(0);
                            request.setAttribute("orderToView", selected);
                            request.setAttribute("openModal", "orderDetailModal");
                        }
                    } catch (NumberFormatException ignore) {
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            list = dao.getAll();
        }

        // ===== PAGINATION =====
        int pageSize = 5;
        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
            if (currentPage < 1) currentPage = 1;
        } catch (Exception e) {
            currentPage = 1;
        }

        int totalOrders = list.size();
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, totalOrders);

        List<OrderAdmin> pageList = new ArrayList<>();
        if (start < end) {
            pageList = list.subList(start, end);
        }

        String baseUrl = "order?search=" + (search != null ? search : "")
                + "&statusFilter=" + (statusFilter != null ? statusFilter : "")
                + "&sort=" + (sort != null ? sort : "");

        request.setAttribute("orderList", pageList);
        request.setAttribute("totalOrders", totalOrders);

        // pagination attrs
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("baseUrl", baseUrl);

        RequestDispatcher rd = request.getRequestDispatcher("admin_orders.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        OrderAdminDAO dao = new OrderAdminDAO();
        List<OrderAdmin> list = dao.getAll();
        try {
            if (action != null && !action.isEmpty()) {
                if (action.equals("update")) {
                    int orderId = Integer.parseInt(request.getParameter("id"));
                    String status = request.getParameter("status");
                    dao.update(orderId, status);
                } else if (action.equals("delete")) {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    dao.delete(deleteId);
                }
                list = dao.getAll();
            }
        } catch (Exception e) {
            e.printStackTrace();
            list = dao.getAll();
        }
        request.setAttribute("orderList", list);
        request.setAttribute("totalOrders", list.size());
        RequestDispatcher rd = request.getRequestDispatcher("admin_orders.jsp");
        rd.forward(request, response);
    }
}
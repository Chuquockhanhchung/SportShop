package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.OrderDAO;
import model.User;

@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/cancel-order"})
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            OrderDAO orderDAO = new OrderDAO();
            orderDAO.cancelOrder(orderId);

            response.sendRedirect("viewoders");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewoders");
        }
    }
}
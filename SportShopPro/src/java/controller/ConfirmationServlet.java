package controller;

import dao.CartDAO;
import dao.OrderDAO;
import dao.PaymentDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.*;

@WebServlet(name = "ConfirmationServlet", urlPatterns = {"/confirmation"})
public class ConfirmationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null
                || session.getAttribute("confirmCart") == null) {
            response.sendRedirect("cart.jsp");
            return;
        }
        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        User user = (User) session.getAttribute("account");
        Cart cart = (Cart) session.getAttribute("confirmCart");
        if (user == null || cart == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            response.sendRedirect("confirmation.jsp");
            return;
        }

        try {
            List<CartItem> cartItems = cart.getItems();
            if (cartItems.isEmpty()) {
                response.sendRedirect("cart.jsp");
                return;
            }

            CartDAO cartDAO = new CartDAO();
            if (cart.getCartId() <= 0) {
                cart.setCartId(cartDAO.insertCart(user.getUserId()));
            }

            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setCartId(cart.getCartId());
            order.setAddress(user.getAddress());
            order.setTotal(cart.getTotal());
            order.setStatus("Pending");
            order.setTrackingNumber("TRK-" + System.currentTimeMillis());

            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.insertOrder(order);

            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem item : cartItems) {
                OrderItem detail = new OrderItem();
                detail.setProductId(item.getProductId());
                detail.setQuantity(item.getQuantity());
                detail.setUnitPrice(item.getUnitPrice());
                orderItems.add(detail);
            }
            orderDAO.insertOrderDetails(orderId, orderItems);

            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setMethod(paymentMethod);
            payment.setStatus("Paid");
            payment.setAmount(cart.getTotal());
            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.addPayment(payment);

            // Kiểm tra xem có phải "Mua ngay" không
            Cart buyNowCart = (Cart) session.getAttribute("buyNowCart");
            if (buyNowCart != null) {
                // Nếu là "Mua ngay", chỉ xóa session buyNowCart, không xóa cart database
                session.removeAttribute("buyNowCart");
            } else {
                // Nếu là giỏ hàng bình thường, xóa cart trong database
                cartDAO.clearCart(cart.getCartId());
            }

            session.removeAttribute("confirmCart");

            response.sendRedirect("order-success.jsp?orderId=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp");
        }
    }
}

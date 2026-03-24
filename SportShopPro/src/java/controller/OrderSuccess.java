package controller;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ProductsDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import model.*;

@WebServlet(name = "OrderSuccess", urlPatterns = {"/orderSuccess"})
public class OrderSuccess extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        Cart cart = (Cart) session.getAttribute("confirmCart");
        Random rand = new Random();
        int code = rand.nextInt(100);

        if(user == null || cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        String fullname = (String) session.getAttribute("confirmFullname");
        String phone = (String) session.getAttribute("confirmPhone");
        String address = (String) session.getAttribute("confirmAddress");
        String note = (String) session.getAttribute("confirmNote");

        CartDAO cartDAO = new CartDAO();
        OrderDAO orderDAO = new OrderDAO();
        ProductsDAO productDAO = new ProductsDAO();

        try {
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setCartId(cart.getCartId());
            order.setAddress(address);
            order.setTotal(cart.getTotal());
            order.setStatus("Pending");
            order.setTrackingNumber("VN-" + code);

            int orderId = orderDAO.insertOrder(order);

            List<OrderItem> orderItems = new ArrayList<>();
            for(CartItem c : cart.getItems()) {
                OrderItem oi = new OrderItem();
                oi.setProductId(c.getProductId());
                oi.setQuantity(c.getQuantity());
                oi.setUnitPrice(c.getUnitPrice());
                orderItems.add(oi);
            }

            orderDAO.insertOrderDetails(orderId, orderItems);

            cartDAO.clearCart(cart.getCartId());
            session.removeAttribute("cart");
            session.removeAttribute("confirmCart");
            session.removeAttribute("confirmFullname");
            session.removeAttribute("confirmPhone");
            session.removeAttribute("confirmAddress");
            session.removeAttribute("confirmNote");

            response.sendRedirect("order-success.jsp?orderId=" + orderId);

        } catch(Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("confirmation.jsp").forward(request, response);
        }
    }
}

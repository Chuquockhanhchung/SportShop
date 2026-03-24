package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;
import dao.CartDAO;
import java.util.ArrayList;

@WebServlet(name = "DeleteServlet", urlPatterns = {"/delete"})
public class DeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            response.sendRedirect("cart");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        String clearAll = request.getParameter("clearAll");
        if ("true".equals(clearAll)) {
            if (cart.getCartId() > 0) {
                cartDAO.clearCart(cart.getCartId());
            }
            cart.setItems(new ArrayList<>());
        } else {
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null && !productIdStr.isEmpty()) {
                int productId = Integer.parseInt(productIdStr);
                if (cart.getCartId() > 0) {
                    cartDAO.deleteItemFromCart(cart.getCartId(), productId);
                }
                cart.getItems().removeIf(item -> item.getProductId() == productId);
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart"); 
    }
}

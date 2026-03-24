package controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;
import dao.CartDAO;
import dao.ProductsDAO;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        CartDAO cartDAO = new CartDAO();
        Cart cart = null;

        if (user == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("userId".equals(c.getName())) {
                        try {
                            int userId = Integer.parseInt(c.getValue());
                            user = new User();
                            user.setUserId(userId);
                            session.setAttribute("account", user);
                        } catch (NumberFormatException ex) {
                            ex.printStackTrace();
                        }
                    }
                }
            }
        }

        if (user != null) {
            cart = cartDAO.getCartByUserId(user.getUserId());
            if (cart == null) {
                int cartId = cartDAO.insertCart(user.getUserId());
                cart = new Cart();
                cart.setCartId(cartId);
                cart.setUserId(user.getUserId());
                cart.setItems(new ArrayList<>());
            }
        } else {
            cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                cart.setItems(new ArrayList<>());
                session.setAttribute("cart", cart);
            }
        }
       
        Map<Integer, Integer> stockMap = new HashMap<>();

        if (cart != null && cart.getItems() != null) {
            for (CartItem item : cart.getItems()) {
                int stock;
                try {
                    stock = cartDAO.getProductQuantity(item.getProductId());
                    stockMap.put(item.getProductId(), stock);
                } catch (SQLException ex) {
                    Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
        }

        request.setAttribute("stockMap", stockMap);
        session.setAttribute("cart", cart);
        request.setAttribute("cart", cart);
        request.setAttribute("getTotal", cart.getTotal());

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");

            // Xử lý cập nhật số lượng sản phẩm trong giỏ hàng
            if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity <= 0) {
                    quantity = 1;
                }

                CartDAO cartDAO = new CartDAO();
                Cart cart = cartDAO.getCartByUserId(user.getUserId());

                if (cart != null) {
                    CartItem updateItem = new CartItem();
                    updateItem.setProductId(productId);
                    updateItem.setQuantity(quantity);

                    cartDAO.updateCartItem(cart.getCartId(), updateItem);

                    // Cập nhật lại cart trong session
                    Cart updatedCart = cartDAO.getCartByUserId(user.getUserId());
                    session.setAttribute("cart", updatedCart);
                }

                response.sendRedirect("cart");
                return;
            }

            // Kiểm tra nếu là "Mua ngay"
            String buyNow = request.getParameter("buyNow");

            if ("true".equals(buyNow)) {
                // Xử lý mua ngay - không thêm vào giỏ hàng database
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity <= 0) {
                    quantity = 1;
                }

                ProductsDAO productDAO = new ProductsDAO();
                Products product = productDAO.getById(productId);

                // Tạo cart tạm thời chỉ chứa sản phẩm mua ngay
                Cart buyNowCart = new Cart();
                buyNowCart.setUserId(user.getUserId());
                buyNowCart.setItems(new ArrayList<>());

                CartItem buyNowItem = new CartItem();
                buyNowItem.setProductId(productId);
                buyNowItem.setProductName(product.getProductName());
                buyNowItem.setQuantity(quantity);
                buyNowItem.setUnitPrice(product.getPrice());
                buyNowItem.setImageUrl(product.getImageUrl());

                buyNowCart.getItems().add(buyNowItem);

                // Lưu vào session với key riêng
                session.setAttribute("buyNowCart", buyNowCart);
                response.sendRedirect("checkout");
                return;
            }

            // Xử lý thêm sản phẩm vào giỏ hàng (logic bình thường)
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            if (quantity <= 0) {
                quantity = 1;
            }

            ProductsDAO productDAO = new ProductsDAO();
            Products product = productDAO.getById(productId);
            CartDAO cartDAO = new CartDAO();
            Cart cart = cartDAO.getCartByUserId(user.getUserId());

            if (cart == null) {
                int cartId = cartDAO.insertCart(user.getUserId());
                cart = new Cart();
                cart.setCartId(cartId);
                cart.setUserId(user.getUserId());
                cart.setItems(new ArrayList<>());
            }

            CartItem newItem = new CartItem();
            newItem.setProductId(productId);
            newItem.setProductName(product.getProductName());
            newItem.setQuantity(quantity);
            newItem.setUnitPrice(product.getPrice());

            cartDAO.addItemToCart(cart.getCartId(), newItem);

            Cart updatedCart = cartDAO.getCartByUserId(user.getUserId());
            session.setAttribute("cart", updatedCart);
            response.sendRedirect("cart");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

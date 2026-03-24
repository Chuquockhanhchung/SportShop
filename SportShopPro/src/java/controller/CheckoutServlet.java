package controller;

import dao.CartDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Cart;
import model.User;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Kiểm tra xem có phải "Mua ngay" không
        Cart buyNowCart = (Cart) session.getAttribute("buyNowCart");
        Cart cart = null;
        
        if (buyNowCart != null) {
            // Sử dụng cart "Mua ngay"
            cart = buyNowCart;
        } else {
            // Sử dụng cart bình thường từ database
            CartDAO cartDAO = new CartDAO();
            cart = cartDAO.getCartByUserId(user.getUserId());
        }

        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        request.setAttribute("user", user);
        request.setAttribute("formSubmitted", false);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        CartDAO cartDAO = new CartDAO();

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Kiểm tra xem có phải "Mua ngay" không
        Cart buyNowCart = (Cart) session.getAttribute("buyNowCart");
        Cart cart = null;
        
        if (buyNowCart != null) {
            // Sử dụng cart "Mua ngay"
            cart = buyNowCart;
        } else {
            // Sử dụng cart bình thường từ database
            cart = cartDAO.getCartByUserId(user.getUserId());
        }
        
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        if (action == null || !action.equals("place_order")) {
            request.setAttribute("user", user);
            request.setAttribute("formSubmitted", false);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");

        boolean missing = (fullname == null || fullname.trim().isEmpty())
                       || (phone == null || phone.trim().isEmpty())
                       || (address == null || address.trim().isEmpty());

        if (missing) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.setAttribute("lastFullname", fullname != null ? fullname : "");
            request.setAttribute("lastPhone", phone != null ? phone : "");
            request.setAttribute("lastAddress", address != null ? address : "");
            request.setAttribute("lastNote", note != null ? note : "");
            request.setAttribute("user", user);
            request.setAttribute("formSubmitted", true);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        session.setAttribute("confirmFullname", fullname);
        session.setAttribute("confirmPhone", phone);
        session.setAttribute("confirmAddress", address);
        session.setAttribute("confirmNote", note);
        session.setAttribute("confirmCart", cart);

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
    }
}

package controller;

import dao.ProductReviewDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.ProductReview;
import model.User;

@WebServlet("/review")
public class ProductReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User acc = (User) request.getSession().getAttribute("account");
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        ProductReviewDAO dao = new ProductReviewDAO();
        if (!dao.hasPurchased(acc.getUserId(), productId)) {
            response.sendRedirect("product?pid=" + productId + "&err=notPurchased");
            return;
        }

        ProductReview r = new ProductReview();
        r.setProductId(productId);
        r.setUserId(acc.getUserId());
        r.setRating(rating);
        r.setComment(comment);
        dao.addReview(r);

        response.sendRedirect("product?pid=" + productId + "&msg=reviewed");
    }
}
package controller;

import dao.ProductReviewDAO;
import dao.ProductsDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Products;
import model.ProductReview;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/productdetail"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String id = request.getParameter("id");

            if (id == null || id.isEmpty()) {
                response.sendRedirect("allproducts.jsp");
                return;
            }

            int productId = Integer.parseInt(id);

            ProductsDAO dao = new ProductsDAO();
            Products product = dao.getById(productId);

            ProductReviewDAO reviewDao = new ProductReviewDAO();
            List<ProductReview> list = reviewDao.getApprovedByProduct(productId);

            // ===== PAGINATION =====
            int pageSize = 5;
            int currentPage = 1;
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
                if (currentPage < 1) currentPage = 1;
            } catch (Exception e) {
                currentPage = 1;
            }

            int totalReviews = list.size();
            int totalPages = (int) Math.ceil((double) totalReviews / pageSize);

            int start = (currentPage - 1) * pageSize;
            int end = Math.min(start + pageSize, totalReviews);

            List<ProductReview> pageList = new ArrayList<>();
            if (start < end) {
                pageList = list.subList(start, end);
            }

            String baseUrl = "productdetail?id=" + productId;

            request.setAttribute("product", product);
            request.setAttribute("reviews", pageList);
            request.setAttribute("totalReviews", totalReviews);

            // pagination attrs
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("baseUrl", baseUrl);

            request.getRequestDispatcher("productdetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
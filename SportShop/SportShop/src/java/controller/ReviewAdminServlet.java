package controller;

import dao.ProductReviewDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.ProductReview;

@WebServlet("/reviews")
public class ReviewAdminServlet extends HttpServlet {
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    ProductReviewDAO dao = new ProductReviewDAO();
    List<ProductReview> list = dao.getAllForAdmin(); // full list

    String search = request.getParameter("search");
    String status = request.getParameter("status");

    // ===== FILTER =====
    List<ProductReview> filtered = new ArrayList<>();
    for (ProductReview r : list) {
        boolean match = true;

        // search
        if (search != null && !search.trim().isEmpty()) {
            String kw = search.trim().toLowerCase();
            match = (r.getUserFullName() != null && r.getUserFullName().toLowerCase().contains(kw))
                 || (r.getProductName() != null && r.getProductName().toLowerCase().contains(kw))
                 || (r.getComment() != null && r.getComment().toLowerCase().contains(kw));
        }

        // status
        if (match && status != null && !status.isEmpty()) {
            if ("approved".equals(status)) match = r.isApproved();
            if ("pending".equals(status)) match = !r.isApproved();
        }

        if (match) filtered.add(r);
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

    int totalReviews = filtered.size();
    int totalPages = (int) Math.ceil((double) totalReviews / pageSize);

    int start = (currentPage - 1) * pageSize;
    int end = Math.min(start + pageSize, totalReviews);

    List<ProductReview> pageList = new ArrayList<>();
    if (start < end) {
        pageList = filtered.subList(start, end);
    }

    String baseUrl = "reviews?search=" + (search != null ? search : "")
            + "&status=" + (status != null ? status : "");

    request.setAttribute("reviews", pageList);
    request.setAttribute("totalReviews", totalReviews);

    // pagination attrs for pagination2.jsp
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("baseUrl", baseUrl);

    request.getRequestDispatcher("review_management.jsp").forward(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductReviewDAO dao = new ProductReviewDAO();
        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

        if ("approve".equals(action)) dao.approve(id, true);
        if ("delete".equals(action)) dao.delete(id);

        response.sendRedirect("reviews");
    }
}
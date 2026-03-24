package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.*;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.*;

@WebServlet(name = "ProductServlet", urlPatterns = {"/view"})
public class ViewProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductsDAO dao = new ProductsDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            List<Products> list = dao.getAll();
            List<category> categories = categoryDAO.getAllCategories();

            // ===== PAGINATION =====
            int pageSize = 5;
            int currentPage = 1;
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
                if (currentPage < 1) currentPage = 1;
            } catch (Exception e) {
                currentPage = 1;
            }

            int totalProducts = list.size();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            int start = (currentPage - 1) * pageSize;
            int end = Math.min(start + pageSize, totalProducts);

            List<Products> pageList = new ArrayList<>();
            if (start < end) {
                pageList = list.subList(start, end);
            }

            request.setAttribute("products", pageList);
            request.setAttribute("categories", categories);
            request.setAttribute("selectedCategory", "");

            // pagination attrs
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("baseUrl", "view?");

            request.getRequestDispatcher("allproducts.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ViewProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
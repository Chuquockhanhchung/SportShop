package controller;

import dao.ProductsDAO;
import java.io.IOException;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Products;

@WebServlet(name = "SortServlet", urlPatterns = {"/sorts"})
public class SortServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String sortType = request.getParameter("sort");
            String keyword = request.getParameter("search");

            ProductsDAO dao = new ProductsDAO();
            List<Products> list;

            if (keyword != null && !keyword.trim().isEmpty()) {
                list = dao.searchByName(keyword.trim());
            } else {

                list = dao.getAll();
            }

            if (sortType != null) {
                switch (sortType) {
                    case "price-asc":
                        list.sort(Comparator.comparingDouble(Products::getPrice));
                        break;
                    case "price-desc":
                        list.sort(Comparator.comparingDouble(Products::getPrice).reversed());
                        break;
                    case "name-asc":
                        list.sort(Comparator.comparing(Products::getProductName, String.CASE_INSENSITIVE_ORDER));
                        break;
                    case "name-desc":
                        list.sort(Comparator.comparing(Products::getProductName, String.CASE_INSENSITIVE_ORDER).reversed());
                        break;
                }
            }

            request.setAttribute("products", list);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("allproducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

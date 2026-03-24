package controller;

import dao.ProductsDAO;
import dao.CategoryDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.Products;
import model.category;

@WebServlet("/product")
public class ProductsServlet extends HttpServlet {

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        String selectedCategory = request.getParameter("category");
        if (selectedCategory == null) selectedCategory = "";

        ProductsDAO dao = new ProductsDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<Products> list = dao.getAll();
        List<category> categories = categoryDAO.getAllCategories();

        try {
            if (!selectedCategory.isEmpty()) {
                int categoryId = Integer.parseInt(selectedCategory);
                list = list.stream()
                           .filter(p -> p.getCategoryId() == categoryId)
                           .collect(Collectors.toList());
            }

            if (search != null && !search.isEmpty()) {
                String keyword = search.toLowerCase();
                list = list.stream()
                           .filter(p -> p.getProductName().toLowerCase().contains(keyword))
                           .collect(Collectors.toList());
            }

            if (sort != null && !sort.isEmpty()) {
                switch (sort) {
                    case "name-asc":
                        list.sort((a, b) -> a.getProductName().compareToIgnoreCase(b.getProductName()));
                        break;
                    case "name-desc":
                        list.sort((a, b) -> b.getProductName().compareToIgnoreCase(a.getProductName()));
                        break;
                    case "price-asc":
                        list.sort((a, b) -> Double.compare(a.getPrice(), b.getPrice()));
                        break;
                    case "price-desc":
                        list.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
                        break;
                    case "trending":
                        list.sort((a, b) -> {
                            if (a.isTrending() == b.isTrending()) {
                                return Integer.compare(b.getProductId(), a.getProductId());
                            }
                            return a.isTrending() ? -1 : 1;
                        });
                        break;
                    case "newest":
                        list.sort((a, b) -> Integer.compare(b.getProductId(), a.getProductId()));
                        break;
                }
            }

            if (action != null && !action.isEmpty()) {
                if (action.equals("add")) {
                    request.setAttribute("openModal", "productModal");
                } else if (action.equals("view")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("productToView", dao.getById(id));
                    request.setAttribute("openModal", "viewProductModal");
                } else if (action.equals("edit")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("productToEdit", dao.getById(id));
                    request.setAttribute("openModal", "productModal");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            list = dao.getAll();
        }

        // ====== PAGINATION ======
        int pageSize =5;
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

        // baseUrl giữ filter + sort
        String baseUrl = "product?search=" + (search != null ? search : "")
                + "&category=" + selectedCategory
                + "&sort=" + (sort != null ? sort : "default");

        request.setAttribute("products", pageList);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("search", search);
        request.setAttribute("sort", sort);

        // pagination attrs
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("baseUrl", baseUrl);

        request.getRequestDispatcher("allproducts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        ProductsDAO dao = new ProductsDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<Products> list = dao.getAll();
        List<category> categories = categoryDAO.getAllCategories();
        String selectedCategory = request.getParameter("category");
        if (selectedCategory == null) selectedCategory = "";

        try {
            if (action != null && !action.isEmpty()) {
                if (action.equals("add")) {
                    String pname = request.getParameter("productName");
                    String color = request.getParameter("colors");
                    double price = parseDouble(request.getParameter("price"));
                    int cid = parseInt(request.getParameter("categoryId"));
                    int quantity = parseInt(request.getParameter("quantity"));
                    String desc = request.getParameter("description");

                    dao.create(pname, price, cid, quantity, desc, color);

                } else if (action.equals("update")) {
                    int productId = parseInt(request.getParameter("id"));
                    String updateName = request.getParameter("productName");
                    double updatePrice = parseDouble(request.getParameter("price"));
                    int updateCid = parseInt(request.getParameter("categoryId"));
                    int updateQuantity = parseInt(request.getParameter("quantity"));
                    String updateDesc = request.getParameter("description");
                    String color = request.getParameter("colors");

                    dao.update(productId, updateName, updatePrice, updateCid, updateQuantity, updateDesc, color);

                } else if (action.equals("delete")) {
                    int deleteId = parseInt(request.getParameter("id"));
                    dao.delete(deleteId);
                }

                list = dao.getAll();
            }
        } catch (Exception e) {
            e.printStackTrace();
            list = dao.getAll();
        }

        request.setAttribute("products", list);
        request.setAttribute("totalProducts", list.size());
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", selectedCategory);

        request.getRequestDispatcher("allproducts.jsp").forward(request, response);
    }

    private int parseInt(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return 0; }
    }

    private double parseDouble(String s) {
        try { return Double.parseDouble(s); } catch (Exception e) { return 0; }
    }
}

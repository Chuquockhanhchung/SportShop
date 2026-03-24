package controller;

import dao.UserAdminDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.ArrayList;
import model.UserAdmin;
import model.ProductsAdmin;
import model.OrderAdmin;

@WebServlet("/customer")
public class UserAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserAdminDAO dao = new UserAdminDAO();
        String search = request.getParameter("search");
        String typeFilter = request.getParameter("typeFilter");
        String sort = request.getParameter("sort");
        String action = request.getParameter("action");
        List<UserAdmin> list = dao.getAll();
        try {
            if (search != null && !search.isEmpty()) {
                if (search.contains("@")) {
                    list = dao.searchByEmail(search);
                } else {
                    list = dao.searchByName(search);
                }
            }
            if (sort != null && !sort.isEmpty()) {
                if (sort.equals("name-asc")) {
                    list = dao.sortByFullnameAZ();
                } else if (sort.equals("name-desc")) {
                    list = dao.sortByFullnameZA();
                }
            }
            if (action != null && !action.isEmpty()) {
                if (action.equals("add")) {
                    request.setAttribute("openModal", "customerModal");
                } else if (action.equals("edit")) {
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        try {
                            int id = Integer.parseInt(idStr);
                            for (UserAdmin u : list) {
                                if (u.getUserId() == id) {
                                    request.setAttribute("customerToEdit", u);
                                    break;
                                }
                            }
                        } catch (NumberFormatException ignore) {
                        }
                    }
                    request.setAttribute("openModal", "customerModal");
                } else if (action.equals("view")) {
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        try {
                            int id = Integer.parseInt(idStr);
                            UserAdmin user = dao.getById(id);
                            if (user != null) {
                                request.setAttribute("customerToView", user);
                                request.setAttribute("openModal", "customerDetailModal");
                            }
                        } catch (NumberFormatException ignore) {
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            list = dao.getAll();
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

        int totalCustomers = list.size();
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, totalCustomers);

        List<UserAdmin> pageList = new ArrayList<>();
        if (start < end) {
            pageList = list.subList(start, end);
        }

        // baseUrl giữ search/sort
        String baseUrl = "customer?search=" + (search != null ? search : "")
                + "&sort=" + (sort != null ? sort : "");

        request.setAttribute("customerList", pageList);
        request.setAttribute("totalCustomers", totalCustomers);

        // pagination attrs
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("baseUrl", baseUrl);

        RequestDispatcher rd = request.getRequestDispatcher("admin_customers.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserAdminDAO dao = new UserAdminDAO();
        List<UserAdmin> list = dao.getAll();
        try {
            if (action != null && !action.isEmpty()) {
                if (action.equals("add")) {
                    String userName = request.getParameter("username");
                    String userFullName = request.getParameter("fullname");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String phoneNumber = request.getParameter("phone");
                    String gender = request.getParameter("gender");
                    Date dateOfBirth = Date.valueOf(request.getParameter("dateOfbirth"));
                    String role = request.getParameter("role");
                    String address = request.getParameter("address");
                    String userAvatar = request.getParameter("avatar");
                    dao.create(userName, userFullName, email, password, phoneNumber, gender, dateOfBirth, role, address, userAvatar);
                } else if (action.equals("update")) {
                    int userId = Integer.parseInt(request.getParameter("id"));
                    String userName = request.getParameter("username");
                    String userFullName = request.getParameter("fullname");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String phoneNumber = request.getParameter("phone");
                    String gender = request.getParameter("gender");
                    Date dateOfBirth = Date.valueOf(request.getParameter("dateOfbirth"));
                    String role = request.getParameter("role");
                    String address = request.getParameter("address");
                    String userAvatar = request.getParameter("avatar");
                    dao.update(userId, userName, userFullName, email, password, phoneNumber, gender, dateOfBirth, role, address, userAvatar);
                } else if (action.equals("delete")) {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    dao.delete(deleteId);
                }
                list = dao.getAll();
            }
        } catch (Exception e) {
            e.printStackTrace();
            list = dao.getAll();
        }
        request.setAttribute("customerList", list);
        request.setAttribute("totalCustomers", list.size());
        RequestDispatcher rd = request.getRequestDispatcher("admin_customers.jsp");
        rd.forward(request, response);
    }
}
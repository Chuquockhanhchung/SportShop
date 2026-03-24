package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(UpdateProfileServlet.class.getName());
    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Tạo một đối tượng chuyển tiếp đến một tài nguyên nội bộ (ví dụ: JSP)
        RequestDispatcher dispatcher = request.getRequestDispatcher("editProfile.jsp");

        // Chuyển yêu cầu hiện tại đến tài nguyên khác
        dispatcher.forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User account = (User) session.getAttribute("account");

        try {
            String username = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");

            Date dob = null;
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                try {
                    dob = Date.valueOf(dobStr);
                } catch (IllegalArgumentException ex) {
                    LOG.log(Level.WARNING, "Invalid date format for dob: " + dobStr, ex);
                    request.setAttribute("error", "Ngày sinh không hợp lệ.");
                    request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
                    return;
                }
            }

            int userId = account.getUserId();
            String role = account.getRole();
            String password = null;

            String existingAvatar = account.getUserAvatar();

            UserDAO dao = new UserDAO();
            dao.update(
                userId,
                username != null ? username.trim() : account.getUserName(),
                fullname != null ? fullname.trim() : account.getUserFullName(),
                email != null ? email.trim() : account.getEmail(),
                password,
                phone != null ? phone.trim() : account.getPhoneNumber(),
                gender != null ? gender.trim() : account.getGender(),
                dob,
                role,
                address != null ? address.trim() : account.getAddress(),
                existingAvatar 
            );

            User updatedUser = dao.getById(userId);
            if (updatedUser != null) {
                session.setAttribute("account", updatedUser);
            } else {
                account.setUserName(username != null ? username : account.getUserName());
                account.setUserFullName(fullname != null ? fullname : account.getUserFullName());
                account.setEmail(email != null ? email : account.getEmail());
                account.setPhoneNumber(phone != null ? phone : account.getPhoneNumber());
                account.setGender(gender != null ? gender : account.getGender());
                account.setDateOfBirth(dob != null ? dob : account.getDateOfBirth());
                account.setAddress(address != null ? address : account.getAddress());
                session.setAttribute("account", account);
            }

            response.sendRedirect(request.getContextPath() + "/profile.jsp?update=success");
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Error updating profile", e);
            request.setAttribute("error", "Update failed: " + e.getMessage());
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
        }
    }
}

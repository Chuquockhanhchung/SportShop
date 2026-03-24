/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
;

/**
 * ChangePasswordServlet
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changepassword"})
public class ChangePasswordServlet extends HttpServlet {


    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        req.getRequestDispatcher("/changepassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String current = request.getParameter("currentPassword");
        String newpwd = request.getParameter("newPassword");

        if (!sessionUser.getPassword().equals(current)) {

            request.setAttribute("changeError", "Mật khẩu hiện tại không đúng.");
        } else {
            sessionUser.setPassword(newpwd);

            UserDAO userDAO = new UserDAO();
            boolean updated = userDAO.updatePassword(sessionUser);

            if (!updated) {
                request.setAttribute("changeError", "Đổi mật khẩu thất bại. Vui lòng thử lại.");
            } else {
                request.setAttribute("changeSuccess", "Đổi mật khẩu thành công.");
                session.setAttribute("account", sessionUser);
            }
        }

        request.getRequestDispatcher("/changepassword.jsp").forward(request, response);
    }

}

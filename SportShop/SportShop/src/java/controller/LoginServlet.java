/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import dao.UserDAO;

/**
 *
 * @author LE DUC ANH
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User account = userDAO.findUserByUserName(username);

        if (account != null && password.equals(account.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);

            if ("Admin".equals(account.getRole())) {
               response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            request.setAttribute("error", "Incorrect username or password");
            request.setAttribute("username", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }
}

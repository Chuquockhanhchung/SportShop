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
import model.User;
;

/**
 *
 * @author LE DUC ANH
 */
@WebServlet(name="ForgotServlet", urlPatterns={"/forgot"})
public class ForgotServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/forgot.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.findUserByEmail(email);

        if (user == null) {

            request.setAttribute("error", "Email does not exist");

            request.setAttribute("email", email); 
            
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
        } else {

            String successMessage = "Successfully verified";
            request.setAttribute("success", successMessage);
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
        }

    }
}

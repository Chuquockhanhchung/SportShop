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

import java.sql.Date;

/**
 *
 * @author LE DUC ANH
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/signup"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String userfullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phonenumber = request.getParameter("phone");
        String dateofbirthString = request.getParameter("dob");
        java.sql.Date dateofbirth = null; 

        if (dateofbirthString != null && !dateofbirthString.isEmpty()) {
            dateofbirth = java.sql.Date.valueOf(dateofbirthString);
        }
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        User newUser = new User(username, userfullname, email, password, phonenumber, gender, dateofbirth, address);
        UserDAO userDAO = new UserDAO();
        String message = null;

        if (!newUser.getPassword().equals(confirmPassword)) {
            message = "Password and confirm password do not match";
        } 
        else if (userDAO.findUserByUserName(newUser.getUserName()) != null) {
            message = "Registration failed. Please try again";
        } 
        else if (userDAO.findUserByEmail(newUser.getEmail()) != null) {
            message = "This email has already been registered";
        }

        if (message == null) {
            boolean success = userDAO.insertUserAccount(newUser);
            if (!success) {
                request.setAttribute("error", "Registration failed");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            } else {
                request.setAttribute("success", "Registration successful");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", message);
            request.setAttribute("formData_fullname", userfullname);
            request.setAttribute("formData_username", username);
            request.setAttribute("formData_email", email);
            request.setAttribute("formData_dob", dateofbirthString);
            request.setAttribute("formData_gender", gender);
            request.setAttribute("formData_address", address);
            request.setAttribute("formData_phone", phonenumber);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }

    }
}

package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import dao.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;

/**
 *
 * @author admin
 */
@WebServlet(urlPatterns={"/home"})
public class HomeServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    ProductsDAO dao = new ProductsDAO();
    List<Products> bestSelling = dao.getBestSelling(10);
    List<Products> latest = dao.getLatestById(10);
    request.setAttribute("newProducts", latest);
    request.setAttribute("bestSellingProducts", bestSelling);
    request.getRequestDispatcher("home.jsp").forward(request, response);
}

}

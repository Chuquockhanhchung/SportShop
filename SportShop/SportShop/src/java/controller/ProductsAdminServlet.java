package controller;

import dao.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import model.ProductsAdmin;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.nio.file.Paths;
import java.util.Comparator;
import model.UserAdmin;
import model.OrderAdmin;

@WebServlet("/products")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  
    maxFileSize = 1024 * 1024 * 10,       
    maxRequestSize = 1024 * 1024 * 50     
)
public class ProductsAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        ProductsAdminDAO dao = new ProductsAdminDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<ProductsAdmin> list = dao.getAll();

        try {
            if (search != null && !search.isEmpty()) {
                list = dao.searchByCategory(search);
                if (list.isEmpty()) {
                    list = dao.searchByName(search);
                }
            }

            if (sort != null && !sort.isEmpty()) {
                switch (sort) {
                    case "name-asc":
                        list.sort(Comparator.comparing(ProductsAdmin::getProductName));
                        break;
                    case "name-desc":
                        list.sort(Comparator.comparing(ProductsAdmin::getProductName).reversed());
                        break;
                    case "price-asc":
                        list.sort(Comparator.comparingDouble(ProductsAdmin::getPrice));
                        break;
                    case "price-desc":
                        list.sort(Comparator.comparingDouble(ProductsAdmin::getPrice).reversed());
                        break;
                    default:
                        list.sort(Comparator.comparingInt(ProductsAdmin::getProductId));
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

        List<ProductsAdmin> pageList = new ArrayList<>();
        if (start < end) {
            pageList = list.subList(start, end);
        }

        String baseUrl = "products?search=" + (search != null ? search : "")
                + "&sort=" + (sort != null ? sort : "");

        // Luôn gửi danh sách categories cho form
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("productList", pageList);
        request.setAttribute("totalProducts", totalProducts);

        // pagination attrs
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("baseUrl", baseUrl);

        request.getRequestDispatcher("admin_products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        System.out.println("=== ProductsAdminServlet doPost ===");
        System.out.println("Action: " + action);

        ProductsAdminDAO dao = new ProductsAdminDAO();
        List<ProductsAdmin> list = dao.getAll();

        try {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "img";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
                System.out.println("Created upload directory: " + uploadPath);
            }

            System.out.println("Upload path: " + uploadPath);

            if (action != null && !action.isEmpty()) {
                if (action.equals("add")) {
                    System.out.println("=== Adding new product ===");

                    String pname = request.getParameter("productName");
                    String color = request.getParameter("colors");
                    String gender = request.getParameter("gender");
                    String desc = request.getParameter("description");

                    System.out.println("Product Name: " + pname);
                    System.out.println("Color: " + color);
                    System.out.println("Gender: " + gender);
                    System.out.println("Description: " + desc);

                    double price = 0;
                    int cid = 0;
                    int quantity = 0;

                    try {
                        String priceStr = request.getParameter("price");
                        String cidStr = request.getParameter("categoryId");
                        String qtyStr = request.getParameter("quantity");

                        System.out.println("Price (string): " + priceStr);
                        System.out.println("Category ID (string): " + cidStr);
                        System.out.println("Quantity (string): " + qtyStr);

                        price = Double.parseDouble(priceStr);
                        cid = Integer.parseInt(cidStr);
                        quantity = Integer.parseInt(qtyStr);

                        System.out.println("Parsed - Price: " + price + ", Category: " + cid + ", Quantity: " + quantity);
                    } catch (NumberFormatException nfe) {
                        System.err.println("Error parsing numbers: " + nfe.getMessage());
                        nfe.printStackTrace();
                    }

                    String imageUrl = null;
                    try {
                        Part filePart = request.getPart("image");
                        System.out.println("File part: " + filePart);

                        if (filePart != null && filePart.getSize() > 0) {
                            String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                            String filePath = uploadPath + File.separator + fileName;
                            filePart.write(filePath);
                            imageUrl = "./img/" + fileName;
                            System.out.println("Image saved: " + filePath);
                            System.out.println("Image URL: " + imageUrl);
                        } else {
                            System.out.println("No image uploaded");
                        }
                    } catch (Exception e) {
                        System.err.println("Error handling image upload: " + e.getMessage());
                        e.printStackTrace();
                    }

                    System.out.println("Calling dao.create with:");
                    System.out.println("  name=" + pname + ", price=" + price + ", categoryId=" + cid);
                    System.out.println("  quantity=" + quantity + ", desc=" + desc + ", color=" + color);
                    System.out.println("  gender=" + gender + ", imageUrl=" + imageUrl);

                    dao.create(pname, price, cid, quantity, desc, color, gender, imageUrl);
                    System.out.println("Product created successfully!");

                } else if (action.equals("update")) {
                    System.out.println("=== Updating product ===");

                    int productId = Integer.parseInt(request.getParameter("id"));
                    ProductsAdmin oldProduct = dao.getById(productId);

                    String updateName = request.getParameter("productName");
                    String color = request.getParameter("colors");
                    String gender = request.getParameter("gender");
                    if (gender == null || gender.isEmpty()) {
                        gender = oldProduct.getGender();
                    }
                    double updatePrice = Double.parseDouble(request.getParameter("price"));
                    int updateCid = Integer.parseInt(request.getParameter("categoryId"));
                    int updateQuantity = Integer.parseInt(request.getParameter("quantity"));
                    String updateDesc = request.getParameter("description");

                    String imageUrl = oldProduct.getImageUrl();
                    Part filePart = request.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        if (imageUrl != null && !imageUrl.isEmpty()) {
                            String oldImagePath = getServletContext().getRealPath("") + File.separator + imageUrl.replace("./", "");
                            File oldFile = new File(oldImagePath);
                            if (oldFile.exists()) {
                                oldFile.delete();
                                System.out.println("Deleted old image: " + oldImagePath);
                            }
                        }

                        String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String filePath = uploadPath + File.separator + fileName;
                        filePart.write(filePath);
                        imageUrl = "./img/" + fileName;
                        System.out.println("New image saved: " + filePath);
                        System.out.println("New image URL: " + imageUrl);
                    }

                    dao.update(productId, updateName, updatePrice, updateCid, updateQuantity, updateDesc, color, gender, imageUrl);
                    System.out.println("Product updated successfully!");

                } else if (action.equals("delete")) {
                    System.out.println("=== Deleting product ===");

                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    ProductsAdmin productToDelete = dao.getById(deleteId);
                    if (productToDelete != null && productToDelete.getImageUrl() != null) {
                        String imagePath = getServletContext().getRealPath("") + File.separator + productToDelete.getImageUrl().replace("./", "");
                        File fileToDelete = new File(imagePath);
                        if (fileToDelete.exists()) {
                            fileToDelete.delete();
                            System.out.println("Deleted image: " + imagePath);
                        }
                    }
                    dao.delete(deleteId);
                    System.out.println("Product deleted successfully!");
                }
                list = dao.getAll();
            }
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            list = dao.getAll();
        }

        CategoryDAO categoryDAO = new CategoryDAO();
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("productList", list);
        request.setAttribute("totalProducts", list.size());
        request.getRequestDispatcher("admin_products.jsp").forward(request, response);
    }
}
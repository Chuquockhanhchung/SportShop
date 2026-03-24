<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return; 
    }
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Change Password</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
    />
    <link rel="stylesheet" href="./css/output.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Bebas+Neue&display=swap" rel="stylesheet">
    <style>
      .font-inter { font-family: 'Inter', sans-serif; }
      .font-bebas { font-family: 'Bebas Neue', cursive; }
    </style>
  </head>
  <body class="bg-black font-inter pt-24">
    <%@ include file="header.jsp" %>

    <div class="max-w-7xl mx-auto px-8 pt-8 pb-6">
      <nav class="text-sm text-gray-400 font-inter">
        <a href="home" class="text-gray-400 hover:text-white transition-colors duration-300">Home</a>
        <span class="mx-2">/</span>
        <a href="profile" class="text-gray-400 hover:text-white transition-colors duration-300">Profile</a>
        <span class="mx-2">/</span>
        <span class="text-white">Change Password</span>
      </nav>
    </div>

    <main class="max-w-7xl mx-auto px-8 py-8 font-inter">
      <div class="max-w-2xl mx-auto">
        <div
          class="bg-gradient-to-br from-gray-900 to-black p-8 md:p-12 rounded-3xl border border-gray-800"
        >
<% 
 String changeError = (String) request.getAttribute("changeError");
 String changeSuccess = (String) request.getAttribute("changeSuccess");
 boolean hasError = (changeError != null && !changeError.isEmpty());
 boolean hasSuccess = (changeSuccess != null && !changeSuccess.isEmpty());
 %>

                    <div 
              id="success-box-container"
              class="mb-4 p-3 rounded bg-green-800 text-green-200" 
              style="display: <%= hasSuccess ? "block" : "none" %>;"
          >
              <i class="fas fa-check-circle mr-2"></i>
              <span id="success-text"><%= hasSuccess ? changeSuccess : "" %></span>
          </div>
          
                    <div 
              id="error-box-container" 
              class="mb-4 p-3 rounded bg-red-800 text-red-200" 
              style="display: <%= hasError ? "block" : "none" %>;"
          >
              <i class="fas fa-exclamation-circle mr-2"></i>
              <span id="error-text"><%= hasError ? changeError : "" %></span>
          </div>
          <form
            id="changePassForm"
            action="changepassword"
            method="post"
            class="space-y-6 font-inter"
          >
            <h1
              class="font-bold text-white uppercase font-bebas text-center text-4xl"
            >
              Change Password
            </h1>
            
            <div>
              <label class="block text-gray-300 text-base font-semibold mb-2"
                >Current Password</label
              >
              <div class="relative">
                <i
                  class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"
                ></i>
                <input
                  type="password"
                  name="currentPassword"
                  required
                  class="w-full bg-black border border-gray-800 rounded-lg pl-12 pr-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/50 text-white placeholder-gray-500 font-inter transition-all duration-300"
                  placeholder="Enter your current password"
                />
              </div>
            </div>

            <div>
              <label class="block text-gray-300 text-base font-semibold mb-2"
                >New Password</label
              >
              <div class="relative">
                <i
                  class="fas fa-key absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"
                ></i>
                <input
                  type="password"
                  name="newPassword"
                  required
                  class="w-full bg-black border border-gray-800 rounded-lg pl-12 pr-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/50 text-white placeholder-gray-500 font-inter transition-all duration-300"
                  placeholder="Enter your new password"
                />
              </div>
            </div>

            <div>
              <label class="block text-gray-300 text-base font-semibold mb-2"
                >Confirm New Password</label
              >
              <div class="relative">
                <i
                  class="fas fa-check-double absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"
                ></i>
                <input
                  type="password"
                  name="confirmPassword"
                  required
                  class="w-full bg-black border border-gray-800 rounded-lg pl-12 pr-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/50 text-white placeholder-gray-500 font-inter transition-all duration-300"
                  placeholder="Confirm your new password"
                />
              </div>
            </div>

            <div class="flex gap-4 pt-4">
              <button
                type="submit"
                class="flex-1 py-4 bg-white text-black font-bebas text-2xl uppercase tracking-wider rounded-full transition-all duration-300 hover:bg-gray-200 hover:scale-105 hover:shadow-xl"
              >
                Update Password
              </button>
              <a
                href="profile.jsp"
                class="flex-1 py-4 bg-gray-800 text-white font-bebas text-2xl uppercase tracking-wider rounded-full transition-all duration-300 hover:bg-gray-700 hover:scale-105 text-center"
              >
                Cancel
              </a>
            </div>
          </form>
        </div>
      </div>
    </main>
            <script>
  document.getElementById("changePassForm").addEventListener("submit", function(e) {
    const currentPass = this.elements["currentPassword"].value;
    const newPass = this.elements["newPassword"].value;
    const confirmPass = this.elements["confirmPassword"].value;

    // 2. Lấy các ô thông báo
    const errorContainer = document.getElementById("error-box-container");
    const errorText = document.getElementById("error-text");
    const successContainer = document.getElementById("success-box-container");

    // 3. Hàm trợ giúp để hiển thị lỗi
    function showError(message) {
        e.preventDefault(); // Ngăn form gửi đi
        errorText.textContent = message;
        errorContainer.style.display = "block";
        successContainer.style.display = "none"; // Ẩn thông báo thành công (nếu có)
    }

    // 4. Ẩn các thông báo cũ trước khi kiểm tra
    errorContainer.style.display = "none";
    successContainer.style.display = "none";

    // 5. Bắt đầu kiểm tra (theo yêu cầu của bạn)
    
    // CHECK 1: KIỂM TRA TRỐNG
    if (currentPass.trim() === "" || newPass.trim() === "" || confirmPass.trim() === "") {
        showError("Vui lòng điền đầy đủ các trường.");
        return;
    }
    
    // CHECK 2: KIỂM TRA ĐỘ DÀI MẬT KHẨU MỚI
    if (newPass.length < 8) {
        showError("Mật khẩu mới phải có ít nhất 8 ký tự.");
        return;
    }

    // CHECK 3: KIỂM TRA KHỚP MẬT KHẨU
    if (newPass !== confirmPass) {
        showError("Mật khẩu mới và xác nhận không khớp.");
        return;
    }

    // CHECK 4 (Mật khẩu cũ): Bỏ qua. Servlet sẽ tự kiểm tra.
    
    // Nếu tất cả kiểm tra JS đều qua, form sẽ được phép gửi đi
    // (Servlet sẽ nhận và kiểm tra mật khẩu cũ)
  });
</script>
  </body>
</html>
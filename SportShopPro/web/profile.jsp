<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // --- Logic từ File 1 ---
    User user = (User) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    // Định dạng ngày (nếu cần)
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    // Helper để xử lý giá trị null hoặc rỗng
   
    String gender = (user.getGender() != null && !user.getGender().isEmpty()) ? user.getGender() : "N/A";
    String address = (user.getAddress() != null && !user.getAddress().isEmpty()) ? user.getAddress() : "N/A";
    String dob = (user.getDateOfBirth() != null) ? sdf.format(user.getDateOfBirth()) : "N/A";
    String phone = (user.getPhoneNumber() != null && !user.getPhoneNumber().isEmpty()) ? user.getPhoneNumber() : "N/A";

%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Profile - Sport Zone</title>
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
        <link rel="stylesheet" href="./css/output.css" />
    </head>
    <body class="bg-black text-white font-inter">
        <%@ include file="header.jsp" %>

        <main class="min-h-screen pt-24 pb-16 px-4">
            <div class="max-w-7xl mx-auto">
                <!-- Page Header -->
                <div class="mb-10">
                    <h1 class="font-bebas text-white text-5xl md:text-6xl font-bold uppercase tracking-wide mb-2">
                        My Profile
                    </h1>
                    <p class="text-gray-400 text-sm">Manage your account information and settings</p>
                </div>

                <div class="flex lg:flex-row gap-6 justify-center">
                    <!-- Left Column: Profile Card -->
                    <div class="lg:w-1/3">
                        <div class="bg-gradient-to-br from-gray-900 to-black rounded-2xl border border-white/10 p-8 lg:sticky lg:top-24">
                            <!-- Avatar -->
                            <div class="flex justify-center mb-6">
                                <div class="relative">
                                    <div class="w-32 h-32 rounded-full overflow-hidden border-4 border-white/10 bg-gradient-to-br from-gray-800 to-gray-900">
                                        <%
                                          String avatar = user.getUserAvatar();
                                          if (avatar == null || avatar.trim().isEmpty()) {
                                        %>
                                        <img src="https://i.pravatar.cc/150" alt="Avatar" class="w-full h-full object-cover">
                                        <%
                                          } else {
                                        %>
                                        <img src="<%= avatar %>" alt="Avatar" class="w-full h-full object-cover">
                                        <%
                                          }
                                        %>
                                    </div>
                                    <div class="absolute bottom-0 right-0 w-6 h-6 bg-green-500 rounded-full border-4 border-black"></div>
                                </div>
                            </div>

                            <!-- Name & Role -->
                            <div class="text-center mb-6">
                                <h2 class="text-2xl font-black text-white mb-1">
                                    <%= user.getUserFullName() != null && !user.getUserFullName().isEmpty() ? user.getUserFullName() : user.getUserName() %>
                                </h2>
                                <p class="text-gray-400 text-sm font-semibold uppercase tracking-wider">
                                    <%= user.getRole() != null ? user.getRole() : "Customer" %>
                                </p>
                            </div>

                            <!-- Stats -->
                            <div class="grid grid-cols-2 gap-3 mb-6">
                                <div class="bg-black/40 rounded-xl p-4 border border-white/5 text-center">
                                    <div class="text-xs text-gray-400 uppercase tracking-wider mb-1">Username</div>
                                    <div class="text-white font-bold truncate"><%= user.getUserName() %></div>
                                </div>
                                <div class="bg-black/40 rounded-xl p-4 border border-white/5 text-center">
                                    <div class="text-xs text-gray-400 uppercase tracking-wider mb-1">Email</div>
                                    <div class="text-white font-bold text-sm truncate"><%= user.getEmail() %></div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="space-y-3">
                                <a href="updateProfile" 
                                   class="w-full flex items-center justify-center gap-2 bg-white text-black font-bold py-3 rounded-xl hover:bg-gray-200 transition-all duration-300 hover:scale-105">
                                    <i class="fas fa-pen-to-square"></i>
                                    <span>Edit Profile</span>
                                </a>
                                
                                <a href="changepassword" 
                                   class="w-full flex items-center justify-center gap-2 bg-white/10 text-white font-bold py-3 rounded-xl border border-white/10 hover:bg-white/20 transition-all duration-300">
                                    <i class="fas fa-key"></i>
                                    <span>Change Password</span>
                                </a>

                                <form action="logout" method="post" class="w-full">
                                    <button type="submit" 
                                            class="w-full flex items-center cursor-pointer justify-center gap-2 bg-red-500/10 text-red-400 font-bold py-3 rounded-xl border border-red-500/20 hover:bg-red-500 hover:text-white transition-all duration-300">
                                        <i class="fas fa-right-from-bracket"></i>
                                        <span>Log Out</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Profile Details -->
                    <div class="lg:w-2/3">
                        <div class="bg-gradient-to-br from-gray-900 to-black rounded-2xl border border-white/10 p-8">
                            <!-- Section Header -->
                            <div class="flex items-center gap-3 mb-8">
                                <div class="w-12 h-12 bg-white/10 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-user text-white text-xl"></i>
                                </div>
                                <div>
                                    <h3 class="text-2xl font-black text-white uppercase tracking-wide font-bebas">Profile Details</h3>
                                    <p class="text-gray-400 text-sm">Complete information about your account</p>
                                </div>
                            </div>

                            <!-- Details Grid -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Email -->
                                <div class="bg-black/40 rounded-xl p-5 border border-white/10">
                                    <div class="flex items-center gap-2 mb-2">
                                        <i class="fas fa-envelope text-gray-400 text-sm"></i>
                                        <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Email Address</p>
                                    </div>
                                    <p class="text-white font-bold text-lg"><%= user.getEmail() %></p>
                                </div>

                                <!-- Phone -->
                                <div class="bg-black/40 rounded-xl p-5 border border-white/10">
                                    <div class="flex items-center gap-2 mb-2">
                                        <i class="fas fa-phone text-gray-400 text-sm"></i>
                                        <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Phone Number</p>
                                    </div>
                                    <p class="text-white font-bold text-lg"><%= phone %></p>
                                </div>

                                <!-- Date of Birth -->
                                <div class="bg-black/40 rounded-xl p-5 border border-white/10">
                                    <div class="flex items-center gap-2 mb-2">
                                        <i class="fas fa-calendar text-gray-400 text-sm"></i>
                                        <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Date of Birth</p>
                                    </div>
                                    <p class="text-white font-bold text-lg"><%= dob %></p>
                                </div>

                                <!-- Gender -->
                                <div class="bg-black/40 rounded-xl p-5 border border-white/10">
                                    <div class="flex items-center gap-2 mb-2">
                                        <i class="fas fa-venus-mars text-gray-400 text-sm"></i>
                                        <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Gender</p>
                                    </div>
                                    <p class="text-white font-bold text-lg"><%= gender %></p>
                                </div>

                                <!-- Address (Full Width) -->
                                <div class="md:col-span-2 bg-black/40 rounded-xl p-5 border border-white/10">
                                    <div class="flex items-center gap-2 mb-2">
                                        <i class="fas fa-map-marker-alt text-gray-400 text-sm"></i>
                                        <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Address</p>
                                    </div>
                                    <p class="text-white font-bold text-lg"><%= address %></p>
                                </div>

                                <!-- Member Since (Full Width) -->
                                <div class="md:col-span-2 bg-gradient-to-br from-blue-500/10 to-purple-500/10 rounded-xl p-5 border border-blue-500/20">
                                    <div class="flex items-center gap-2 mb-2">
                                        <i class="fas fa-clock text-blue-400 text-sm"></i>
                                        <p class="text-xs font-bold text-blue-400 uppercase tracking-wider">Member Since</p>
                                    </div>
                                    <p class="text-white font-bold text-lg mb-2">
                                        <%= (user.getDateOfBirth()!=null? sdf.format(user.getDateOfBirth()) : "—") %>
                                    </p>
                                    <p class="text-gray-400 text-sm">
                                        <i class="fas fa-info-circle mr-1"></i>
                                        You can update your profile information from Edit Profile
                                    </p>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="mt-8 pt-6 border-t border-white/10">
                                <div class="flex flex-wrap gap-3">
                                    <a href="home" 
                                       class="flex items-center gap-2 px-6 py-3 bg-white/10 text-white font-bold rounded-xl border border-white/10 hover:bg-white/20 transition-all duration-300">
                                        <i class="fas fa-home"></i>
                                        <span>Back to Home</span>
                                    </a>
                                    
                                    <a href="viewoders" 
                                       class="flex items-center gap-2 px-6 py-3 bg-white/10 text-white font-bold rounded-xl border border-white/10 hover:bg-white/20 transition-all duration-300">
                                        <i class="fas fa-shopping-bag"></i>
                                        <span>My Orders</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="footer.jsp" %>
    </body>
</html>
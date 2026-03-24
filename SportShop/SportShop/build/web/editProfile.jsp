<%-- 
    Document   : editProfile
    Created on : Nov 1, 2025
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    User user = (User) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String dobVal = (user.getDateOfBirth() != null) ? sdf.format(user.getDateOfBirth()) : "";
    String gender = user.getGender() != null ? user.getGender() : "";
    String address = user.getAddress() != null ? user.getAddress() : "";
    String phone = user.getPhoneNumber() != null ? user.getPhoneNumber() : "";
    String fullname = user.getUserFullName() != null ? user.getUserFullName() : "";
    String username = user.getUserName() != null ? user.getUserName() : "";
    String email = user.getEmail() != null ? user.getEmail() : "";
    String avatar = user.getUserAvatar() != null ? user.getUserAvatar() : "";

    String serverError = (String) request.getAttribute("error");
    String serverSuccess = (String) request.getAttribute("success");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Edit Profile - Sport Zone</title>
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
                        Edit Profile
                    </h1>
                    <p class="text-gray-400 text-sm">Update your personal information and account settings</p>
                </div>

                <!-- Messages -->
                <% if (serverError != null) { %>
                <div class="mb-6 bg-red-500/10 border border-red-500/20 text-red-400 px-6 py-4 rounded-xl flex items-center gap-3">
                    <i class="fas fa-exclamation-circle text-xl"></i>
                    <span class="font-semibold"><%= serverError %></span>
                </div>
                <% } else if (serverSuccess != null) { %>
                <div class="mb-6 bg-green-500/10 border border-green-500/20 text-green-400 px-6 py-4 rounded-xl flex items-center gap-3">
                    <i class="fas fa-check-circle text-xl"></i>
                    <span class="font-semibold"><%= serverSuccess %></span>
                </div>
                <% } %>

                <div class="flex gap-6 justify-center">
                    <!-- Left Column: Profile Preview -->
                    <div class="lg:w-1/3">
                        <div class="bg-gradient-to-br from-gray-900 to-black rounded-2xl border border-white/10 p-8 lg:sticky lg:top-24">
                            <!-- Avatar Preview -->
                            <div class="flex justify-center mb-6">
                                <div class="relative">
                                    <div id="avatarPreview" class="w-32 h-32 rounded-full overflow-hidden border-4 border-white/10 bg-gradient-to-br from-gray-800 to-gray-900">
                                        <% if (avatar == null || avatar.trim().isEmpty()) { %>
                                        <img src="https://i.pravatar.cc/150" alt="Avatar" class="w-full h-full object-cover">
                                        <% } else { %>
                                        <img src="<%= avatar %>" alt="Avatar" class="w-full h-full object-cover">
                                        <% } %>
                                    </div>
                                    
                                </div>
                            </div>

                            <!-- Name & Role -->
                            <div class="text-center mb-6">
                                <h2 class="text-2xl font-black text-white mb-1">
                                    <%= fullname.isEmpty() ? username : fullname %>
                                </h2>
                                <p class="text-gray-400 text-sm font-semibold uppercase tracking-wider">
                                    <%= user.getRole() != null ? user.getRole() : "Customer" %>
                                </p>
                            </div>

                            <!-- Info Cards -->
                            <div class="space-y-3 mb-6">
                                <div class="bg-black/40 rounded-xl p-4 border border-white/5">
                                    <div class="text-xs text-gray-400 uppercase tracking-wider mb-1">Username</div>
                                    <div class="text-white font-bold"><%= username %></div>
                                </div>
                                <div class="bg-black/40 rounded-xl p-4 border border-white/5">
                                    <div class="text-xs text-gray-400 uppercase tracking-wider mb-1">Email</div>
                                    <div class="text-white font-bold text-sm break-all"><%= email %></div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="space-y-3">
                                <a href="<%= request.getContextPath() %>/profile.jsp" 
                                   class="w-full flex items-center justify-center gap-2 bg-white/10 text-white font-bold py-3 rounded-xl border border-white/10 hover:bg-white/20 transition-all duration-300">
                                    <i class="fas fa-arrow-left"></i>
                                    <span>Back to Profile</span>
                                </a>

                                <form action="<%= request.getContextPath() %>/login?action=logout" method="post" class="w-full">
                                    <button type="submit" 
                                            class="w-full flex items-center justify-center gap-2 bg-red-500/10 text-red-400 font-bold py-3 rounded-xl border border-red-500/20 hover:bg-red-500 hover:text-white transition-all duration-300">
                                        <i class="fas fa-right-from-bracket"></i>
                                        <span>Log Out</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Edit Form -->
                    <div class="lg:w-2/3">
                        <div class="bg-gradient-to-br from-gray-900 to-black rounded-2xl border border-white/10 p-8">
                            <!-- Section Header -->
                            <div class="flex items-center gap-3 mb-8">
                                <div class="w-12 h-12 bg-white/10 rounded-xl flex items-center justify-center">
                                    <i class="fas fa-pen-to-square text-white text-xl"></i>
                                </div>
                                <div>
                                    <h3 class="text-2xl font-black text-white uppercase tracking-wide font-bebas">Update Information</h3>
                                    <p class="text-gray-400 text-sm">Changes will be saved to your account</p>
                                </div>
                            </div>

                            <!-- Edit Form -->
                            <form id="editForm" action="<%= request.getContextPath() %>/updateProfile" method="post" novalidate>
                                <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Username (Read-only) -->
                                    <div>
                                        <label for="username" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-user mr-1"></i> Username
                                        </label>
                                        <input type="text" id="username" name="username" value="<%= username %>" required readonly
                                               class="w-full bg-black/40 text-gray-500 px-4 py-3 rounded-xl border border-white/10 focus:outline-none cursor-not-allowed">
                                    </div>

                                    <!-- Email -->
                                    <div>
                                        <label for="email" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-envelope mr-1"></i> Email Address
                                        </label>
                                        <input type="email" id="email" name="email" value="<%= email %>" required
                                               class="w-full bg-black/40 text-white px-4 py-3 rounded-xl border border-white/10 focus:outline-none focus:border-white/30 transition-all">
                                    </div>

                                    <!-- Full Name -->
                                    <div>
                                        <label for="fullname" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-id-card mr-1"></i> Full Name
                                        </label>
                                        <input type="text" id="fullname" name="fullname" value="<%= fullname %>"
                                               class="w-full bg-black/40 text-white px-4 py-3 rounded-xl border border-white/10 focus:outline-none focus:border-white/30 transition-all">
                                    </div>

                                    <!-- Phone -->
                                    <div>
                                        <label for="phone" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-phone mr-1"></i> Phone Number
                                        </label>
                                        <input type="tel" id="phone" name="phone" value="<%= phone %>"
                                               class="w-full bg-black/40 text-white px-4 py-3 rounded-xl border border-white/10 focus:outline-none focus:border-white/30 transition-all">
                                    </div>

                                    <!-- Date of Birth -->
                                    <div>
                                        <label for="dob" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-calendar mr-1"></i> Date of Birth
                                        </label>
                                        <input type="date" id="dob" name="dob" value="<%= dobVal %>"
                                               class="w-full bg-black/40 text-white px-4 py-3 rounded-xl border border-white/10 focus:outline-none focus:border-white/30 transition-all">
                                    </div>

                                    <!-- Gender -->
                                    <div>
                                        <label for="gender" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-venus-mars mr-1"></i> Gender
                                        </label>
                                        <select id="gender" name="gender"
                                                class="w-full bg-black/40 text-white px-4 py-3 rounded-xl border border-white/10 focus:outline-none focus:border-white/30 transition-all appearance-none cursor-pointer">
                                            <option value="">Choose Gender</option>
                                            <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                                            <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                                            <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
                                        </select>
                                    </div>

                                    <!-- Address (Full Width) -->
                                    <div class="md:col-span-2">
                                        <label for="address" class="block text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">
                                            <i class="fas fa-map-marker-alt mr-1"></i> Address
                                        </label>
                                        <textarea id="address" name="address" rows="4"
                                                  class="w-full bg-black/40 text-white px-4 py-3 rounded-xl border border-white/10 focus:outline-none focus:border-white/30 transition-all resize-none"><%= address %></textarea>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="flex flex-col sm:flex-row gap-3 mt-8 pt-6 border-t border-white/10">
                                    <a href="<%= request.getContextPath() %>/profile.jsp" 
                                       class="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-white/10 text-white font-bold rounded-xl border border-white/10 hover:bg-white/20 transition-all duration-300">
                                        
                                        <span>Cancel</span>
                                    </a>
                                    
                                    <button type="submit" 
                                            class="flex-1 flex items-center justify-center gap-2 px-6 py-3 bg-white text-black font-bold rounded-xl hover:bg-gray-200 transition-all duration-300 hover:scale-105">
                                        
                                        <span>Save Changes</span>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <%@ include file="footer.jsp" %>

        <script>
            // basic validation
            document.getElementById('editForm')?.addEventListener('submit', function (e) {
                const email = document.getElementById('email').value.trim();
                if (!email) {
                    e.preventDefault();
                    alert('Email không được để trống.');
                    return false;
                }
            });
        </script>
    </body>
</html>

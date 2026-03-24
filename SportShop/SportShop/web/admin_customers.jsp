<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Customers Management - Sport Zone Admin</title>
        <link rel="stylesheet" href="./css/output.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
        <script src="./js/admin.js"></script>
    </head>
    <body class="bg-black text-white font-inter antialiased">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside id="sidebar" class="w-72 bg-gradient-to-b from-gray-900 to-black border-r border-white/10 flex flex-col justify-between shadow-2xl transition-all duration-300">
                <div>
                    <div class="px-6 py-8 mt-1 border-b border-white/10">
                        <a href="home" class="block text-center font-bebas text-transparent bg-clip-text bg-white to-gray-400 text-4xl font-black uppercase tracking-[0.15em] transition-all duration-500 hover:tracking-[0.25em] drop-shadow-lg">
                            SPORT ZONE
                        </a>
                        <p class="text-center text-xs text-gray-400 mt-2 uppercase tracking-wider">
                            Admin Dashboard
                        </p>
                    </div>
                    <nav class="px-4 space-y-1 mt-6">
                        <a href="dashboard" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
                            <i class="fas fa-chart-line mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Dashboard</span>
                        </a>
                        <a href="products" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
                            <i class="fas fa-box mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Products</span>
                        </a>
                        <a href="order" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
                            <i class="fas fa-shopping-cart mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Orders</span>
                        </a>
                        <a href="customer" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
                            <i class="fas fa-users mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Users</span>
                        </a>
                        <a href="reviews" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 active-link group">
                            <i class="fas fa-star mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Reviews</span>
                        </a>
                        <a href="footer" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
                            <i class="fas fa-users mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Footer</span>
                        </a>
                    </nav>
                </div>
                <div class="p-6 border-t border-white/10">
                    <div class="relative group">
                        <div class="flex items-center gap-4 cursor-pointer p-3 rounded-xl hover:bg-white/10 transition-all">
                            <div class="relative">
                                <img src="https://i.pravatar.cc/100" class="w-10 h-10 rounded-full border-2 border-gray-600 shadow-lg" alt="Admin Avatar" />
                                <div class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-black"></div>
                            </div>
                            <div class="flex-1">
                                <p class="font-bold text-white">${account.userName}</p>
                                <p class="text-xs text-gray-400">${account.email}</p>
                            </div>
                            <i class="fas fa-chevron-up text-gray-500 text-sm group-hover:text-gray-300"></i>
                        </div>
                        <div
                            class="absolute bottom-20 left-3 right-3 mb-2 bg-gray-800 rounded-xl shadow-2xl border border-white/20 p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 z-50"
                            >
                            <!-- Profile -->
                            <a
                                href="profile"
                                class="flex items-center gap-3 px-4 py-3 hover:bg-white/10 rounded-lg text-sm font-medium text-gray-300 hover:text-blue-400 transition-all"
                                >
                                <i class="fas fa-user"></i>
                                <span>Profile</span>
                            </a>

                            <!-- Logout -->
                            <a
                                href="logout"
                                class="flex items-center gap-3 px-4 py-3 hover:bg-white/10 rounded-lg text-sm font-medium text-gray-300 hover:text-red-400 transition-all"
                                >
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Logout</span>
                            </a>
                        </div>

                    </div>
                </div>
            </aside>

            <!-- Toggle Sidebar Button -->
            <button id="toggleSidebar" 
                    class="fixed top-1/2 -translate-y-1/2 left-72 z-50 w-8 h-14 bg-gray-900 hover:bg-gray-800 rounded-r-lg border border-l-0 border-white/10 flex items-center justify-center transition-all shadow-lg"
                    onclick="toggleSidebar()">
                <i class="fas fa-chevron-left text-white text-sm"></i>
            </button>

            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto">
                <div class="p-4 md:p-8">
                    <section id="customers" class="p-4 md:p-8 font-inter">
                        <!-- Header -->
                        <div class="mb-10">
                            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                                <div>
                                    <h2 class="text-4xl font-black text-white mb-2 font-bebas tracking-wider">Customer Management</h2>
                                    <p class="text-gray-400">Tracking and managing customer accounts</p>
                                </div>
                                <a href="customer?action=add" class="bg-white text-black font-bold uppercase px-8 py-4 rounded-xl hover:bg-gray-200 transition-all shadow-lg hover:shadow-xl flex items-center gap-3 group">
                                    <i class="fas fa-plus group-hover:rotate-90 transition-transform duration-300"></i>
                                    <span>Add New Customer</span>
                                </a>
                            </div>
                        </div>

                        <div class="bg-gray-900 rounded-2xl p-6 mb-8 border border-white/10 shadow-lg">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

                                <!-- Search -->
                                <form action="customer" method="GET" class="md:col-span-2">
                                    <input type="hidden" name="typeFilter" value="${param.typeFilter}">
                                    <input type="hidden" name="sort" value="${param.sort}">

                                    <div class="relative">
                                        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"></i>
                                        <input
                                            type="text"
                                            name="search"
                                            placeholder="Search by name or email..."
                                            class="w-full bg-black text-white pl-12 pr-4 py-3.5 rounded-xl border border-white/10
                                            focus:outline-none focus:ring-2 focus:ring-white focus:border-transparent
                                            transition-all placeholder:text-gray-500"
                                            value="${param.search}"
                                            onchange="this.form.submit()" 
                                            />
                                    </div>
                                </form>

                                <!-- Sort -->
                                <form action="customer" method="GET" class="md:col-span-1">
                                    <input type="hidden" name="search" value="${param.search}">
                                    <select 
                                        name="sort" 
                                        class="w-full bg-black text-white px-4 py-3.5 rounded-xl border border-white/10
                                        focus:outline-none focus:ring-2 focus:ring-white"
                                        onchange="this.form.submit()"
                                        >
                                        <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Sort A-Z</option>
                                        <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Sort Z-A</option>
                                    </select>
                                </form>

                            </div>
                        </div>


                        <!-- Customers List -->
                        <div class="bg-gray-900 rounded-2xl border border-white/10 overflow-hidden mb-8">
                            <!-- Table Header -->
                            <div class="grid grid-cols-12 gap-4 px-6 py-4 bg-black/40 border-b border-white/10 text-xs font-bold text-gray-400 uppercase tracking-wider">
                                <div class="col-span-1">Id</div>
                                <div class="col-span-2">Full name</div>
                                <div class="col-span-3">Email</div>
                                <div class="col-span-2 text-center">Phone number</div>
                                <div class="col-span-2 text-center">Role</div>
                                <div class="col-span-2 text-center">Actions</div>
                            </div>

                            <!-- Table Body -->
                            <div id="customersGrid" class="divide-y divide-white/5">
                                <c:if test="${empty customerList}">
                                    <div class="text-center py-16">
                                        <i class="fas fa-users text-5xl text-gray-700 mb-3"></i>
                                        <p class="text-gray-400 text-sm">Don't have any users</p>
                                    </div>
                                </c:if>
                                <c:forEach var="customer" items="${customerList}">
                                    <div class="grid grid-cols-12 items-center gap-4 px-6 py-5 hover:bg-white/5 transition group">
                                        <!-- ID -->
                                        <div class="col-span-1">
                                            <p class="text-gray-500 text-base tabular-nums">${customer.userId}</p>
                                        </div>

                                        <!-- Name -->
                                        <div class="col-span-2 min-w-0">
                                            <h4 class="text-white text-base truncate" title="${customer.userFullName}">
                                                ${customer.userFullName}
                                            </h4>
                                        </div>

                                        <!-- Email -->
                                        <div class="col-span-3 min-w-0 text-sm">
                                            <a href="mailto:${customer.email}"
                                               class="text-gray-300 text-base truncate hover:text-white"
                                               title="${customer.email}">
                                                ${customer.email}
                                            </a>
                                        </div>

                                        <!-- Phone -->
                                        <div class="col-span-2 text-center text-sm">
                                            <a href="tel:${customer.phoneNumber}"
                                               class="text-white text-base whitespace-nowrap hover:underline"
                                               title="${customer.phoneNumber}">
                                                ${customer.phoneNumber}
                                            </a>
                                        </div>

                                        <!-- Role pill -->
                                        <div class="col-span-2 flex justify-center">
                                            <c:choose>
                                                <c:when test="${customer.role eq 'Admin'}">
                                                    <span class="px-3 py-1.5 rounded-full text-xs font-bold  bg-blue-500/20 text-blue-300 whitespace-nowrap">
                                                        Admin
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-green-500/20 text-green-300 whitespace-nowrap">
                                                        Customer
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Actions -->
                                        <div class="col-span-2 flex items-center justify-center gap-2">
                                            <!-- View -->
                                            <a href="customer?action=view&id=${customer.userId}"
                                               class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-gray-400 hover:text-white transition flex items-center justify-center border border-white/10"
                                               title="Xem">
                                                <i class="fas fa-eye text-xs"></i>
                                            </a>

                                            <!-- Edit -->
                                            <a href="#"
                                               onclick="openEditCustomer('${customer.userId}'); return false;"
                                               class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white text-gray-400 hover:text-black transition flex items-center justify-center border border-white/10"
                                               title="Sửa">
                                                <i class="fas fa-edit text-xs"></i>
                                            </a>

                                            <!-- Delete -->
                                            <button type="button"
                                                    onclick="openDeleteCustomerModal('${customer.userId}', '${customer.userFullName}')"
                                                    class="w-8 h-8 rounded-lg bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white transition flex items-center justify-center border border-red-500/20"
                                                    title="Xóa">
                                                <i class="fas fa-trash text-xs"></i>
                                            </button>
                                        </div>
                                    </div>

                                </c:forEach>
                            </div>
                            <div style="margin-bottom: 10px">
                                <jsp:include page="pagination.jsp"/>
                            </div>


                        </div>
                        <!-- Footer counter -->
                        <div class="flex items-center justify-between p-5 bg-gray-900 rounded-xl border border-white/10">
                            <div class="text-sm text-gray-400">
                                Showing <span class="text-white font-bold">${fn:length(customerList)}</span> of <span class="text-white font-bold">${totalCustomers}</span> customers
                            </div>
                        </div>

                        <!-- HIDDEN FORM FOR DELETE ACTION -->
                        <form id="deleteCustomerForm" action="customer" method="POST" class="hidden">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" id="deleteCustomerId" name="id">
                        </form>

                        <!-- Customer Detail Modal -->
                        <div id="customerDetailModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
                            <div class="bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 max-h-[90vh] overflow-y-auto border border-white/10">
                                <c:if test="${not empty customerToView}">
                                    <!-- Modal Header -->
                                    <div class="flex items-center justify-between p-8 border-b border-white/10">
                                        <div class="flex items-center gap-4">
                                            <div class="relative">
                                                <c:choose>
                                                    <c:when test="${not empty customerToView.userAvatar}">
                                                        <img src="uploads/${customerToView.userAvatar}" 
                                                             class="w-16 h-16 rounded-full object-cover border-2 border-white/20 shadow-lg" 
                                                             alt="${customerToView.userFullName}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="w-16 h-16 rounded-full bg-gradient-to-br from-gray-700 to-gray-800 flex items-center justify-center border-2 border-white/20 shadow-lg">
                                                            <i class="fas fa-user text-2xl text-gray-400"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${customerToView.role eq 'Admin'}">
                                                        <div class="absolute -bottom-1 -right-1 w-6 h-6 bg-blue-500 rounded-full border-2 border-gray-900 flex items-center justify-center">
                                                            <i class="fas fa-crown text-xs text-white"></i>
                                                        </div>
                                                    </c:when>

                                                </c:choose>
                                            </div>
                                            <div>
                                                <h3 class="text-2xl font-black text-white uppercase font-bebas tracking-wider">Customer Details</h3>
                                                <p class="text-gray-400 text-sm">View complete customer information</p>
                                            </div>
                                        </div>
                                        <button onclick="closeModal('customerDetailModal')" type="button" 
                                                class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 transition-colors flex items-center justify-center">
                                            <i class="fas fa-times text-gray-300"></i>
                                        </button>
                                    </div>

                                    <!-- Modal Body -->
                                    <div class="p-8">
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <!-- ID -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Customer ID</p>
                                                <p class="text-white text-lg font-bold">#${customerToView.userId}</p>
                                            </div>

                                            <!-- Username -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Username</p>
                                                <p class="text-white text-lg font-bold">${customerToView.userName}</p>
                                            </div>

                                            <!-- Full Name -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Full Name</p>
                                                <p class="text-white text-lg font-bold">${customerToView.userFullName}</p>
                                            </div>

                                            <!-- Role -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Role</p>
                                                <c:choose>
                                                    <c:when test="${customerToView.role eq 'Admin'}">
                                                        <span class="inline-flex px-4 py-2 rounded-full text-sm font-bold bg-blue-500/20 text-blue-300">
                                                            <i class="fas fa-crown mr-2"></i> Admin
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex px-4 py-2 rounded-full text-sm font-bold bg-green-500/20 text-green-300">
                                                            <i class="fas fa-user mr-2"></i> Customer
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Email -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Email Address</p>
                                                <a href="mailto:${customerToView.email}" class="text-white text-base hover:text-blue-400 transition flex items-center gap-2">

                                                    <span>${customerToView.email}</span>
                                                </a>
                                            </div>

                                            <!-- Phone -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Phone Number</p>
                                                <a href="tel:${customerToView.phoneNumber}" class="text-white text-base hover:text-blue-400 transition flex items-center gap-2">

                                                    <span>${customerToView.phoneNumber}</span>
                                                </a>
                                            </div>

                                            <!-- Gender -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Gender</p>
                                                <p class="text-white text-base flex items-center gap-2">
                                                    <c:choose>
                                                        <c:when test="${customerToView.gender eq 'Male'}">

                                                            <span>Male</span>
                                                        </c:when>
                                                        <c:otherwise>

                                                            <span>Female</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>

                                            <!-- Date of Birth -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Date of Birth</p>
                                                <p class="text-white text-base flex items-center gap-2">

                                                    <span><fmt:formatDate value="${customerToView.dateOfBirth}" pattern="dd/MM/yyyy" /></span>
                                                </p>
                                            </div>

                                            <!-- Address -->
                                            <div class="bg-black/40 rounded-xl p-4 border border-white/10 md:col-span-2">
                                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Address</p>
                                                <p class="text-white text-base flex items-center gap-2">

                                                    <span>${customerToView.address}</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Modal Footer -->
                                    <div class="p-8 border-t border-white/10 flex gap-3">
                                        <a href="customer?action=edit&id=${customerToView.userId}" 
                                           class="flex-1 bg-white text-black font-bold uppercase py-4 rounded-xl hover:bg-gray-200 transition-all text-center">
                                            Edit Customer
                                        </a>
                                        <button type="button" 
                                                onclick="closeModal('customerDetailModal')" 
                                                class="flex-1 bg-white/10 text-white font-bold uppercase py-4 rounded-xl hover:bg-white/20 transition-all">
                                            Close
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>


                        <!-- Add/Edit Customer Modal -->
                        <div id="customerModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
                            <div class="bg-gray-900 rounded-2xl shadow-2xl p-8 w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto border border-white/10">
                                <div class="flex items-center justify-between mb-6">
                                    <h3 class="text-3xl font-black text-white uppercase font-bebas">
                                        <c:choose>
                                            <c:when test="${not empty customerToEdit}">Edit User</c:when>
                                            <c:otherwise>ADD NEW USER</c:otherwise>
                                        </c:choose>
                                    </h3>
                                    <button onclick="closeModal('customerModal')" type="button" class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 transition-colors flex items-center justify-center">
                                        <i class="fas fa-times text-gray-300"></i>
                                    </button>
                                </div>
                                <form id="customerForm" action="customer" method="POST" class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                    <c:choose>
                                        <c:when test="${not empty customerToEdit}">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${customerToEdit.userId}">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="add">
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Prefill helpers for edit mode -->
                                    <c:if test='${not empty customerToEdit}'>
                                        <fmt:formatDate value='${customerToEdit.dateOfBirth}' pattern='yyyy-MM-dd' var='dobStr'/>
                                    </c:if>

                                    <div class="md:col-span-2">
                                        <label class="text-base font-semibold text-gray-300 mb-2 block" >Username *</label>
                                        <input name="username" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" placeholder="nguyenvana" value="${customerToEdit.userName}"/>

                                        <label class="text-base font-semibold text-gray-300 mb-2 block" >Full name *</label>
                                        <input name="fullname" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" placeholder="Nguyễn Văn A" value="${customerToEdit.userFullName}"/>
                                        <label class="text-base font-semibold text-gray-300 block my-3" >Email *</label>
                                        <input name="email" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" placeholder="name@gmail.com" value="${customerToEdit.email}"/>
                                        <label class="text-base font-semibold text-gray-300 block my-3" >Password</label>
                                        <input type="password" name="password" placeholder="Leave blank to keep current" class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10"/>
                                        <label class="text-base font-semibold text-gray-300 block my-3" >Phone Number *</label>
                                        <input type="text" name="phone" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" placeholder="0123456789" value="${customerToEdit.phoneNumber}"/>
                                        <div class="flex gap-4">
                                            <!-- Gender -->
                                            <div class="w-1/2 ">
                                                <label for="gender" class="text-base font-semibold text-gray-300 block mb-2 my-3">Gender</label>
                                                <select name="gender" id="gender"
                                                        class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10">
                                                    <option>Male</option>
                                                    <option>Female</option>
                                                </select>
                                            </div>

                                            <!-- Role -->
                                            <div class="w-1/2">
                                                <label for="role" class="text-base font-semibold text-gray-300 block mb-2 my-3">Role</label>
                                                <select name="role" id="role"
                                                        class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10">
                                                    <option>Admin</option>
                                                    <option>Customer</option>
                                                </select>
                                            </div>
                                        </div>
                                        <label class="text-base font-semibold text-gray-300 block my-3" >Address</label>
                                        <input type="text" name="address" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" placeholder="Hung Yen" value="${customerToEdit.address}"/>
                                        <label class="text-base font-semibold text-gray-300 block my-3" >Date of birth</label>
                                        <input type="date" name="dateOfbirth" required class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10" value='${dobStr}'/>
                                        <label class="text-base font-semibold text-gray-300 block my-3" >Upload your avatar</label>
                                        <input type="file" name="avatar" class="w-full bg-black text-white px-4 py-3 rounded-xl border border-white/10"/>
                                        <c:if test='${not empty customerToEdit.userAvatar}'>
                                            <p class="text-xs text-gray-400 mt-2">Current file: ${customerToEdit.userAvatar}</p>
                                        </c:if>
                                    </div>
                                    <div class="md:col-span-2 flex gap-3 pt-4">
                                        <button type="submit" class="flex-1 bg-white text-black font-bold uppercase py-4 rounded-xl hover:bg-gray-200">Save</button>
                                        <button type="button" onclick="closeModal('customerModal')" class="flex-1 bg-white/10 text-white font-bold uppercase py-4 rounded-xl hover:bg-white/20">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>


                        <!-- Delete Modal -->
                        <div id="deleteCustomerModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
                            <div class="bg-gray-900 rounded-2xl shadow-2xl p-8 w-full max-w-md mx-4 border border-white/10">
                                <h3 class="text-xl font-bold text-white mb-4">Delete customer</h3>
                                <p class="text-gray-300 mb-6">
                                    Are you sure to delete: <span id="deleteCustomerName" class="font-semibold text-white"></span>?
                                </p>
                                <div class="flex gap-3">
                                    <button type="button" class="flex-1 bg-white/10 text-white font-bold py-3 rounded-xl hover:bg-white/20"
                                            onclick="closeModal('deleteCustomerModal')">Cancel</button>
                                    <button type="button" class="flex-1 bg-red-500 text-white font-bold py-3 rounded-xl hover:bg-red-600"
                                            onclick="confirmDeleteCustomer()">Delete</button>
                                </div>
                            </div>
                        </div>

                    </section>
                </div>
            </main>
        </div>
        <c:if test='${not empty openModal}'>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var modalId = '<c:out value="${openModal}"/>';
                    var el = document.getElementById(modalId);
                    if (el) {
                        el.classList.remove('hidden');
                        el.classList.add('flex');
                    }
                });
            </script>
        </c:if>
    </script>
</body>
</html>

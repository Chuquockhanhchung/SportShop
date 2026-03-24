<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Orders Management - Sport Zone Admin</title>
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
                        <a href="order" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 active-link group">
                            <i class="fas fa-shopping-cart mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Orders</span>
                        </a>
                        <a href="customer" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
                            <i class="fas fa-users mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Users</span>
                        </a>
                        <a href="reviews" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group">
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
                    <section id="orders" class="p-4 md:p-8 font-inter">
                        <!-- Header -->
                        <div class="mb-10">
                            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                                <div>
                                    <h2 class="text-4xl font-black text-white mb-2 font-bebas tracking-wider">
                                        Order Management
                                    </h2>
                                    <p class="text-gray-400">A comprehensive list of all orders and their status.</p>
                                </div>
                            </div>
                        </div>

                        <div class="bg-gray-900 rounded-2xl p-6 mb-8 border border-white/10 shadow-lg">
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                                <!-- Form 1: Search -->
                                <form
                                    action="order"
                                    method="GET"
                                    class="relative md:col-span-2"
                                    >
                                    <input type="hidden" name="statusFilter" value="${param.statusFilter}" />
                                    <input type="hidden" name="sort" value="${param.sort}" />
                                    <i
                                        class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"
                                        ></i>
                                    <input
                                        type="text"
                                        name="search"
                                        placeholder="Search by Order ID, Customer..."
                                        class="w-full bg-black text-white pl-12 pr-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
                                        value="${param.search}"
                                        onchange="this.form.submit()"
                                        />
                                </form>

                                <!-- Form 2: Filter and Sort -->
                                <form
                                    action="order"
                                    method="GET"
                                    class="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4"
                                    >
                                    <input type="hidden" name="search" value="${param.search}" />
                                    <select
                                        name="statusFilter"
                                        class="w-full bg-black text-white px-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
                                        onchange="this.form.submit()"
                                        >
                                        <option value="" ${empty param.statusFilter ? 'selected' : ''}>
                                            All Statuses
                                        </option>
                                        <option value="pending" ${param.statusFilter == 'pending' ? 'selected' : ''}>
                                            Pending
                                        </option>
                                        <option value="shipping" ${param.statusFilter == 'shipping' ? 'selected' : ''}>
                                            Shipping
                                        </option>
                                        <option value="completed" ${param.statusFilter == 'completed' ? 'selected' : ''}>
                                            Completed
                                        </option>
                                        <option value="cancelled" ${param.statusFilter == 'cancelled' ? 'selected' : ''}>
                                            Cancelled
                                        </option>
                                    </select>
                                    <select
                                        name="sort"
                                        class="w-full bg-black text-white px-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
                                        onchange="this.form.submit()"
                                        >
                                        <option value="date-desc" ${param.sort == 'date-desc' ? 'selected' : ''}>
                                            Newest
                                        </option>
                                        <option value="date-asc" ${param.sort == 'date-asc' ? 'selected' : ''}>
                                            Oldest
                                        </option>
                                    </select>
                                </form>
                            </div>
                        </div>

                        <!-- Orders List -->
                        <div class="bg-gray-900 rounded-2xl border border-white/10 overflow-hidden mb-8">
                            <!-- Table Header (Hidden on Mobile) -->
                            <div class="hidden md:grid grid-cols-12 gap-4 px-6 py-4 bg-black/40 border-b border-white/10 text-xs font-bold text-gray-400 uppercase tracking-wider text-center gap-4">
                                <div class="col-span-1 text-left">Order ID</div>
                                <div class="col-span-2 text-center items-center">Full Name</div>
                                <div class="col-span-1 ">Order Date</div>
                                <div class="col-span-2 ">Tracking Number</div>
                                <div class="col-span-2 text-center">Price</div>
                                <div class="col-span-2 2text-center">Status</div>
                                <div class="col-span-2 text-center ">Actions</div>
                            </div>
                            <!-- Table Body -->
                            <div id="ordersGrid" class="divide-y divide-white/5">
                                <c:if test="${empty orderList}">
                                    <div class="text-center py-16">
                                        <i class="fas fa-shopping-cart text-5xl text-gray-700 mb-3"></i>
                                        <p class="text-gray-400 text-sm">No orders found</p>
                                    </div>
                                </c:if>
                                <c:forEach var="order" items="${orderList}">
                                    <div class="block md:grid md:grid-cols-12 md:gap-4 px-6 py-5 hover:bg-white/5 transition-all group md:items-center">

                                        <div class="md:col-span-1 flex justify-between items-center py-1 md:py-0 border-b border-gray-800 md:border-none">
                                            <span class="text-xs text-gray-400 font-bold uppercase md:hidden">Mã đơn</span>
                                            <div class="flex items-center gap-2">

                                                <span class="text-white font-semibold text-sm">${order.cartId}</span>
                                            </div>
                                        </div>

                                        <div class="md:col-span-2 flex justify-between items-center py-2 md:py-0 border-b border-gray-800 md:border-none">
                                            <span class="text-xs text-gray-400 font-bold uppercase md:hidden">Full Name</span>
                                            <p class="text-white font-medium text-sm ">${order.userFullName}</p>
                                        </div>

                                        <div class="md:col-span-1 flex justify-between items-center py-2 md:py-0 border-b border-gray-800 md:border-none">
                                            <span class="text-xs text-gray-400 font-bold uppercase md:hidden">Order Date</span>
                                            <span class="text-gray-300 text-sm"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></span>
                                        </div>

                                        <div class="md:col-span-2 flex justify-between items-center py-2 md:py-0 border-b border-gray-800 md:border-none md:justify-center">
                                            <span class="text-xs text-gray-400 font-bold uppercase md:hidden">Tracking Number</span>
                                            <span class="text-gray-300 text-sm truncate">${order.trackingNumber}</span>
                                        </div>

                                        <div class="md:col-span-2 flex justify-between items-center py-2 md:py-0 border-b border-gray-800 md:border-none md:justify-end">
                                            <span class="text-xs text-gray-400 font-bold uppercase md:hidden">Price</span>
                                            <span class="text-white font-semibold text-sm"><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> VND</span>
                                        </div>

                                        <div class="md:col-span-2 flex justify-center items-center py-2 md:py-0 border-b border-gray-800 md:border-none">
                                            <span class="text-xs text-gray-400 font-bold uppercase md:hidden">Status</span>
                                            <span class="px-3 py-1.5 rounded-full text-xs font-bold border border-gray-500/50 bg-gray-500/20 text-gray-300">
                                                ${order.status}
                                            </span>
                                        </div>

                                        <div class="md:col-span-2 flex justify-end items-center gap-2 pt-4 md:pt-0 md:justify-end">
                                            <a href="order?action=view&id=${order.orderId}" class="w-9 h-9 rounded-lg bg-white/10 hover:bg-white/20 border border-white/10 text-gray-400 hover:text-white transition-all flex items-center justify-center" title="View"><i class="fas fa-eye text-xs"></i></a>
                                            <button onclick="openDeleteOrderModal('${order.orderId}', '${order.cartId}')" class="w-9 h-9 rounded-lg bg-red-500/10 hover:bg-red-500 border border-red-500/20 text-red-400 hover:text-white transition-all flex items-center justify-center" title="Delete"><i class="fas fa-trash text-xs"></i></button>
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
                                Showing <span class="text-white font-bold">${orderList.size()}</span> / <span class="text-white font-bold">${totalOrders}</span> orders
                            </div>
                        </div>

                        <!-- Order Detail Modal-->
                        <div id="orderDetailModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
                            <div class="bg-gray-900 rounded-2xl shadow-2xl w-full max-w-5xl mx-4 max-h-[90vh] overflow-hidden border border-white/10 flex flex-col">
                                <!-- Modal Header -->
                                <div class="flex items-center justify-between px-8 py-6 border-b border-white/10 bg-black/40 flex-shrink-0">
                                    <div class="flex items-center gap-4">
                                        <div class="w-12 h-12 bg-grey-500 rounded-xl flex items-center justify-center border border-gray-600">
                                            <i class="fas fa-receipt text-white text-xl"></i>
                                        </div>
                                        <div>
                                            <h3 class="text-2xl font-black text-white uppercase tracking-wide font-bebas">Order Details</h3>
                                            <p class="text-gray-400 text-sm">Complete information about the order</p>
                                        </div>
                                    </div>
                                    <button onclick="closeModal('orderDetailModal')" type="button" class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 transition-all flex items-center justify-center group">
                                        <i class="fas fa-times text-gray-400 group-hover:text-white transition-colors"></i>
                                    </button>
                                </div>

                                <c:if test="${not empty orderToView}">
                                    <!-- Modal Body - Scrollable -->
                                    <div class="overflow-y-auto p-8 space-y-6">
                                        <!-- Order Header Info -->
                                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                            <div class="bg-black/40 rounded-xl p-5 border border-white/10">
                                                <div class="flex items-center gap-2 mb-2">
                                                    <i class="fas fa-hashtag text-gray-400 font-xs"></i>
                                                    <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Order ID</p>
                                                </div>
                                                <p class="text-xl font-black text-white">${orderToView.orderId}</p>
                                            </div>
                                            <div class="bg-black/40 rounded-xl p-5 border border-white/10">
                                                <div class="flex items-center gap-3 mb-2">
                                                    <i class="fas fa-calendar-alt text-grey-400"></i>
                                                    <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Order Date</p>
                                                </div>
                                                <p class="text-xl font-black text-white"><fmt:formatDate value="${orderToView.orderDate}" pattern="dd/MM/yyyy"/></p>
                                            </div>
                                            <div class="bg-black/40 rounded-2xl p-6 border border-white/10 shadow-lg">
                                                <div class="flex items-center justify-between mb-4">
                                                    <div class="flex items-center gap-3">
                                                        <div class="w-9 h-9 rounded-lg bg-white/10 flex items-center justify-center">
                                                            <i class="fas fa-info-circle text-gray-300 text-sm"></i>
                                                        </div>
                                                        <div>
                                                            <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Status</p>
                                                            <p class="text-white font-semibold text-sm">Update order status</p>
                                                        </div>
                                                    </div>

                                                    <!-- Current Status Badge -->
                                                    <c:choose>
                                                        <c:when test='${orderToView.status == "Pending"}'>
                                                            <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-yellow-500/20 text-yellow-400 border border-yellow-500/30">
                                                                Pending
                                                            </span>
                                                        </c:when>
                                                        <c:when test='${orderToView.status == "Shipping"}'>
                                                            <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-blue-500/20 text-blue-400 border border-blue-500/30">
                                                                Shipping
                                                            </span>
                                                        </c:when>
                                                        <c:when test='${orderToView.status == "Completed"}'>
                                                            <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-green-500/20 text-green-400 border border-green-500/30">
                                                                Completed
                                                            </span>
                                                        </c:when>
                                                        <c:when test='${orderToView.status == "Cancelled"}'>
                                                            <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-red-500/20 text-red-400 border border-red-500/30">
                                                                Cancelled
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-gray-500/20 text-gray-400 border border-gray-500/30">
                                                                ${orderToView.status}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <form action="order" method="post" class="flex flex-col sm:flex-row gap-3">
                                                    <input type="hidden" name="action" value="update" />
                                                    <input type="hidden" name="id" value="${orderToView.orderId}" />

                                                    <select name="status"
                                                            class="flex-1 bg-black text-white px-4 py-2.5 rounded-lg border border-white/10 focus:outline-none focus:ring-2 focus:ring-white/30">
                                                        <option value="Pending" ${orderToView.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                        <option value="Shipping" ${orderToView.status == 'Shipping' ? 'selected' : ''}>Shipping</option>
                                                        <option value="Completed" ${orderToView.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                                        <option value="Cancelled" ${orderToView.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                                    </select>

                                                    <button type="submit"
                                                            class="px-6 py-2.5 rounded-lg bg-gradient-to-r from-green-400 to-green-500 text-white font-bold hover:from-green-500 hover:to-green-600 transition-all">
                                                        <i class="fas fa-sync-alt mr-2"></i>Update
                                                    </button>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Customer & Shipping Information -->
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                            <div class="bg-gradient-to-br from-blue-500/10 to-purple-500/10 rounded-xl p-6 border border-blue-500/20">
                                                <div class="flex items-center gap-3 mb-5">
                                                    <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center">
                                                        <i class="fas fa-user text-blue-400 text-lg"></i>
                                                    </div>
                                                    <h4 class="text-lg font-black text-white uppercase tracking-wide font-bebas">Customer Info</h4>
                                                </div>
                                                <div class="space-y-4">
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-400 uppercase mb-1">Full Name</p>
                                                        <p class="text-white font-bold text-lg">${orderToView.userFullName}</p>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-400 uppercase mb-1">Phone Number</p>
                                                        <p class="text-white font-medium flex items-center gap-2"><i class="fas fa-phone text-gray-500 text-sm"></i>-</p>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-400 uppercase mb-1">Email Address</p>
                                                        <p class="text-white font-medium flex items-center gap-2"><i class="fas fa-envelope text-gray-500 text-sm"></i>-</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="bg-gradient-to-br from-green-500/10 to-teal-500/10 rounded-xl p-6 border border-green-500/20">
                                                <div class="flex items-center gap-3 mb-5">
                                                    <div class="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center">
                                                        <i class="fas fa-truck text-green-400 text-lg"></i>
                                                    </div>
                                                    <h4 class="text-lg font-black text-white uppercase tracking-wide font-bebas">Shipping Info</h4>
                                                </div>
                                                <div class="space-y-4">
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-400 uppercase mb-1">Delivery Address</p>
                                                        <p class="text-white font-medium flex items-start gap-2 leading-relaxed"><i class="fas fa-map-marker-alt text-gray-500 text-sm mt-1"></i><span>${orderToView.address}</span></p>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-400 uppercase mb-1">Tracking Number</p>
                                                        <p class="text-white font-bold flex items-center gap-2"><i class="fas fa-barcode text-gray-500 text-sm"></i>${orderToView.trackingNumber}</p>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-semibold text-gray-400 uppercase mb-1">Shipping Method</p>
                                                        <p class="text-white font-medium">Standard Delivery (3-5 days)</p>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Delete Modal -->
                        <div id="deleteModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
                            <div class="bg-gray-900 rounded-2xl shadow-2xl p-8 w-full max-w-md mx-4 border border-white/10">
                                <div class="text-center">
                                    <div class="w-20 h-20 bg-red-500/20 rounded-full flex items-center justify-center mx-auto mb-5 border-4 border-red-500/30">
                                        <i class="fas fa-exclamation-triangle text-red-400 text-3xl"></i>
                                    </div>
                                    <h3 class="text-white text-2xl font-black mb-3">Confirm Deletion</h3>
                                    <p class="text-gray-400 mb-6 leading-relaxed">Are you sure you want to delete the order<br/>"<span id="deleteOrderName" class="text-white font-bold"></span>"?</p>
                                    <div class="flex gap-3">
                                        <button onclick="closeModal('deleteModal')" type="button" class="flex-1 bg-white/10 text-white font-bold py-3.5 rounded-xl hover:bg-white/20 transition-colors">Cancel</button>
                                        <form id="deleteForm" action="order" method="POST" class="flex-1">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" id="deleteOrderId" name="id">
                                            <button type="submit" class="w-full bg-red-500 text-white font-bold py-3.5 rounded-xl hover:bg-red-600 transition-colors"><i class="fas fa-trash mr-2"></i>Delete Order</button>
                                        </form>
                                    </div>
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
        <script>
            function openDeleteModal(id, name) {
                document.getElementById('deleteOrderId').value = id;
                document.getElementById('deleteOrderName').textContent = name;
                document.getElementById('deleteModal').classList.remove('hidden');
                document.getElementById('deleteModal').classList.add('flex');
            }
        </script>
    </body>
</html>


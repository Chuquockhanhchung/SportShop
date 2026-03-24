<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>All Products - Sport Zone</title>
        <!-- font-awesome -->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
            />
        <!-- tailwind css -->
        <link rel="stylesheet" href="./css/output.css" />
        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
        <!-- Dashboard Charts Script -->
        <script src="./js/charts.js"></script>
        <!-- Admin JavaScript -->
        <script src="./js/admin.js"></script>
        <style>
            /* Smooth transitions */
            * {
                transition: background-color 0.2s ease, border-color 0.2s ease;
            }

            /* Card hover effect - Dark Mode */
            .stat-card {
                background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5);
                border: 1px solid rgba(255, 255, 255, 0.1);
            }
            .stat-card:hover {
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.8),
                    0 10px 10px -5px rgba(0, 0, 0, 0.5);
                transform: translateY(-2px);
                border-color: rgba(255, 255, 255, 0.2);
            }

            /* Active link indicator - Dark Mode */
            .nav-link {
                position: relative;
                overflow: hidden;
            }
            .nav-link::before {
                content: "";
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 3px;
                height: 0;
                background: #fff;
                transition: height 0.3s ease;
            }
            .nav-link.active-link {
                background-color: #fff !important;
                color: #000 !important;
            }
            .nav-link.active-link::before {
                height: 60%;
                background: #000;
            }
        </style>
    </head>
    <body class="bg-black text-white font-inter">
        <div class="flex h-screen">
            <!-- sidebar -->
            <aside
                id="sidebar"
                class="w-72 bg-gradient-to-b from-gray-900 to-black border-r border-white/10 flex flex-col justify-between shadow-2xl"
                style="transition: margin-left 0.3s ease;"
                >
                <div>
                    <div class="px-6 py-8 mt-1 border-b border-white/10">
                        <a
                            href="home.jsp"
                            class="block text-center font-bebas text-transparent bg-clip-text bg-white to-gray-400 text-4xl font-black uppercase tracking-[0.15em] transition-all duration-500 hover:tracking-[0.25em] drop-shadow-lg"
                            >
                            SPORT ZONE
                        </a>
                        <p
                            class="text-center text-xs text-gray-400 mt-2 uppercase tracking-wider"
                            >
                            Admin Dashboard
                        </p>
                    </div>
                    <nav class="px-4 space-y-1 mt-6">
                        <a
                            href="dashboard"
                            class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 active-link group"
                            >
                            <i
                                class="fas fa-chart-line mr-4 text-lg group-hover:scale-110 transition-transform"
                                ></i>
                            <span class="font-semibold">Dashboard</span>
                        </a>
                        <a
                            href="products"
                            class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group"
                            >
                            <i
                                class="fas fa-box mr-4 text-lg group-hover:scale-110 transition-transform"
                                ></i>
                            <span class="font-semibold">Products</span>
                        </a>
                        <a
                            href="order"
                            class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group"
                            >
                            <i
                                class="fas fa-shopping-cart mr-4 text-lg group-hover:scale-110 transition-transform"
                                ></i>
                            <span class="font-semibold">Orders</span>
                        </a>
                        <a
                            href="customer"
                            class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group"
                            >
                            <i
                                class="fas fa-users mr-4 text-lg group-hover:scale-110 transition-transform"
                                ></i>
                            <span class="font-semibold">Users</span>
                        </a>
                        <a href="reviews" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300  group">
                            <i class="fas fa-star mr-4 text-lg group-hover:scale-110 transition-transform"></i>
                            <span class="font-semibold">Reviews</span>
                        </a>
                        <a
                            href="footer"
                            class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 group"
                            >
                            <i
                                class="fas fa-users mr-4 text-lg group-hover:scale-110 transition-transform"
                                ></i>
                            <span class="font-semibold">Footer</span>
                        </a>
                    </nav>
                </div>

                <!-- Avatar + Logout - Dark Mode -->
                <div class="p-6 border-t border-white/10">
                    <div class="relative group">
                        <div
                            class="flex items-center gap-4 cursor-pointer p-3 rounded-xl hover:bg-white/10 transition-all"
                            >
                            <div class="relative">
                                <img
                                    src="https://i.pravatar.cc/100"
                                    class="w-12 h-12 rounded-full border-2 border-gray-600 shadow-lg"
                                    alt="Admin Avatar"
                                    />
                                <div
                                    class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-black"
                                    ></div>
                            </div>
                            <div class="flex-1">
                                <p class="font-bold text-white">Admin</p>
                                <p class="text-xs text-gray-400">admin@sportzone.vn</p>
                            </div>
                            <i
                                class="fas fa-chevron-up text-gray-500 text-sm group-hover:text-gray-300"
                                ></i>
                        </div>
                        <!-- Logout dropdown - Dark Mode -->
                        <div
                            class="absolute bottom-20 left-3 right-3 mb-2 bg-gray-800 rounded-xl shadow-2xl border border-white/20 p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 z-50"
                            >
                            <!-- Profile -->
                            <a
                                href="profile.jsp"
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

            <main class="flex-1 overflow-y-auto p-10 bg-gradient-to-br from-gray-950 via-black to-gray-900">
                <section id="dashboard" class="tab-section p-4 md:p-8 max-w-7xl mx-auto">
                    <!-- Header -->
                    <div class="mb-10 flex justify-between items-center">
                        <div>
                            <h2 class="text-4xl font-black text-white mb-2 font-bebas tracking-wider">
                                Dashboard
                            </h2>
                            <p class="text-gray-400 font-inter text-sm block">An overview of your business</p>
                        </div>

                        <!-- Date Filter Form -->
                        <form action="dashboard" method="post" class="flex gap-3 items-center">
                            <div class="flex gap-2 items-center">
                                <label class="text-sm text-gray-400">From:</label>
                                <input
                                    type="date"
                                    name="startDate"
                                    value="${param.startDate}"
                                    class="bg-gray-900 text-white px-3 py-2 rounded-lg border border-white/10 text-sm focus:outline-none focus:border-white/30"
                                    />
                            </div>
                            <div class="flex gap-2 items-center">
                                <label class="text-sm text-gray-400">To:</label>
                                <input
                                    type="date"
                                    name="endDate"
                                    value="${param.endDate}"
                                    class="bg-gray-900 text-white px-3 py-2 rounded-lg border border-white/10 text-sm focus:outline-none focus:border-white/30"
                                    />
                            </div>
                            <button
                                type="submit"
                                class="bg-white text-black font-bold px-4 py-2 rounded-lg hover:bg-gray-200 transition-all text-sm"
                                >
                                <i class="fas fa-filter mr-2"></i>Apply
                            </button>
                            <a
                                href="dashboard"
                                class="bg-white/10 text-white font-bold px-4 py-2 rounded-lg hover:bg-white/20 transition-all text-sm border border-white/10"
                                >
                                <i class="fas fa-redo mr-2"></i>Reset
                            </a>
                        </form>
                    </div>

                    <!-- Stats Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
                        <!-- Total Orders Card -->
                        <div class="stat-card p-6 rounded-2xl">
                            <div class="flex justify-between items-start mb-4">
                                <div
                                    class="w-14 h-14 bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl flex items-center justify-center shadow-lg shadow-blue-900/50"
                                    >
                                    <i class="fas fa-shopping-bag text-white text-xl"></i>
                                </div>
                            </div>
                            <p
                                class="text-gray-400 uppercase text-xs font-semibold tracking-wider mb-1"
                                >
                                Total Orders
                            </p>
                            <h3 class="text-3xl font-black text-white">
                                ${dashboardStats.totalOrders}
                            </h3>

                            <p class="text-xs text-gray-500 mt-2">Compared to last month</p>
                        </div>

                        <!-- Products Sold Card -->
                        <div class="stat-card p-6 rounded-2xl">
                            <div class="flex justify-between items-start mb-4">
                                <div
                                    class="w-14 h-14 bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl flex items-center justify-center shadow-lg shadow-purple-900/50"
                                    >
                                    <i class="fas fa-box text-white text-xl"></i>
                                </div>
                            </div>
                            <p
                                class="text-gray-400 uppercase text-xs font-semibold tracking-wider mb-1"
                                >
                                Products Sold
                            </p>
                            <h3 class="text-3xl font-black text-white">
                                ${dashboardStats.totalItemsSold}
                            </h3>
                            <p class="text-xs text-gray-500 mt-2">This month</p>
                        </div>

                        <!-- Inventory Card -->
                        <div class="stat-card p-6 rounded-2xl">
                            <div class="flex justify-between items-start mb-4">
                                <div
                                    class="w-14 h-14 bg-gradient-to-br from-amber-500 to-amber-600 rounded-2xl flex items-center justify-center shadow-lg shadow-amber-900/50"
                                    >
                                    <i class="fas fa-warehouse text-white text-xl"></i>
                                </div>
                            </div>
                            <p
                                class="text-gray-400 uppercase text-xs font-semibold tracking-wider mb-1"
                                >
                                Total Inventory
                            </p>
                            <h3 class="text-3xl font-black text-white">
                                ${dashboardStats.totalInventory}
                            </h3>
                            <p class="text-xs text-gray-500 mt-2">Units in stock</p>
                        </div>

                        <!-- Revenue Card -->
                        <div class="stat-card p-6 rounded-2xl">
                            <div class="flex justify-between items-start mb-4">
                                <div
                                    class="w-14 h-14 bg-gradient-to-br from-emerald-500 to-emerald-600 rounded-2xl flex items-center justify-center shadow-lg shadow-emerald-900/50"
                                    >
                                    <i class="fas fa-dollar-sign text-white text-xl"></i>
                                </div>
                            </div>
                            <p
                                class="text-gray-400 uppercase text-xs font-semibold tracking-wider mb-1"
                                >
                                Monthly Revenue
                            </p>
                            <h3 class="text-3xl font-black text-white"> 
                                ${dashboardStats.formattedRevenue}
                            </h3>
                            <p class="text-xs text-gray-500 mt-2">VND this month</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <!-- Orders line chart -->
                        <div class="stat-card p-6 md:p-8 rounded-2xl">
                            <div class="flex items-center justify-between mb-6">
                                <div>
                                    <h3 class="text-xl font-bold text-white">Order Statistics</h3>
                                    <p class="text-sm text-gray-400 mt-1">Last 6 months</p>
                                </div>
                                <div
                                    class="w-10 h-10 bg-[#16181c] rounded-xl flex items-center justify-center border border-[#24262b]"
                                    >
                                    <i class="fas fa-chart-line text-gray-400"></i>
                                </div>
                            </div>
                            <div class="h-72"><canvas id="ordersChart"></canvas></div>
                        </div>

                        <!-- Sales bar chart -->
                        <div class="stat-card p-6 md:p-8 rounded-2xl">
                            <div class="flex items-center justify-between mb-6">
                                <div>
                                    <h3 class="text-xl font-bold text-white">Products Sold</h3>
                                    <p class="text-sm text-gray-400 mt-1">By category</p>
                                </div>
                                <div
                                    class="w-10 h-10 bg-[#16181c] rounded-xl flex items-center justify-center border border-[#24262b]"
                                    >
                                    <i class="fas fa-chart-bar text-gray-400"></i>
                                </div>
                            </div>
                            <div class="h-72"><canvas id="salesChart"></canvas></div>
                        </div>
                    </div>

                    <!-- Pass backend data to JavaScript -->
                    <script>
                        // Data from backend servlet
                        window.dashboardData = {
                        // Chart data for orders over time
                        ordersChart: {
                        labels: (
                        <c:choose>
                            <c:when test="${not empty ordersChartLabels}">
                                ${ordersChartLabels}
                            </c:when>
                            <c:otherwise>
                        ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"]
                            </c:otherwise>
                        </c:choose>
                        ),
                                data: (
                        <c:choose>
                            <c:when test="${not empty ordersChartData}">
                                ${ordersChartData}
                            </c:when>
                            <c:otherwise>[100, 150, 120, 180, 200, 160]</c:otherwise>
                        </c:choose>
                                ),
                        },
                                // Chart data for sales by category
                                salesChart: {
                                labels: (
                        <c:choose>
                            <c:when test="${not empty salesChartLabels}">
                                ${salesChartLabels}
                            </c:when>
                            <c:otherwise>
                                ["Bóng đá", "Tennis", "Basketball", "Fitness"]
                            </c:otherwise>
                        </c:choose>
                                ),
                                        data: (
                        <c:choose>
                            <c:when test="${not empty salesChartData}">
                                ${salesChartData}
                            </c:when>
                            <c:otherwise>[400, 300, 500, 200]</c:otherwise>
                        </c:choose>
                                        ),
                                },
                        };
                    </script>
                </section>
            </main>
        </div>

    </body>
</html>
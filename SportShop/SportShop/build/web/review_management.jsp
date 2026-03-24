<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Reviews Management - Sport Zone Admin</title>
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
                        <p class="text-center text-xs text-gray-400 mt-2 uppercase tracking-wider">Admin Dashboard</p>
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
                    class="fixed top-1/2 -translate-y-1/2 left-72 z-50 w-8 h-14 bg-gray-900 hover:bg-gray-800 rounded-r-2xl border border-l-0 border-white/10 flex items-center justify-center transition-all shadow-lg"
                    onclick="toggleSidebar()">
                <i class="fas fa-chevron-left text-white text-sm"></i>
            </button>

            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto">
                <div class="p-4 md:p-8">
                    <section id="reviews" class="p-4 md:p-8 font-inter">
                        <!-- Header -->
                        <div class="mb-10">
                            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                                <div>
                                    <h2 class="text-4xl font-black text-white mb-2 font-bebas tracking-wider">Review Management</h2>
                                    <p class="text-gray-400">Manage product reviews & approvals</p>
                                </div>
                            </div>
                        </div>

                        <!-- Filter/Search -->
                        <div class="bg-gray-900 rounded-2xl p-6 mb-8 border border-white/10 shadow-lg">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <form action="reviews" method="GET" class="md:col-span-2">
                                    <div class="relative">
                                        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"></i>
                                        <input
                                            type="text"
                                            name="search"
                                            placeholder="Search by user or product..."
                                            class="w-full bg-black text-white pl-12 pr-4 py-3.5 rounded-xl border border-white/10
                                            focus:outline-none focus:ring-2 focus:ring-white focus:border-transparent
                                            transition-all placeholder:text-gray-500"
                                            value="${param.search}"
                                            />
                                    </div>
                                </form>

                                <form action="reviews" method="GET">
                                    <select name="status" class="w-full bg-black text-white px-4 py-3.5 rounded-xl border border-white/10"
                                            onchange="this.form.submit()">
                                        <option value="">All Status</option>
                                        <option value="approved" ${param.status == 'approved' ? 'selected' : ''}>Approved</option>
                                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    </select>
                                </form>
                            </div>
                        </div>

                        <!-- Reviews List -->
                        <div class="bg-gray-900 rounded-2xl border border-white/10 overflow-hidden mb-8">
                            <!-- Table Header -->
                            <div class="grid grid-cols-12 gap-4 px-6 py-4 bg-black/40 border-b border-white/10 text-xs font-bold text-gray-400 uppercase tracking-wider">
                                <div class="col-span-1">ID</div>
                                <div class="col-span-2">User</div>
                                <div class="col-span-2">Product</div>
                                <div class="col-span-3">Comment</div>
                                <div class="col-span-1 text-center">Rating</div>
                                <div class="col-span-1 text-center">Status</div>
                                <div class="col-span-2 text-center">Actions</div>
                            </div>

                            <!-- Table Body -->
                            <div class="divide-y divide-white/5">
                                <c:if test="${empty reviews}">
                                    <div class="text-center py-16">
                                        <i class="fas fa-star text-5xl text-gray-700 mb-3"></i>
                                        <p class="text-gray-400 text-sm">No reviews found</p>
                                    </div>
                                </c:if>

                                <c:forEach var="r" items="${reviews}">
                                    <div class="grid grid-cols-12 items-center gap-4 px-6 py-5 hover:bg-white/5 transition group">
                                        <div class="col-span-1 text-gray-500">${r.reviewId}</div>
                                        <div class="col-span-2 truncate text-white">${r.userFullName}</div>
                                        <div class="col-span-2 truncate text-gray-300">${r.productName}</div>

                                        <div class="col-span-3 text-gray-400 text-sm truncate" title="${r.comment}">
                                            ${r.comment}
                                        </div>

                                        <div class="col-span-1 text-center text-yellow-400 font-semibold">
                                            <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                                            </div>

                                            <div class="col-span-1 flex justify-center">
                                            <c:choose>
                                                <c:when test="${r.approved}">
                                                    <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-green-500/20 text-green-300">Approved</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1.5 rounded-full text-xs font-bold bg-yellow-500/20 text-yellow-300">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="col-span-2 flex items-center justify-center gap-2">
                                            <form action="reviews" method="post">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="id" value="${r.reviewId}">
                                                <button class="w-8 h-8 rounded-lg bg-green-500/10 hover:bg-green-500 text-green-400 hover:text-white transition flex items-center justify-center border border-green-500/20" title="Approve">
                                                    <i class="fas fa-check text-xs"></i>
                                                </button>
                                            </form>
                                            <form action="reviews" method="post">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${r.reviewId}">
                                                <button class="w-8 h-8 rounded-lg bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white transition flex items-center justify-center border border-red-500/20" title="Delete">
                                                    <i class="fas fa-trash text-xs"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                        </div>
                        <div style="margin-bottom: 20px">
                            <jsp:include page="pagination.jsp" />
                        </div>
                        <div class="flex items-center justify-between p-5 bg-gray-900 rounded-xl border border-white/10">
                            <div class="text-sm text-gray-400">
                                Showing <span class="text-white font-bold">${fn:length(reviews)}</span> reviews
                            </div>
                        </div>

                        <!-- Pagination -->

                    </section>
                </div>
            </main>
        </div>
    </body>
</html>
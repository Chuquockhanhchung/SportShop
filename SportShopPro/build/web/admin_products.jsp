<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Products Management - Sport Zone Admin</title>
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
                        <a href="products" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 active-link group">
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
                    class="fixed top-1/2 -translate-y-1/2 left-72 z-50 w-8 h-14 bg-gray-900 hover:bg-gray-800 rounded-r-2xl border border-l-0 border-white/10 flex items-center justify-center transition-all shadow-lg"
                    onclick="toggleSidebar()">
                <i class="fas fa-chevron-left text-white text-sm"></i>
            </button>

            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto">
                <div class="p-4 md:p-8">
                    <section id="products" class="p-4 md:p-8 font-inter">
                        <!-- Header -->
                        <div class="mb-10">
                            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                                <div>
                                    <h2 class="text-4xl font-black text-white mb-2 font-bebas tracking-wider">
                                        Product Management
                                    </h2>
                                    <p class="text-gray-400">A comprehensive list of all sports products in the inventory.</p>
                                </div>

                                <a href="products?action=add" class="bg-white text-black font-bold uppercase px-8 py-4 rounded-xl hover:bg-gray-200 transition-all shadow-lg hover:shadow-xl flex items-center gap-3 group">
                                    <i class="fas fa-plus group-hover:rotate-90 transition-transform duration-300"></i>
                                    <span>Add new Product</span>
                                </a>
                            </div>
                        </div>

                        <!-- Search / Sort Form -->
                        <form action="products" method="GET" class="bg-gray-900 rounded-2xl p-6 mb-8 border border-white/10 shadow-lg">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div class="relative md:col-span-2">
                                    <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"></i>
                                    <input
                                        type="text"
                                        name="search"
                                        placeholder="Search by name or category..."
                                        class="w-full bg-black text-white pl-12 pr-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
                                        value="${param.search}"
                                        onchange="this.form.submit()"
                                        />
                                </div>
                                <select
                                    name="sort"
                                    class="w-full bg-black text-white px-4 py-3.5 rounded-xl border border-white/10 focus:outline-none focus:ring-2 focus:ring-white"
                                    onchange="this.form.submit()"
                                    >
                                    <option value="default" ${empty param.sort or param.sort == 'default' ? 'selected' : ''}>Sort by Default</option>
                                    <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Name A-Z</option>
                                    <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Name Z-A</option>
                                    <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Price: Low to High</option>
                                    <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Price: High to Low</option>
                                </select>
                            </div>
                        </form>

                        <!-- Products Table -->
                        <div class="bg-gray-900 rounded-2xl border border-white/10 overflow-hidden mb-8">
                            <!-- Table Header -->
                            <div class="hidden md:grid grid-cols-12 gap-6 px-6 py-4 bg-black/40 border-b border-white/10">
                                <div class="col-span-4 "><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Products</p></div>
                                <div class="col-span-2"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Category</p></div>
                                <div class="col-span-1"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Colors</p></div>
                                <div class="col-span-2 text-center"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Price</p></div>
                                <div class="col-span-1 text-center"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Stock</p></div>
                                <div class="col-span-2 text-center"><p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Actions</p></div>
                            </div>

                            <!-- Table Body -->
                            <div class="divide-y divide-white/5">
                                <c:if test="${empty productList}">
                                    <div class="text-center py-20">
                                        <div class="w-16 h-16 bg-white/5 rounded-full flex items-center justify-center mx-auto mb-4">
                                            <i class="fas fa-box-open text-3xl text-gray-700"></i>
                                        </div>
                                        <p class="text-gray-400 text-sm font-medium">No products found</p>
                                        <p class="text-gray-500 text-xs mt-1">Add your first product to get started</p>
                                    </div>
                                </c:if>

                                <c:forEach var="p" items="${productList}">
                                    <div class="grid grid-cols-1 md:grid-cols-12 gap-4 md:gap-6 px-6 py-5 hover:bg-white/5 transition-all duration-200 group">

                                        <!-- Product (Image + Name) -->
                                        <div class="md:col-span-4 flex items-center gap-4">
                                            <div class="w-11 h-11 flex-shrink-0 bg-white/5 rounded-lg overflow-hidden border border-white/10 group-hover:border-white/20 transition-all">
                                                <img src="${not empty p.imageUrl ? p.imageUrl : 'https://placehold.co/100x100/1a1a1a/666?text=No+Image'}" 
                                                     alt="${p.productName}" 
                                                     class="w-full h-full object-cover" 
                                                     onerror="this.src='https://placehold.co/100x100/1a1a1a/666?text=No+Image'">
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <h4 class="text-white text-sm truncate group-hover:text-gray-200 transition-colors">${p.productName}</h4>

                                            </div>
                                        </div>

                                        <!-- Category -->
                                        <div class="md:col-span-2 flex items-center"><span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Category:</span><span class="text-gray-400 text-sm">${p.categoryName}</span></div>
                                        <!-- Colors -->
                                        <div class="md:col-span-1 flex items-center"><span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Colors:</span><span class="text-gray-400 text-sm">${not empty p.color ? p.color : '-'}</span></div>
                                        <!-- Price -->
                                        <div class="md:col-span-2 flex items-center md:justify-end"><span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Price:</span><span class="text-white font-bold text-sm"><fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> VND</span></div>
                                        <!-- Stock -->
                                        <div class="md:col-span-1 flex items-center md:justify-center">
                                            <span class="md:hidden text-xs text-gray-400 font-semibold uppercase mr-3 w-20">Stock:</span>
                                            <c:choose>
                                                <c:when test="${p.quantity >= 10}"><span class="px-4 py-2 text-xs font-semibold text-green-300 bg-green-500/10 rounded-full">${p.quantity}</span></c:when>
                                                <c:when test="${p.quantity <= 0}"><span class="px-4 py-2 text-xs font-semibold text-yellow-300 bg-yellow-500/10 rounded-full">${p.quantity}</span></c:when>
                                                <c:otherwise><span class="px-3 py-1 text-xs font-semibold text-red-400 bg-red-500/10 rounded-full">Out</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- Actions -->
                                        <div class="md:col-span-2 flex items-center justify-end md:justify-center gap-2 pt-3 md:pt-0 border-t border-white/5 md:border-none">
                                            <a href="products?action=view&id=${p.productId}" class="w-9 h-9 rounded-lg bg-white/10 hover:bg-white/20 border border-white/10 text-gray-400 hover:text-white transition-all flex items-center justify-center" title="View Details"><i class="fas fa-eye text-xs"></i></a>
                                            <a href="products?action=edit&id=${p.productId}" class="w-9 h-9 rounded-lg bg-white/10 hover:bg-white border border-white/10 text-gray-400 hover:text-black transition-all flex items-center justify-center" title="Edit Product"><i class="fas fa-edit text-xs"></i></a>
                                            <button onclick="openDeleteModal('${p.productId}', '${p.productName}')" class="w-9 h-9 rounded-lg bg-red-500/10 hover:bg-red-500 border border-red-500/20 text-red-400 hover:text-white transition-all flex items-center justify-center" title="Delete Product"><i class="fas fa-trash text-xs"></i></button>
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
                                Showing <span class="text-white font-bold">${productList.size()}</span> of <span class="text-white font-bold">${totalProducts}</span> products
                            </div>
                        </div>

                        <!-- Add/Edit Modal -->
                        <%@ include file="/WEB-INF/admin/products/add_edit.jspf" %>
                        <script>

                            <c:if test='${not empty openModal}'>
                            document.addEventListener('DOMContentLoaded', function () {
                                var modalId = '<c:out value="${openModal}"/>';
                                var el = document.getElementById(modalId);
                                if (el) {
                                    el.classList.remove('hidden');
                                    el.classList.add('flex');
                                }
                            });
                            </c:if>

                            function openDeleteModal(id, name) {
                                document.getElementById('deleteProductId').value = id;
                                document.getElementById('deleteProductName').textContent = name;
                                document.getElementById('deleteModal').classList.remove('hidden');
                                document.getElementById('deleteModal').classList.add('flex');
                            }

                            function closeModal(modalId) {
                                document.getElementById(modalId).classList.add('hidden');
                                document.getElementById(modalId).classList.remove('flex');
                            }
                        </script>

                        <!-- View Modal -->
                        <%@ include file="/WEB-INF/admin/products/view.jspf" %>

                        <!-- Delete Modal -->
                        <%@ include file="/WEB-INF/admin/products/delete.jspf" %>
                    </section>
                </div>
            </main>
        </div>
    </body>
</html>
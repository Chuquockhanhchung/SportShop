<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>All Products</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
        <link rel="stylesheet" href="./css/output.css" />

    </head>
    <body class="bg-black font-inter">
        <%@ include file="header.jsp" %>

        <main class="pb-16 pt-24">
            <section class="px-6 mb-8">
                <div class="max-w-7xl mx-auto">
                    <h1 class="font-bebas text-white text-5xl md:text-6xl font-bold uppercase tracking-wide mb-2">
                        All Products
                    </h1>
                    <p class="text-gray-500 text-sm font-inter">Explore our complete collection</p>
                </div>
            </section>

            <!-- Filter Form -->
            <section class="px-6 mb-8 top-20 z-40">
                <div class="max-w-7xl mx-auto">
                    <form action="product" method="GET" id="filterForm">
                        <div class="bg-black/90 backdrop-blur-md rounded-2xl border border-white/10 shadow-2xl p-4 flex flex-wrap gap-3">
                            <!-- Search -->
                            <div class="flex-1 relative group">
                                <input type="text" id="searchInput" name="search" placeholder="Search products..."
                                       class="w-full bg-transparent text-white px-4 py-3 pl-10 rounded-lg border border-white/10 focus:outline-none focus:border-white/30 transition-all duration-300 placeholder:text-gray-500"
                                       value="${param.search}" />
                                <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-500 text-sm"></i>
                            </div>

                            <!-- Category -->
                            <select name="category" 
                                    class="appearance-none bg-black text-white pl-4 pr-10 py-3 rounded-lg border border-white/10 focus:outline-none focus:border-white/30 transition-all duration-300 cursor-pointer min-w-[180px] text-sm"
                                    onchange="submitWithSearch(this)">
                                <option value="" ${selectedCategory eq '' ? 'selected' : ''}>All Categories</option>

                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryID}" ${selectedCategory eq cat.categoryID.toString() ? 'selected' : ''}>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>

                            <!-- Sort -->
                            <div class="relative z-[9999]">
                                <select id="sortSelect" name="sort"
                                        class="appearance-none bg-black text-white pl-4 pr-10 py-3 rounded-lg border border-white/10 focus:outline-none focus:border-white/30 transition-all duration-300 cursor-pointer min-w-[160px] text-sm"
                                        onchange="submitWithSearch(this)">
                                    <option value="default" ${param.sort == 'default' ? 'selected' : ''}>Default</option>
                                    <option value="trending" ${param.sort == 'trending' ? 'selected' : ''}>Trending</option>
                                    <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Newest</option>
                                    <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Name (A-Z)</option>
                                    <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Name (Z-A)</option>
                                    <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Price ↑</option>
                                    <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Price ↓</option>
                                </select>
                                <i class="fas fa-chevron-down absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 text-xs"></i>
                            </div>

                            <!-- Search button -->
                            <button type="submit"
                                    class="px-4 py-3 rounded-lg bg-gray-700 hover:bg-gray-600 text-white text-sm transition-colors">
                                <i class="fas fa-check"></i>
                            </button>

                            <!-- Reset -->
                            <a href="product?search=&category=&sort=default"
                               class="px-4 py-3 rounded-lg border border-white/10 hover:border-white/30 text-sm text-gray-400 hover:text-white text-center">
                                <i class="fas fa-rotate-left"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </section>

            <!-- Products Grid -->
            <section class="px-6">
                <div class="max-w-7xl mx-auto">
                    <div class="mb-6 flex items-center justify-between">
                        <p class="text-gray-500 text-sm">
                            <span id="resultCount" class="text-white font-semibold">${fn:length(products)}</span> products
                        </p>
                    </div>

                    <c:if test="${not empty products}">
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 mb-8">
                            <c:forEach var="product" items="${products}">
                                <div class="group relative bg-gradient-to-br from-gray-900 to-black rounded-3xl overflow-hidden transition-all duration-500 hover:shadow-2xl hover:shadow-white/10 hover:-translate-y-2 font-inter">
                                    <div class="relative h-80 bg-gradient-to-br from-gray-800 to-gray-900 overflow-hidden">
                                        <img src="${product.imageUrl != null ? product.imageUrl : 'https://placehold.co/100x100/1a1a1a/666?text=No+Image'}"
                                             alt="${product.productName}"
                                             class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                                             onerror="this.src='https://placehold.co/100x100/1a1a1a/666?text=No+Image'"/>
                                        <div class="absolute inset-0 bg-black/60 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center gap-4">
                                            <form action="cart" method="post">
                                                <input type="hidden" name="productId" value="${product.productId}" />
                                                <input type="hidden" name="quantity" value="1" />
                                                <button type="submit" class="w-12 h-12 rounded-full bg-white text-black flex items-center justify-center
                                                        transform translate-y-4 group-hover:translate-y-0 transition-all duration-300
                                                        delay-75 hover:scale-110 cursor-pointer" title="Add to Cart">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </form>
                                            <form action="cart" method="post">
                                                <input type="hidden" name="productId" value="${product.productId}" />
                                                <input type="hidden" name="quantity" value="1" />
                                                <input type="hidden" name="buyNow" value="true" />
                                                <button type="submit" class="w-12 h-12 rounded-full bg-white text-black flex items-center justify-center transform translate-y-4 group-hover:translate-y-0 transition-all duration-300 delay-150 hover:scale-110 cursor-pointer" title="Buy Now">
                                                    <i class="fas fa-bolt"></i>
                                                </button>
                                            </form>
                                            <a href="productdetail?id=${product.productId}" class="w-12 h-12 rounded-full bg-white text-black flex items-center justify-center transform translate-y-4 group-hover:translate-y-0 transition-all duration-300 delay-225 hover:scale-110 cursor-pointer" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="p-6">
                                        <p class="text-gray-400 text-xs font-inter uppercase tracking-widest mb-2">
                                            ${product.categoryName}
                                        </p>
                                        <h3 class="text-white text-2xl font-bebas tracking-wide mb-3 truncate">
                                            ${product.productName}
                                        </h3>
                                        <div class="flex items-center justify-between">
                                            <span class="text-white text-3xl font-bold font-inter">
                                                <fmt:formatNumber value="${product.price}" type="currency" maxFractionDigits="0" currencySymbol="VND"/>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            
                        </div>
                    </c:if>

                    <c:if test="${empty products}">
                        <div id="noResults" class="text-center py-20">
                            <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-white/5 mb-4">
                                <i class="fas fa-box-open text-gray-600 text-3xl"></i>
                            </div>
                            <p class="text-gray-400 text-lg font-medium mb-2">No products found</p>
                            <p class="text-gray-600 text-sm">Try adjusting your filters or search terms</p>
                        </div>
                    </c:if>
                </div>
                        <jsp:include page="pagination.jsp"/>
            </section>
        </main>

        <%@ include file="footer.jsp" %>

        <script>
            function submitWithSearch(selectElement) {
                const form = document.getElementById('filterForm');
                const params = new URLSearchParams(new FormData(form));
                const url = new URL(form.action, window.location.origin);
                url.search = params.toString();
                window.location.href = url.toString();
            }
        </script>

    </body>
</html>

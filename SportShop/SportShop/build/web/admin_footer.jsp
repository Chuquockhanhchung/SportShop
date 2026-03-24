<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <a href="footer" class="nav-link flex items-center px-5 py-4 rounded-xl text-gray-300 hover:bg-white hover:text-black transition-all duration-300 active-link group">
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
            <main class="flex-1 overflow-y-auto">
                <div class="max-w-5xl mx-auto px-6 py-8">
                    <form action="footer" method="post" class="space-y-10">

                        <div class="bg-gray-900 p-6 rounded-2xl border border-white/10 shadow-lg" style="margin: 10px">
                            <h2 class="text-xl font-bold mb-4">Footer Content</h2>
                            <textarea name="description" class="w-full bg-black text-white p-3 rounded-lg border border-white/10" rows="3">${footerSettings.description}</textarea>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                                <input name="address" value="${footerSettings.address}" class="bg-black text-white p-3 rounded-lg border border-white/10" placeholder="Address"/>
                                <input name="phone" value="${footerSettings.phone}" class="bg-black text-white p-3 rounded-lg border border-white/10" placeholder="Phone"/>
                                <input name="email" value="${footerSettings.email}" class="bg-black text-white p-3 rounded-lg border border-white/10" placeholder="Email"/>
                                <input name="hours" value="${footerSettings.hours}" class="bg-black text-white p-3 rounded-lg border border-white/10" placeholder="Working Hours"/>
                            </div>
                            <input name="copyright" value="${footerSettings.copyright}" class="w-full bg-black text-white p-3 rounded-lg border border-white/10 mt-4" placeholder="Copyright"/>
                        </div>

                        <div class="bg-gray-900 p-6 rounded-2xl border border-white/10 shadow-lg" style="margin: 10px">
                            <h2 class="text-xl font-bold mb-4">Social Links</h2>
                            <c:forEach var="l" items="${footerSocialLinks}">
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-3 mb-4">
                                    <input name="socialLabel" value="${l.label}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Label"/>
                                    <input name="socialUrl" value="${l.url}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="URL"/>
                                    <input name="socialIcon" value="${l.icon}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Icon (fab fa-facebook-f)"/>
                                </div>
                            </c:forEach>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
                                <input name="socialLabel" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Label"/>
                                <input name="socialUrl" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="URL"/>
                                <input name="socialIcon" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Icon"/>
                            </div>
                        </div>

                        <div class="bg-gray-900 p-6 rounded-2xl border border-white/10 shadow-lg" style="margin: 10px">
                            <h2 class="text-xl font-bold mb-4">Quick Links</h2>
                            <c:forEach var="l" items="${footerQuickLinks}">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mb-4">
                                    <input name="quickLabel" value="${l.label}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Label"/>
                                    <input name="quickUrl" value="${l.url}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="URL"/>
                                </div>
                            </c:forEach>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                <input name="quickLabel" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Label"/>
                                <input name="quickUrl" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="URL"/>
                            </div>
                        </div>

                        <div class="bg-gray-900 p-6 rounded-2xl border border-white/10 shadow-lg" style="margin: 10px">
                            <h2 class="text-xl font-bold mb-4">Customer Service Links</h2>
                            <c:forEach var="l" items="${footerServiceLinks}">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mb-4">
                                    <input name="serviceLabel" value="${l.label}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Label"/>
                                    <input name="serviceUrl" value="${l.url}" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="URL"/>
                                </div>
                            </c:forEach>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                <input name="serviceLabel" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="Label"/>
                                <input name="serviceUrl" class="bg-black text-white p-2 rounded-lg border border-white/10" placeholder="URL"/>
                            </div>
                        </div>
                        <div class="flex justify-center">
                            <button type="submit" class="px-6 py-3 rounded-lg bg-white text-black font-bold" >Save Footer</button>

                        </div>
                    </form>
                </div>
            </main>
    </body>
</html>
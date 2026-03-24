<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="fixed inset-x-0 top-0 z-50 transition-all duration-300 bg-black">
    <div class="px-8 py-6">
        <nav class="relative flex items-center justify-between">
            <!-- left - Navigation Menu -->
            <div class="flex items-center gap-8">
                <a
                    href="view"
                    class="text-white text-xs font-bold uppercase tracking-[0.2em] transition-all duration-300 hover:tracking-[0.3em]"
                    >Products
                </a>
                <a
                    href="#"
                    class="text-white text-xs font-bold uppercase tracking-[0.2em] transition-all duration-300 hover:tracking-[0.3em]"
                    >About
                </a>
                <a
                    href="#"
                    class="text-white text-xs font-bold uppercase tracking-[0.2em] transition-all duration-300 hover:tracking-[0.3em]"
                    >Contact
                </a>
            </div>
            <!-- center - Logo with artistic style -->
            <div class="absolute left-1/2 -translate-x-1/2 flex items-center gap-3">
                <a
                    href="home"
                    class="text-center font-bebas text-white text-5xl font-black uppercase tracking-[0.15em] transition-all duration-500 hover:tracking-[0.25em]"
                    >
                    SPORT ZONE
                </a>
            </div>
            <!-- right - Icon Actions with modern design -->
            <div class="flex items-center gap-6">
                
                <c:if test="${not empty account and account.role eq 'Admin'}">
                    <a href="dashboard"
                       class="text-white transition-all duration-300 hover:scale-125 cursor-pointer">
                        <i class="fa-solid fa-sliders text-xl"></i>
                    </a>
                </c:if>

                <!-- Wishlist + Cart -->
                <a href="cart"
                   class="text-white transition-all duration-300 hover:scale-125 cursor-pointer">
                    <i class="fas fa-shopping-bag text-xl"></i>
                </a>
                
                <a href="viewoders"
                   class="text-white transition-all duration-300 hover:scale-125 cursor-pointer">
                    <i class="fas fa-receipt text-xl"></i>
                </a>

                <!-- User icon / dropdown -->
                <div class="relative group inline-block">
                    <c:choose>
                        
                        <c:when test="${empty account}">
                            <a href="login"
                               class="text-white transition-all duration-300 hover:scale-125 cursor-pointer p-2">
                                <i class="fa-solid fa-user text-xl"></i>
                            </a>
                        </c:when>

                       
                        <c:otherwise>
                            <a class="text-white transition-all duration-300 hover:scale-125 cursor-pointer p-2">
                                <i class="fa-solid fa-user text-xl"></i>
                            </a>

                            <!-- Dropdown -->
                            <div
                                class="absolute right-0 mt-2 w-40 bg-gray-800 rounded-xl shadow-2xl border border-white/20 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 z-50">
                                <div class="px-5 py-3 border-b border-white/10 text-gray-300 text-sm flex items-center gap-1">
                                    <span class="inline">Hello,</span>
                                    <span class="inline font-semibold text-white">${account.userName}</span>
                                </div>

                                <!-- Profile -->
                                <a href="profile"
                                   class="flex items-center gap-2 px-5 py-3 hover:bg-white/10 rounded-lg text-sm font-medium text-gray-300 hover:text-blue-400 transition">
                                    <i class="fa-solid fa-user"></i>
                                    <span>Profile</span>
                                </a>

                                <!-- Logout -->
                                <a href="logout"
                                   class="flex items-center gap-2 px-5 py-3 hover:bg-white/10 rounded-lg text-sm font-medium text-gray-300 hover:text-red-400 transition">
                                    <i class="fa-solid fa-sign-out-alt"></i>
                                    <span>Logout</span>
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </nav>
    </div>
    <!-- Decorative bottom line -->
    <div
        class="absolute bottom-0 left-0 right-0 h-[1px] bg-gradient-to-r from-transparent via-white/20 to-transparent"
        ></div>
</header>
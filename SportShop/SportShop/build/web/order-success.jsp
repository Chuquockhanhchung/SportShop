<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Order Success - SPORT ZONE</title>

        <!-- Font Awesome -->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
            />

        <!-- Tailwind CSS -->
        <link rel="stylesheet" href="./css/output.css" />
    </head>
    <body class="bg-black font-inter">

        <%@ include file="header.jsp" %>

        <main class="pt-24 pb-20 px-4 py-5 md:px-8 lg:px-12">
            <!-- Success Animation Section -->
            <section class="max-w-4xl mx-auto mb-12 text-center">
                <!-- Success Icon with Animation -->
                <div class="mb-8 flex justify-center">
                    <div class="relative">
                        <!-- Outer Ring Animation -->
                        <div
                            class="absolute inset-0 w-32 h-32 rounded-full bg-green-500/20 animate-ping"
                            ></div>
                        <!-- Main Icon -->
                        <div
                            class="relative w-30 h-30 rounded-full bg-gradient-to-br from-green-500 to-green-600 flex items-center justify-center shadow-2xl shadow-green-500/50 transform hover:scale-110 transition-transform duration-300"
                            >
                            <i class="fas fa-check text-white text-5xl"></i>
                        </div>
                    </div>
                </div>

                <!-- Success Message -->
                <h1
                    class="font-bebas text-white text-6xl md:text-7xl lg:text-9xl font-black uppercase tracking-wide mb-4"
                    >
                    Order Placed!
                </h1>
                <div
                    class="w-24 h-1 bg-green-500 mx-auto mb-6 transform transition-all duration-500 hover:w-32"
                    ></div>
                <p
                    class="text-gray-400 text-lg md:text-xl font-inter max-w-2xl mx-auto mb-3"
                    >
                    Thank you for your order! Your order has been successfully placed and
                    is being processed.
                </p>
               
                <div class="space-y-3">
                        <a
                            href="viewoders" 
                            class="block w-full bg-white text-black font-bebas text-2xl tracking-wider py-5 rounded-xl transition-all duration-300 hover:bg-gray-200 hover:scale-105 hover:shadow-2xl uppercase text-center group"
                            >
                            <i class="fas fa-list mr-2 group-hover:rotate-12 transition-transform"></i>
                            View My Orders
                        </a>
                        <a
                            href="view"
                            class="block w-full bg-white/10 text-white font-bebas text-xl tracking-wider py-4 rounded-xl transition-all duration-300 hover:bg-white/20 border border-white/20 uppercase text-center group"
                            >
                            <i class="fas fa-shopping-cart mr-2 group-hover:scale-110 transition-transform"></i>
                            Continue Shopping
                        </a>
                    </div>
            </section>
        </main>
    </body>
</html>

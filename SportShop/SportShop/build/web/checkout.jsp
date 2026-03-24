<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Checkout - Payment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <link rel="stylesheet" href="./css/output.css"/>
</head>
<body class="bg-black font-inter">
<%@ include file="header.jsp" %>

<main class="px-4 pt-24 pb-20 md:px-8 lg:px-12">

    <div class="max-w-7xl mx-auto py-4">
    <nav class="text-sm text-gray-400">
        <a href="home" class="hover:text-white">Home</a> /
        <a href="cart" class="hover:text-white">Shopping Cart</a> /
        <span class="text-white">Checkout</span>
    </nav>
</div>

    <!-- Error Message -->
    <c:if test="${formSubmitted and not empty error}">
        <div class="max-w-7xl mx-auto mb-8">
            <div class="bg-red-500/20 border border-red-500/30 text-red-400 px-6 py-4 rounded-xl flex items-center gap-3">
                <i class="fas fa-exclamation-circle text-xl"></i>
                <span>${error}</span>
            </div>
        </div>
    </c:if>

    <div class="max-w-7xl mx-auto bg-gradient-to-br from-gray-900 to-black rounded-3xl p-6 md:p-8 border border-white/10 items-center">
        <div class="flex items-center gap-3 mb-6">
            <div class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center">
                <i class="fas fa-truck text-white text-lg"></i>
            </div>
            <h2 class="font-bebas text-white text-4xl uppercase tracking-wide">Delivery Information</h2>
        </div>

        <form action="checkout" method="post" class="space-y-6">
            <input type="hidden" name="action" value="place_order"/>

            <!-- Full Name -->
            <div>
                <label class="text-gray-400 text-sm uppercase tracking-wider mb-2 block font-semibold">Full Name *</label>
                <input type="text" name="fullname" placeholder="Enter your full name"
                       value="${not empty lastFullname ? lastFullname : (user != null ? user.userFullName : '')}"
                       class="w-full bg-white/10 text-white px-4 py-3 rounded-xl border border-white/20"/>
            </div>

            <!-- Phone Number -->
            <div>
                <label class="text-gray-400 text-sm uppercase tracking-wider mb-2 block font-semibold">Phone Number *</label>
                <input type="tel" name="phone" placeholder="Enter your phone number"
                       value="${not empty lastPhone ? lastPhone : (user != null ? user.phoneNumber : '')}"
                       class="w-full bg-white/10 text-white px-4 py-3 rounded-xl border border-white/20"/>
            </div>

            <!-- Delivery Address -->
            <div>
                <label class="text-gray-400 text-sm uppercase tracking-wider mb-2 block font-semibold">Delivery Address *</label>
                <textarea name="address" rows="3" placeholder="Enter your delivery address"
                          class="w-full bg-white/10 text-white px-4 py-3 rounded-xl border border-white/20 resize-none">${not empty lastAddress ? lastAddress : (user != null ? user.address : '')}</textarea>
            </div>

            <!-- Order Notes -->
            <div>
                <label class="text-gray-400 text-sm uppercase tracking-wider mb-2 block font-semibold">Order Notes (Optional)</label>
                <textarea name="note" rows="2" placeholder="Any special instructions for your order"
                          class="w-full bg-white/10 text-white px-4 py-3 rounded-xl border border-white/20 resize-none">${not empty lastNote ? lastNote : ''}</textarea>
            </div>

            <button type="submit"
                    class="w-full bg-white text-black font-bebas text-2xl tracking-wider py-5 rounded-xl transition-all hover:bg-gray-200 uppercase flex items-center justify-center gap-3 mt-8 cursor-pointer">
                <i class="fas fa-check-circle text-xl"></i>
                <span>Place Order</span>
            </button>
        </form>
    </div>
</main>
</body>
</html>

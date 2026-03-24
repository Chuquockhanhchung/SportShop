<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Order Confirmation — SPORT ZONE</title>
        <link rel="stylesheet" href="./css/output.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
        <style>
            :root {
                --bg: #000;
                --panel-start: #071019;
                --panel-end: #0b0f12;
                --accent-green: #00ff7a;
                --card-radius: 28px;
            }
            html, body {

                height:100%;
                margin:0;
                background:var(--bg);
                color:#eaeaea;
            }
            a {
                color: inherit;
            }
            .wrap {
                max-width:1150px;
                margin:28px auto;
                padding:0 28px 60px;
            }
            .breadcrumb {
                color: #bfb5ad;
                margin:12px 0 28px;
                font-size:15px;
            }
            .grid {
                display:grid;
                grid-template-columns:1fr 420px;
                gap:28px;
                align-items:start;
            }
            @media (max-width:980px) {
                .grid {
                    grid-template-columns:1fr;
                }
            }
            .card {
                background: linear-gradient(180deg, var(--panel-start), var(--panel-end));
                border-radius:var(--card-radius);
                padding:36px;
                border:1px solid rgba(255,255,255,0.03);
            }
            .cart-title {
                font-size:40px;
                text-transform:uppercase;
                margin:0 0 18px;
            }
            .summary-title {
                font-size:34px;
                margin:0 0 18px;
                text-transform:uppercase;
            }
            .row {
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:18px 0;
                border-top:1px solid rgba(255,255,255,0.03);
            }
            .shipping .value {
                color: var(--accent-green);
                font-weight:800;
            }
            .total-block {
                margin-top:22px;
                border-top:1px solid rgba(255,255,255,0.03);
                padding-top:26px;
            }
            .total-amount {
                font-size:28px;
                font-weight:800;
            }
            .confirm-btn {
                display:block;
                width:100%;
                margin-top:28px;
                padding:16px 0;
                background: var(--accent-green);
                color:#000;
                border:none;
                border-radius:40px;
                font-weight:900;
                font-size:18px;
                text-transform:uppercase;
                cursor:pointer;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <main class="max-w-7xl mx-auto font-inter px-8 pt-24">
            <div class="max-w-7xl mx-auto py-4">
                <nav class="text-sm text-gray-400">
                    <a href="home" class="hover:text-white">Home</a> /
                    <a href="cart" class="hover:text-white">Shopping Cart</a> /
                    <a href="checkout" class="hover:text-white">Checkout</a> /
                    <span class="text-white">Confirmation</span>
                </nav>
            </div>

            <div class="grid">
                <!-- LEFT: Order & Shipping Info -->
                <section class="card">
                    <div class="cart-title font-bebas">Your Order</div>

                    <c:set var="cart" value="${sessionScope.confirmCart}" />
                    <c:set var="totalAmount" value="${cart.total}" />

                    <c:if test="${not empty cart.items}">
                        <table class="order-table w-full">
                            <thead>
                                <tr class="border-b-2 border-white/20">
                                    <th class="text-left py-3 px-2 text-gray-400 text-xs font-bold uppercase tracking-wider">Product Name</th>
                                    <th class="text-center py-3 px-2 text-gray-400 text-xs font-bold uppercase tracking-wider">Quantity</th>
                                    <th class="text-right py-3 px-2 text-gray-400 text-xs font-bold uppercase tracking-wider">Unit Price</th>
                                    <th class="text-right py-3 px-2 text-gray-400 text-xs font-bold uppercase tracking-wider">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr class="border-b border-white/5 hover:bg-white/5 transition-all">
                                        <td class="py-4 px-2 text-white font-semibold text-base">${item.productName}</td>
                                        <td class="py-4 px-2 text-center">
                                            <span class="inline-block bg-white/10 px-3 py-1.5 rounded-lg text-white font-bold text-sm">
                                                ×${item.quantity}
                                            </span>
                                        </td>
                                        <td class="py-4 px-2 text-right text-gray-300 text-sm font-semibold whitespace-nowrap">
                                            <fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VND
                                        </td>
                                        <td class="py-4 px-2 text-right text-white font-bold text-base whitespace-nowrap">
                                            <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/> VND
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>

                    <c:if test="${empty cart.items}">
                        <div class="empty-center">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <div>Your cart is empty. Let's go shopping!</div>
                            <a class="continue-btn" href="home.jsp">Continue Shopping</a>
                        </div>
                    </c:if>

                    <!-- Delivery Info -->
                    <c:if test="${not empty sessionScope.confirmFullname or not empty param.fullname}">
                        <div class="mt-8 border-t border-white/5 pt-6">
                            <div class="font-bebas text-white my-4 uppercase text-3xl">
                                Current Order Delivery Info
                            </div>
                            <div class="p-5  rounded-xl border border-green-500/20" style="background: rgba(0,255,122,0.05)">
                                <div class="flex flex-col gap-3">
                                    <div class="flex items-start gap-3">
                                        <i class="fas fa-user text-gray-400 text-sm mt-0.5"></i>
                                        <div>
                                            <p class="text-gray-400 text-xs uppercase mb-0.5">Full Name</p>
                                            <p class="text-white text-base font-semibold">
                                                ${not empty sessionScope.confirmFullname ? sessionScope.confirmFullname : param.fullname}
                                            </p>
                                        </div>
                                    </div>
                                    <div class="flex items-start gap-3">
                                        <i class="fas fa-phone text-gray-400 text-sm mt-0.5"></i>
                                        <div>
                                            <p class="text-gray-400 text-xs uppercase mb-0.5">Phone Number</p>
                                            <p class="text-white text-base font-semibold">
                                                ${not empty sessionScope.confirmPhone ? sessionScope.confirmPhone : param.phone}
                                            </p>
                                        </div>
                                    </div>
                                    <div class="flex items-start gap-3">
                                        <i class="fas fa-map-marker-alt text-gray-400 text-sm mt-0.5"></i>
                                        <div class="flex-1">
                                            <p class="text-gray-400 text-xs uppercase mb-0.5">Delivery Address</p>
                                            <p class="text-white text-base font-semibold leading-relaxed">
                                                ${not empty sessionScope.confirmAddres ? sessionScope.confirmAddres : param.address}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </section>

                <!-- RIGHT: Order Summary & Payment -->
                <aside class="card">
                    <div class="summary-title font-bebas">Order Summary</div>

                    <div class="row">
                        <div class="label">Subtotal</div>
                        <div class="value">
                            <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/> VND
                        </div>
                    </div>

                    <div class="row shipping">
                        <div class="label">Shipping</div>
                        <div class="value">Free</div>
                    </div>

                    <form action="confirmation" method="post">
                        <input type="hidden" name="amount" value="${cart.total}" />

                        <!-- Payment Method -->
                        <div>
                            <label
                                class="text-gray-400 text-sm uppercase tracking-wider mb-3 block font-semibold"
                                >
                                Payment Method *
                            </label>
                            <div class="space-y-3">
                                <!-- COD Option -->
                                <label
                                    class="flex items-center gap-4 p-4 bg-white/5 rounded-xl border border-white/10 cursor-pointer hover:bg-white/10 hover:border-white/20 transition-all group"
                                    >
                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        value="cod"
                                        required
                                        class="w-5 h-5 accent-white cursor-pointer"
                                        />
                                    <div class="flex items-center gap-3 flex-1">
                                        <div
                                            class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-white/20 transition-all"
                                            >
                                            <i class="fas fa-money-bill-wave text-white text-sm"></i>
                                        </div>
                                        <div>
                                            <p class="text-white font-semibold">
                                                Cash on Delivery (COD)
                                            </p>
                                            <p class="text-gray-400 text-xs">
                                                Pay when you receive your order
                                            </p>
                                        </div>
                                    </div>
                                </label>

                                <!-- Card Option -->
                                <label
                                    class="flex items-center gap-4 p-4 bg-white/5 rounded-xl border border-white/10 cursor-pointer hover:bg-white/10 hover:border-white/20 transition-all group"
                                    >
                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        value="card"
                                        class="w-5 h-5 accent-white cursor-pointer"
                                        />
                                    <div class="flex items-center gap-3 flex-1">
                                        <div
                                            class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-white/20 transition-all"
                                            >
                                            <i class="fas fa-credit-card text-white text-sm"></i>
                                        </div>
                                        <div>
                                            <p class="text-white font-semibold">Credit/Debit Card</p>
                                            <p class="text-gray-400 text-xs">
                                                Secure online payment (Demo)
                                            </p>
                                        </div>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="total-block">
                            <div class="text-white text-base ">Total</div>
                            <div class="total-amount text-white">
                                <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/> VND
                            </div>
                        </div>

                        <button type="submit" class="confirm-btn">Confirm Payment</button>
                    </form>
                            
                </aside>
            </div>
        </main>
    </body>
</html>

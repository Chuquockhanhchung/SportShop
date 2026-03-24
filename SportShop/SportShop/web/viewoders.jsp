<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Orders - SPORT ZONE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
    <link rel="stylesheet" href="./css/output.css" />
    <style>
        .order-card {
            background: linear-gradient(180deg, #071019, #0b0f12);
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,0.05);
            padding: 28px;
            margin-bottom: 24px;
            transition: all 0.3s ease;
        }
        .order-card:hover {
            border-color: rgba(0,255,122,0.2);
            box-shadow: 0 8px 32px rgba(0,255,122,0.08);
        }
        .status-badge {
            padding: 8px 16px;
            border-radius: 24px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .status-pending { background: rgba(251, 191, 36, 0.15); color: #fbbf24; border: 1px solid rgba(251, 191, 36, 0.3); }
        .status-processing { background: rgba(59, 130, 246, 0.15); color: #3b82f6; border: 1px solid rgba(59, 130, 246, 0.3); }
        .status-shipped { background: rgba(168, 85, 247, 0.15); color: #a855f7; border: 1px solid rgba(168, 85, 247, 0.3); }
        .status-delivered { background: rgba(0, 255, 122, 0.15); color: #00ff7a; border: 1px solid rgba(0, 255, 122, 0.3); }
        .status-cancelled { background: rgba(239, 68, 68, 0.15); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); }

        .info-row {
            display: flex;
            align-items: start;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255,255,255,0.03);
        }
        .info-row:last-child { border-bottom: none; }
        .info-icon {
            color: #00ff7a;
            font-size: 14px;
            margin-top: 2px;
            min-width: 20px;
        }
        .info-label {
            color: #bfb5ad;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        .info-value {
            color: #fff;
            font-size: 15px;
            font-weight: 600;
        }

        .product-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid rgba(255,255,255,0.03);
        }
        .product-item:last-child { border-bottom: none; }
    </style>
</head>
<body class="bg-black font-inter">
<%@ include file="header.jsp" %>

<main class="max-w-7xl mx-auto px-6 py-10 pt-24">
    <section class="mb-10">
        <h1 class="font-bebas text-white text-5xl md:text-6xl font-bold uppercase tracking-wide mb-2">My Orders</h1>
        <p class="text-gray-400 text-lg font-inter mb-6">View and track all your orders with detailed information</p>
    </section>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="bg-gradient-to-br from-gray-900 to-black p-16 rounded-3xl border border-gray-800 shadow-2xl text-center">
                <i class="fas fa-box-open text-7xl text-gray-700 mb-6"></i>
                <p class="text-gray-400 text-2xl font-semibold mb-4">You have not placed any orders yet</p>
                <a href="allproducts" class="inline-block mt-4 px-8 py-3 bg-gradient-to-r from-green-500 to-green-600 text-white font-bold rounded-xl hover:from-green-600 hover:to-green-700 transition-all">
                    <i class="fas fa-shopping-bag mr-2"></i> Start Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <!-- Order Header -->
                    <div class="flex flex-wrap justify-between items-start mb-6 pb-6 border-b border-white/5">
                        <div>
                            <h2 class="text-white font-bebas text-3xl mb-2">Order #${order.orderId}</h2>
                            <div class="flex items-center gap-4 text-gray-400 text-sm">
                                <span><i class="fas fa-calendar-alt mr-2"></i><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                <span><i class="fas fa-boxes mr-2"></i>${fn:length(order.items)} items</span>
                            </div>
                        </div>
                        <div class="text-right flex flex-col items-end gap-3">
                            <c:choose>
                                <c:when test='${order.status eq "Pending"}'>
                                    <span class="status-badge status-pending"><i class="fas fa-clock"></i> Pending</span>
                                </c:when>
                                <c:when test='${order.status eq "Processing"}'>
                                    <span class="status-badge status-processing"><i class="fas fa-cog fa-spin"></i> Processing</span>
                                </c:when>
                                <c:when test='${order.status eq "Shipped"}'>
                                    <span class="status-badge status-shipped"><i class="fas fa-shipping-fast"></i> Shipped</span>
                                </c:when>
                                <c:when test='${order.status eq "Delivered"}'>
                                    <span class="status-badge status-delivered"><i class="fas fa-check-circle"></i> Delivered</span>
                                </c:when>
                                <c:when test='${order.status eq "Cancelled"}'>
                                    <span class="status-badge status-cancelled"><i class="fas fa-times-circle"></i> Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge" style="background: rgba(156, 163, 175, 0.15); color: #9ca3af; border: 1px solid rgba(156, 163, 175, 0.3);">
                                        <i class="fas fa-question-circle"></i> ${order.status}
                                    </span>
                                </c:otherwise>
                            </c:choose>

                            <!-- Cancel button: only when Pending/Processing -->
                            <c:if test='${order.status eq "Pending" or order.status eq "Processing"}'>
                                <form action="cancel-order" method="post" onsubmit="return confirm('Bạn chắc chắn muốn huỷ đơn hàng này?');">
                                    <input type="hidden" name="orderId" value="${order.orderId}"/>
                                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-full hover:bg-red-700 text-sm font-semibold">
                                        <i class="fas fa-times-circle mr-2"></i> Huỷ đơn hàng
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                        <!-- Left Column: Shipping & Tracking Info -->
                        <div>
                            <h3 class="text-white font-bebas text-xl mb-4 flex items-center gap-2">
                                <i class="fas fa-truck text-green-500"></i> Delivery Information
                            </h3>
                            <div class="bg-white/5 rounded-2xl p-5 border border-white/5">
                                <div class="info-row">
                                    <i class="fas fa-map-marker-alt info-icon"></i>
                                    <div class="flex-1">
                                        <div class="info-label">Shipping Address</div>
                                        <div class="info-value">${order.address}</div>
                                    </div>
                                </div>

                                <c:if test="${not empty order.trackingNumber}">
                                    <div class="info-row">
                                        <i class="fas fa-barcode info-icon"></i>
                                        <div class="flex-1">
                                            <div class="info-label">Tracking Number</div>
                                            <div class="info-value font-mono">${order.trackingNumber}</div>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${not empty account}">
                                    <div class="info-row">
                                        <i class="fas fa-user info-icon"></i>
                                        <div class="flex-1">
                                            <div class="info-label">Customer Name</div>
                                            <div class="info-value">${account.userFullName}</div>
                                        </div>
                                    </div>

                                    <c:if test="${not empty account.phoneNumber}">
                                        <div class="info-row">
                                            <i class="fas fa-phone info-icon"></i>
                                            <div class="flex-1">
                                                <div class="info-label">Contact Number</div>
                                                <div class="info-value">${account.phoneNumber}</div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty account.email}">
                                        <div class="info-row">
                                            <i class="fas fa-envelope info-icon"></i>
                                            <div class="flex-1">
                                                <div class="info-label">Email</div>
                                                <div class="info-value">${account.email}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>

                        <!-- Right Column: Order Items -->
                        <div>
                            <h3 class="text-white font-bebas text-xl mb-4 flex items-center gap-2">
                                <i class="fas fa-shopping-bag text-green-500"></i> Order Items
                            </h3>
                            <div class="bg-white/5 rounded-2xl p-5 border border-white/5">
                                <!-- Table Header -->
                                <div class="grid grid-cols-12 gap-3 pb-3 mb-3 border-b border-white/10">
                                    <div class="col-span-6 text-gray-400 text-xs font-bold uppercase tracking-wider">Product Name</div>
                                    <div class="col-span-2 text-gray-400 text-xs font-bold uppercase tracking-wider text-center">Quantity</div>
                                    <div class="col-span-4 text-gray-400 text-xs font-bold uppercase tracking-wider text-right">Price</div>
                                </div>

                                <!-- Product Items -->
                                <c:forEach var="item" items="${order.items}">
                                    <div class="grid grid-cols-12 gap-3 py-3 border-b border-white/5 last:border-b-0">
                                        <div class="col-span-6">
                                            <div class="text-white font-semibold text-sm leading-tight">${item.productName}</div>
                                        </div>
                                        <div class="col-span-2 flex items-center justify-center">
                                            <span class=" text-white font-bold text-base">×${item.quantity}</span>
                                        </div>
                                        <div class="col-span-4 flex items-center justify-end">
                                            <div class="text-white font-bold text-base">
                                                <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" maxFractionDigits="0" currencySymbol="VND"/>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Order Total -->
                                <div class="mt-5 pt-5 border-t-2 border-white/20">
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-400 text-base font-bold uppercase tracking-wider">Total Amount</span>
                                        <span class="text-white text-2xl font-bold">
                                            <fmt:formatNumber value="${order.total}" type="currency" maxFractionDigits="0" currencySymbol="VND"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <jsp:include page="pagination.jsp"/>
</main>

</body>
</html>
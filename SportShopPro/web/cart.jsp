<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Shopping Cart - SPORT ZONE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <link rel="stylesheet" href="./css/output.css"/>
</head>
<body class="bg-black font-inter px-4 pt-24">
<%@ include file="header.jsp" %>

<div class="max-w-7xl mx-auto">
    <nav class="text-sm text-gray-400">
        <a href="home" class="hover:text-white">Home</a> /
        <span class="text-white">Shopping Cart</span>
    </nav>
</div>

<main class="max-w-7xl mx-auto px-8 mb-20 py-6">
    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="py-20 text-center text-gray-400 font-bebas">
                <i class="fas fa-shopping-cart text-4xl mb-6"></i>
                <p class="text-2xl">Your cart is empty</p>
                <a href="view" class="inline-block px-8 py-2 bg-white text-black rounded-full mt-6 text-2xl">
                    Continue Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-1 gap-8">
                <section class="bg-gradient-to-br from-gray-900 to-black p-8 rounded-3xl border border-gray-800">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="font-bebas text-white text-4xl uppercase tracking-wide">Your Cart</h2>
                        <form action="delete" method="post">
                            <input type="hidden" name="clearAll" value="true"/>
                            <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-full hover:bg-red-700 cursor-pointer">Clear All</button>
                        </form>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="text-gray-400 uppercase text-xs ">
                                    <th>Products</th><th>Price</th><th>Quantity</th><th>Total</th><th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}" varStatus="status">
                                    <tr class="border-b border-gray-800">
                                        <td class="py-6 flex items-center gap-4">
                                            <img src="${not empty item.imageUrl ? item.imageUrl : 'https://placehold.co/100x100/1a1a1a/666?text=No+Image'}"
                                                 alt="${item.productName}" class="w-12 h-12 object-cover rounded-lg"/>
                                            <div class="text-white font-bebas text-xl">${item.productName}</div>
                                        </td>
                                        <td class="py-6 text-white font-bebas text-xl">
                                            <span class="unit-price" data-value="${item.unitPrice}">
                                                <fmt:formatNumber value="${item.unitPrice}" minFractionDigits="0"/>
                                            </span> VND
                                        </td>
                                        <td class="py-6">
                                            <form action="cart" method="post" class="flex flex-col gap-1 items-start">
                                                <div class="flex gap-2 items-center">
                                                    <input type="hidden" name="action" value="update"/>
                                                    <input type="hidden" name="productId" value="${item.productId}"/>
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1"
                                                           max="${stockMap[item.productId]}"
                                                           data-stock="${stockMap[item.productId]}"
                                                           class="qty-input w-16 text-center px-2 py-1 bg-black text-white border border-gray-700 rounded-lg"/>
                                                    <button type="submit" class="px-3 py-1 bg-blue-600 text-white rounded-lg hover:bg-blue-700 cursor-pointer text-sm">
                                                        <i class="fas fa-sync-alt"></i>
                                                    </button>
                                                </div>
                                                <span class="stock-remaining text-gray-400 text-xs">
                                                    Còn ${stockMap[item.productId]} sản phẩm
                                                </span>
                                                <span class="stock-warning text-red-500 text-xs hidden">
                                                    Số lượng vượt quá tồn kho
                                                </span>
                                            </form>
                                        </td>
                                        <td class="py-6 text-white font-bebas text-xl">
                                            <span class="row-total" data-value="${item.unitPrice * item.quantity}">
                                                <fmt:formatNumber value="${item.unitPrice * item.quantity}" minFractionDigits="0"/>
                                            </span> VND
                                        </td>
                                        <td class="py-6">
                                            <form action="delete" method="post">
                                                <input type="hidden" name="productId" value="${item.productId}"/>
                                                <button type="submit" class="w-10 h-10 bg-red-600 text-white rounded-full hover:bg-red-700 cursor-pointer">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </section>

                <aside class="bg-gradient-to-br from-gray-900 to-black p-8 rounded-3xl border border-gray-800 lg:sticky lg:top-32 font-bebas">
                    <h3 class=" text-white text-3xl uppercase mb-6">Order Summary</h3>
                    <div class="flex justify-between py-3 text-gray-300 ">
                        <span>Subtotal</span>
                        <span class=" text-white text-xl">
                            <span id="subtotal" data-value="${cart.total}">
                                <fmt:formatNumber value="${cart.total}" minFractionDigits="0"/>
                            </span> VND
                        </span>
                    </div>
                    <div class="flex justify-between py-3 text-gray-300">
                        <span>Shipping Fee</span>
                        <span class="font-semibold text-green-400 text-xl">Free</span>
                    </div>
                    <div class="border-t-2 border-gray-700 pt-6 flex justify-between">
                        <span class="font-bebas text-white text-4xl uppercase">Total</span>
                        <span class="font-bebas font-bold text-white text-2xl">
                            <span id="grandTotal" data-value="${cart.total}">
                                <fmt:formatNumber value="${cart.total}" minFractionDigits="0"/>
                            </span> VND
                        </span>
                    </div>
                    <form action="checkout" method="post">
                        <div class="py-4 space-y-3">
                            <button type="submit" class="w-full py-4 bg-white text-black font-bebas text-3xl uppercase rounded-xl cursor-pointer">
                                Checkout
                            </button>
                            
                            <a
                                href="view"
                                class="block w-full bg-white/10 text-white font-bebas text-xl tracking-wider py-4 rounded-xl transition-all duration-300 hover:bg-white/20 border border-white/20 uppercase text-center group"
                                >
                                <i class="fas fa-shopping-cart mr-2 group-hover:scale-110 transition-transform"></i>
                                Continue Shopping
                            </a>
                        </div>
                    </form>

                </aside>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<script>
    const formatVND = (value) => {
        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    };

    const recalcTotals = () => {
        let subtotal = 0;

        document.querySelectorAll("tbody tr").forEach((row) => {
            const unitPriceEl = row.querySelector(".unit-price");
            const qtyInput = row.querySelector(".qty-input");
            const rowTotalEl = row.querySelector(".row-total");
            const warningEl = row.querySelector(".stock-warning");

            if (!unitPriceEl || !qtyInput || !rowTotalEl) return;

            const unitPrice = parseFloat(unitPriceEl.dataset.value || "0");
            const stock = parseInt(qtyInput.dataset.stock || "0", 10);

            let qty = parseInt(qtyInput.value || "1", 10);
            if (qty < 1) qty = 1;

            let overStock = false;
            if (stock > 0 && qty > stock) {
                qty = stock;
                overStock = true;
            }

            qtyInput.value = qty;

            if (warningEl) {
                warningEl.classList.toggle("hidden", !overStock);
            }

            const rowTotal = unitPrice * qty;

            rowTotalEl.dataset.value = rowTotal;
            rowTotalEl.textContent = formatVND(Math.round(rowTotal));
            subtotal += rowTotal;
        });

        const subtotalEl = document.getElementById("subtotal");
        const grandTotalEl = document.getElementById("grandTotal");
        if (subtotalEl) {
            subtotalEl.dataset.value = subtotal;
            subtotalEl.textContent = formatVND(Math.round(subtotal));
        }
        if (grandTotalEl) {
            grandTotalEl.dataset.value = subtotal;
            grandTotalEl.textContent = formatVND(Math.round(subtotal));
        }
    };

    document.addEventListener("input", (e) => {
        if (e.target && e.target.classList.contains("qty-input")) {
            recalcTotals();
        }
    });

    // Tự động submit khi đổi số lượng (change)
    document.addEventListener("change", (e) => {
        if (e.target && e.target.classList.contains("qty-input")) {
            recalcTotals();
            const form = e.target.closest("form");
            if (form) form.submit();
        }
    });

    recalcTotals();
</script>
</body>
</html>
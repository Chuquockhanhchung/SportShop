<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
         prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${product.productName}</title>

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

        <main class="pb-15 pt-24">
            <section class="w-full px-4 py-5 md:px-8 lg:px-12">
                <div
                    class="max-w-[1920px] mx-auto grid grid-cols-1 lg:grid-cols-2 gap-8"
                    >
                    <!-- LEFT: Product Gallery + Description -->
                    <div class="space-y-6 flex flex-col">
                        <!-- Main Image -->
                        <div
                            class="relative bg-gradient-to-br from-gray-900 to-black rounded-3xl overflow-hidden border border-white/10 shadow-2xl group"
                            >
                            <img
                                id="mainImg"
                                src="${product.imageUrl}"
                                alt="${product.productName}"
                                class="w-full h-full object-cover rounded-2xl transition-transform duration-700 hover:scale-105"
                                />
                        </div>

                        <!-- Product Description -->
                        <div
                            class="bg-gradient-to-br from-gray-900 to-black rounded-2xl p-6 md:p-8 border border-white/10"
                            >
                            <div class="flex items-center gap-3 mb-6">
                                <div
                                    class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center"
                                    >
                                    <i class="fas fa-file-lines text-white text-lg"></i>
                                </div>
                                <h3
                                    class="font-bebas text-white text-4xl uppercase tracking-wide"
                                    >
                                    Product Description
                                </h3>
                            </div>
                            <p class="text-gray-400 leading-relaxed text-base mb-8">
                                ${product.description}
                            </p>

                            <!-- Policy Icons -->
                            <div
                                class="pt-6 border-t border-white/10 grid grid-cols-2 md:grid-cols-4 gap-4"
                                >
                                <div class="text-center">
                                    <div
                                        class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center mx-auto mb-2"
                                        >
                                        <i class="fas fa-truck-fast text-white"></i>
                                    </div>
                                    <p class="text-gray-400 text-xs uppercase tracking-wide">
                                        Free Shipping
                                    </p>
                                </div>
                                <div class="text-center">
                                    <div
                                        class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center mx-auto mb-2"
                                        >
                                        <i class="fas fa-shield-halved text-white"></i>
                                    </div>
                                    <p class="text-gray-400 text-xs uppercase tracking-wide">
                                        Secure Payment
                                    </p>
                                </div>
                                <div class="text-center">
                                    <div
                                        class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center mx-auto mb-2"
                                        >
                                        <i class="fas fa-rotate-left text-white"></i>
                                    </div>
                                    <p class="text-gray-400 text-xs uppercase tracking-wide">
                                        Easy Returns
                                    </p>
                                </div>
                                <div class="text-center">
                                    <div
                                        class="w-12 h-12 rounded-full bg-white/10 flex items-center justify-center mx-auto mb-2"
                                        >
                                        <i class="fas fa-certificate text-white"></i>
                                    </div>
                                    <p class="text-gray-400 text-xs uppercase tracking-wide">
                                        Authentic
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT: Sidebar -->
                    <aside class="flex flex-col">
                        <div
                            class="bg-gradient-to-br from-gray-900 to-black rounded-2xl p-6 border border-white/10 flex-1 flex flex-col"
                            >
                            <h2
                                class="font-bebas text-white text-4xl uppercase tracking-wide mb-4 leading-tight"
                                >
                                ${product.productName}
                            </h2>

                            <!-- Price -->
                            <div class="mb-6 pb-6">
                                <div class="flex items-baseline gap-2">
                                    <span class="text-white text-5xl font-black font-inter">
                                        <fmt:formatNumber
                                            value="${product.price}"
                                            type="number"
                                            groupingUsed="true"
                                            />
                                    </span>
                                    <span class="text-gray-400 text-xl font-semibold">VND</span>
                                </div>
                            </div>

                            <!-- Status -->
                            <div class="mb-6 pb-6">
                                <div class="flex items-center justify-between">
                                    <span
                                        class="text-gray-400 text-sm uppercase tracking-wider font-semibold"
                                        >Status</span
                                    >
                                    <c:choose>
                                        <c:when test="${product.quantity > 0}">
                                            <span
                                                class="px-4 py-2 rounded-lg bg-green-500/20 text-green-400 text-sm font-bold uppercase tracking-wide border border-green-500/30"
                                                >
                                                <i class="fas fa-check-circle mr-1"></i> In Stock
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span
                                                class="px-4 py-2 rounded-lg bg-red-500/20 text-red-400 text-sm font-bold uppercase tracking-wide border border-red-500/30"
                                                >
                                                <i class="fas fa-times-circle mr-1"></i> Out of Stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Color -->
                            <div class="mb-6 pb-6">
                                <label
                                    class="text-gray-400 text-sm uppercase tracking-wider mb-3 block font-semibold"
                                    >Color</label
                                >
                                <div class="flex gap-3">
                                    <button
                                        class="w-12 h-12 md:w-14 md:h-14 rounded-full border border-gray-600 hover:border-white transition-all duration-300 hover:scale-110 relative group"
                                        style="background: ${product.color}"
                                        title="${product.color}"
                                        >
                                        <div
                                            class="absolute -bottom-8 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity bg-black/80 px-3 py-1 rounded text-xs text-white whitespace-nowrap"
                                            >
                                            ${product.color}
                                        </div>
                                    </button>
                                </div>
                            </div>

                            <!-- Size (optional) -->
                            <c:if test="${not empty product.size}">
                                <div class="mb-6 pb-6">
                                    <label
                                        class="text-gray-400 text-sm uppercase tracking-wider mb-3 block font-semibold"
                                        >Size</label
                                    >
                                    <div class="flex gap-3">
                                        <button
                                            class="px-5 md:px-6 py-3 rounded-xl bg-white text-black hover:bg-gray-200 border border-white transition-all duration-300 font-bold hover:scale-105"
                                            >
                                            ${product.size}
                                        </button>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Available -->
                            <div class="mb-6 pb-6">
                                <div class="flex items-center justify-between">
                                    <span
                                        class="text-gray-400 text-sm uppercase tracking-wider font-semibold"
                                        >Available</span
                                    >
                                    <span class="text-white font-bold text-lg">
                                        ${product.quantity}
                                    </span>
                                </div>
                            </div>

                            <!-- Quantity -->
                            <div class="mb-6">
                                <label
                                    class="text-gray-400 text-sm uppercase tracking-wider mb-3 block font-semibold"
                                    >Quantity</label
                                >
                                <div
                                    class="inline-flex items-center bg-white/10 rounded-xl border border-white/20 overflow-hidden w-full"
                                    >
                                    <button
                                        id="decBtn"
                                        class="flex-1 px-6 py-4 text-white hover:bg-white/20 transition-colors font-bold text-xl"
                                        >
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <input
                                        id="qtyInput"
                                        type="text"
                                        value="1"
                                        class="flex-1 text-center bg-transparent text-white font-bold text-2xl border-x border-white/20 py-4 focus:outline-none"
                                        />
                                    <button
                                        id="incBtn"
                                        class="flex-1 px-6 py-4 text-white hover:bg-white/20 transition-colors font-bold text-xl"
                                        >
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="flex gap-3 mt-auto pt-6">
                                <!-- Nút Mua Ngay (Buy Now) -->
                                <form
                                    action="cart"
                                    method="post"
                                    class="flex-1"
                                    >
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="productId" value="${product.productId}" />
                                    <input type="hidden" name="quantity" id="qtyBuyNow" value="1" />
                                    <input type="hidden" name="buyNow" value="true" />

                                    <button
                                        type="submit"
                                        class="w-full h-14 rounded-xl bg-white text-black font-bebas text-xl tracking-wider
                                        transition-all duration-300 hover:bg-gray-200 hover:scale-105 hover:shadow-2xl uppercase cursor-pointer
                                        flex items-center justify-center gap-2 group"
                                        >
                                        <i class="fas fa-bolt group-hover:scale-110 transition-transform"></i>
                                        <span>Buy Now</span>
                                    </button>
                                </form>

                                <!-- Nút Add to Cart -->
                                <form
                                    action="cart"
                                    method="post"
                                    class="flex-1"
                                    >
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="productId" value="${product.productId}" />
                                    <input type="hidden" name="quantity" id="qtyInputField" value="1" />

                                    <button
                                        type="submit"
                                        class="w-full h-14 rounded-xl bg-white text-black transition-all duration-300
                                        hover:bg-gray-200 hover:scale-105 hover:shadow-2xl flex items-center justify-center group cursor-pointer"
                                        title="Add to Cart"
                                        >
                                        <i
                                            class="fas fa-shopping-cart text-lg group-hover:rotate-12 transition-transform"
                                            ></i>
                                    </button>
                                </form>
                            </div>

                        </div>
                    </aside>
                </div>
            </section>
            <!-- Reviews Section -->
            <section class="w-full px-4 py-10 md:px-8 lg:px-12">
                <div class="max-w-[1920px] mx-auto space-y-8">
                    <h3 class="text-white text-3xl font-bebas tracking-wide">Reviews</h3>

                    <!-- Review Form -->
                    <c:if test="${not empty account}">
                        <form action="review" method="post"
                              class="bg-gray-900 p-6 rounded-2xl border border-white/10 space-y-4">
                            <input type="hidden" name="productId" value="${product.productId}" />

                            <div class="flex items-center gap-3">
                                <label class="text-gray-400 text-sm">Your Rating</label>
                                <select name="rating"
                                        class="bg-black text-white px-4 py-2 rounded-lg border border-white/10">
                                    <option value="5">★★★★★</option>
                                    <option value="4">★★★★</option>
                                    <option value="3">★★★</option>
                                    <option value="2">★★</option>
                                    <option value="1">★</option>
                                </select>
                            </div>

                            <textarea name="comment" rows="3"
                                      class="w-full bg-black text-white p-3 rounded-lg border border-white/10"
                                      placeholder="Write your review..."></textarea>

                            <button type="submit"
                                    class="px-6 py-3 rounded-lg bg-white text-black font-bold">
                                Submit Review
                            </button>
                        </form>
                    </c:if>

                    <!-- Review List -->
                    <div class="space-y-5">
                        <c:forEach var="r" items="${reviews}">
                            <div class="bg-gray-900 p-5 rounded-2xl border border-white/10 shadow-lg" style="margin: 10px">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <img src="${r.userAvatar}" class="w-10 h-10 rounded-full border border-white/10" />
                                        <div>
                                            <p class="text-white font-semibold">${r.userFullName}</p>
                                            <p class="text-gray-400 text-xs">
                                                <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy"/>
                                            </p>
                                        </div>
                                    </div>
                                    <p class="text-yellow-400 text-sm font-semibold tracking-wide">
                                        <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                                        </p>
                                    </div>

                                    <p class="text-gray-300 mt-3 leading-relaxed">${r.comment}</p>
                            </div>
                        </c:forEach>
                    </div>
                    <div style="margin-bottom: 20px">
                            <jsp:include page="pagination.jsp" />
                        </div>
                </div>
            </section>
        </main>

        <%@ include file="footer.jsp" %>

        <script>
            // Điều chỉnh số lượng
            var dec = document.getElementById("decBtn");
            var inc = document.getElementById("incBtn");
            var qty = document.getElementById("qtyInput");
            var qtyHidden = document.getElementById("qtyInputField");
            var qtyBuyNow = document.getElementById("qtyBuyNow");

            dec &&
                    dec.addEventListener("click", function () {
                        var v = parseInt(qty.value || "1");
                        if (v > 1)
                            qty.value = v - 1;
                        qtyHidden.value = qty.value;
                        qtyBuyNow.value = qty.value;
                    });

            inc &&
                    inc.addEventListener("click", function () {
                        var v = parseInt(qty.value || "1");
                        qty.value = v + 1;
                        qtyHidden.value = qty.value;
                        qtyBuyNow.value = qty.value;
                    });

            qty &&
                    qty.addEventListener("input", function () {
                        this.value = this.value.replace(/[^0-9]/g, "") || "1";
                        qtyHidden.value = this.value;
                        qtyBuyNow.value = this.value;
                    });
        </script>
    </body>
</html>

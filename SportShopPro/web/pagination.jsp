<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${totalPages > 1}">
    <div class="flex items-center justify-center gap-2 mt-8">

        <!-- Prev -->
        <c:choose>
            <c:when test="${currentPage > 1}">
                <a href="${baseUrl}&page=${currentPage - 1}"
                   class="px-3 py-2 rounded-lg bg-white/10 text-white hover:bg-white/20">Prev</a>
            </c:when>
            <c:otherwise>
                <span class="px-3 py-2 rounded-lg bg-white/5 text-gray-500 cursor-not-allowed">Prev</span>
            </c:otherwise>
        </c:choose>

        <!-- Page numbers -->
        <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="px-3 py-2 rounded-lg bg-white text-black font-bold">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="${baseUrl}&page=${i}"
                       class="px-3 py-2 rounded-lg bg-white/10 text-white hover:bg-white/20">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- Next -->
        <c:choose>
            <c:when test="${currentPage < totalPages}">
                <a href="${baseUrl}&page=${currentPage + 1}"
                   class="px-3 py-2 rounded-lg bg-white/10 text-white hover:bg-white/20">Next</a>
            </c:when>
            <c:otherwise>
                <span class="px-3 py-2 rounded-lg bg-white/5 text-gray-500 cursor-not-allowed">Next</span>
            </c:otherwise>
        </c:choose>

    </div>
</c:if>
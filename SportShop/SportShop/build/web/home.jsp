<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>SPORTZONE</title>
        <!-- Model Viewer -->
        <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.4.0/model-viewer.min.js"></script>
        <!-- font-awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
        <!-- swiper -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css" />
        <!-- tailwind css -->
        <link rel="stylesheet" href="./css/output.css" />

    </head>
    <body class="bg-black font-inter">

        <!-- Header -->
        <%@ include file="header.jsp" %>

        <main>
            <!-- Hero Section -->
            <jsp:include page="/WEB-INF/lp/hero.jspf" />
            
            <!-- New Products Section -->
            <%@ include file="/WEB-INF/lp/newproducts.jspf" %>

            <!-- Policy Section -->
            <jsp:include page="/WEB-INF/lp/policy.jspf" />

            <!-- Products Trending Showcase -->
            <%@ include file="/WEB-INF/lp/trending.jspf" %>
            
            <!-- Newsletter Section -->
            <jsp:include page="/WEB-INF/lp/newletter.jspf" />
        </main>

        <!-- Footer -->
        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
        <script src="./js/main.js"></script>
    </body>
</html>

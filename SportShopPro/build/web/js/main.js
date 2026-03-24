document.addEventListener("DOMContentLoaded", function () {
    
    // hero section
    const heroSwiper = new Swiper(".hero-swiper", {
        direction: "horizontal",
        loop: true,
        speed: 2000,
        effect: "fade",
        fadeEffect: {
            crossFade: true,
        },
        autoplay: {
            delay: 5000,
            disableOnInteraction: true,
        },

        pagination: {
            el: ".swiper-pagination",
            clickable: true,
            renderBullet: function (index, className) {
                return (
                        '<span class="' +
                        className +
                        ' !w-3 !h-3 !bg-white/50 hover:!bg-white !transition-all !duration-300"></span>'
                        );
            },
        },

        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },

        keyboard: {
            enabled: true,
            onlyInViewport: false,
        },
    });


    // products
    const productsSwiper = new Swiper(".products-swiper", {
        slidesPerView: 1,
        spaceBetween: 30,
        loop: true,
        speed: 800,
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
            pauseOnMouseEnter: true,
        },
        grabCursor: true,

        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },

        pagination: {
            el: ".swiper-pagination",
            clickable: true,
            dynamicBullets: true,
        },
        
        // And if we need scrollbar
        scrollbar: {
            el: ".swiper-scrollbar",
            draggable: true,
        },
        // Responsive breakpoints
        breakpoints: {
            // Mobile
            480: {
                slidesPerView: 1.5,
                spaceBetween: 20,
            },
            // Tablet
            768: {
                slidesPerView: 2,
                spaceBetween: 24,
            },
            // Desktop
            1024: {
                slidesPerView: 3,
                spaceBetween: 30,
            },
            // Large Desktop
            1280: {
                slidesPerView: 4,
                spaceBetween: 30,
            },
        },
    });


    // policy
    const policyShowcaseSwiper = new Swiper(".policy-showcase-swiper", {
        direction: "horizontal",
        loop: true,
        speed: 1000,
        effect: "fade",
        fadeEffect: {
            crossFade: true,
        },
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
            pauseOnMouseEnter: true,
        },
        pagination: {
            el: ".policy-showcase-swiper .swiper-pagination",
            clickable: true,
            renderBullet: function (index, className) {
                return (
                        '<span class="' +
                        className +
                        ' !w-3 !h-3 !bg-black/30 hover:!bg-black !transition-all !duration-300 !mx-1"></span>'
                        );
            },
        },
        
        allowTouchMove: true,
        grabCursor: true,
    });
});

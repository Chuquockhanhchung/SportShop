<%-- Document : signup Created on : Oct 4, 2025 Author : phu --%> <%@page
    contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
            <title>Sign Up</title>
            <link
                rel="stylesheet"
                href="./css/output.css"
                />
            <link
                rel="stylesheet"
                href="./css/style.css"
                />
            <link
                rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
                />

            <style>
                /* Theme variables matching login page */
                :root{
                    --page-bg: #050607;
                    --panel-bg: linear-gradient(180deg, rgba(255,255,255,0.02), transparent);
                    --panel-surface: #070808;
                    --accent: #E0E0E0;
                    --accent-2: #B0B0B0;
                    --text: #ffffff;
                    --muted: #9aa3a6;
                    --input-bg: rgba(0,0,0,0.28);
                    --input-border: rgba(255,255,255,0.06);
                    --card-radius: 12px;
                    --shadow: 0 12px 30px rgba(0,0,0,0.7);
                }

                /* Override Tailwind classes to use gray theme */
                .text-yellow-400 {
                    color: var(--accent) !important;
                }
                .bg-yellow-400 {
                    background-color: var(--accent) !important;
                }
                .bg-yellow-400\/10 {
                    background-color: rgba(224,224,224,0.10) !important;
                }
                .bg-yellow-400\/5 {
                    background-color: rgba(224,224,224,0.05) !important;
                }
                .border-yellow-400\/30 {
                    border-color: rgba(224,224,224,0.30) !important;
                }
                .shadow-yellow-400\/20 {
                    box-shadow: 0 20px 50px rgba(224,224,224,0.12) !important;
                }

                .hover\:text-white:hover {
                    color: #fff !important;
                }

                /* Inputs matching login style */
                input:focus, textarea:focus, select:focus {
                    border-color: var(--accent) !important;
                    box-shadow: 0 0 0 4px rgba(224,224,224,0.1) !important;
                    background: rgba(0,0,0,0.4) !important;
                }

                input[type="text"],
                input[type="email"],
                input[type="password"],
                input[type="tel"],
                input[type="date"],
                textarea {
                    background: #1a1a1a !important;
                    border: 2px solid rgba(255,255,255,0.1) !important;
                    color: #fff !important;
                    transition: all 0.3s ease;
                }

                /* Button matching login style */
                button[type="submit"],
                .btn-yellow {
                    background: linear-gradient(135deg, var(--accent) 0%, var(--accent-2) 100%) !important;
                    color: #061013 !important;
                    border: none !important;
                    font-weight: 700 !important;
                    font-size: 16px !important;
                    padding: 16px 24px !important;
                    box-shadow: 0 4px 15px rgba(224,224,224,0.3) !important;
                    transition: all .2s ease !important;
                }
                button[type="submit"]:hover,
                .btn-yellow:hover {
                    transform: translateY(-3px) !important;
                    box-shadow: 0 8px 25px rgba(224,224,224,0.4) !important;
                }
                button[type="submit"]:active {
                    transform: translateY(-1px) !important;
                }

                .text-yellow-300 {
                    color: var(--accent) !important;
                }

                /* Icon colors */
                .fas.fa-arrow-left, .fas.fa-user, .fas.fa-at, .fas.fa-envelope,
                .fas.fa-lock, .fas.fa-phone, .fas.fa-calendar, .fas.fa-venus-mars,
                .fas.fa-map-marker-alt, .fas.fa-gift, .fas.fa-percent,
                .fas.fa-star, .fas.fa-shipping-fast {
                    color: var(--accent) !important;
                }

                .border-yellow-400\/30 {
                    border-color: rgba(224,224,224,0.30) !important;
                }
                .shadow-yellow-400\/20 {
                    box-shadow: 0 24px 60px rgba(224,224,224,0.06) !important;
                }

                /* Error box */
                .error-box, .bg-red-500\/20 {
                    background: #3b1b1b !important;
                    border: 1px solid rgba(255,50,50,0.06) !important;
                    color: #ffb3b3 !important;
                }

                .text-gray-400, .placeholder-gray-500 {
                    color: var(--muted) !important;
                }

                a.text-yellow-400 {
                    color: var(--accent) !important;
                }
                a.text-yellow-400:hover {
                    color: var(--accent-2) !important;
                }

                /* Back link matching login */
                .back-link-custom {
                    display:inline-flex;
                    align-items:center;
                    gap:10px;
                    color:white;
                    font-weight:600;
                    margin-bottom:18px;
                    position: absolute;
                    top: 20px;
                    left: 20px;
                    padding: 10px 16px;
                    background: rgba(255,255,255,0.05);
                    border-radius: 8px;
                    transition: all 0.2s ease;
                    font-size: 14px;
                }
                .back-link-custom:hover {
                    background: rgba(255,255,255,0.1);
                    transform: translateX(-3px);
                }

                /* Header gradient override */
                .header-gradient-override {
                    background: transparent !important;
                    border-bottom: 1px solid rgba(255,255,255,0.02);
                }

                /* Card style matching login */
                .card-custom {
                    background: var(--panel-surface);
                    border: 2px solid gray !important;
                    box-shadow: var(--shadow);

                }

                /* Checkbox/Radio accent */
                input[type="checkbox"]:checked,
                input[type="radio"]:checked {
                    accent-color: var(--accent) !important;
                }

                #error-box-container{
                    margin-top: 10px;
                }
            </style>
        </head>
        <body class="min-h-screen relative overflow-x-hidden" style="background: radial-gradient(125% 125% at 50% 100%, #000000 40%, #010133 100%);">
            <!-- Animated Background -->
            <div class="fixed inset-0 overflow-hidden -z-10">
                <!-- Subtle decorative blobs -->
                <div
                    class="absolute top-0 right-0 w-96 h-96 bg-yellow-400/10 rounded-full blur-3xl animate-pulse"
                    ></div>
                <div
                    class="absolute bottom-0 left-0 w-96 h-96 bg-yellow-400/10 rounded-full blur-3xl animate-pulse animation-delay-2000"
                    ></div>
                <div
                    class="absolute top-1/2 right-1/4 w-96 h-96 bg-yellow-400/5 rounded-full blur-3xl animate-pulse animation-delay-4000"
                    ></div>
            </div>

            <!-- Main Container -->
            <div class="relative z-10 min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
                <div class="w-full max-w-2xl space-y-8">
                    <div class="w-full max-w-2xl space-y-8">
                        <!-- Back to Home -->
                        <div>
                            <a
                                href="home"
                                class="back-link-custom"
                                >
                                <i class="fas fa-arrow-left"></i>
                                <span>Back to Home</span>
                            </a>
                        </div>

                        <!-- Sign Up Card -->
                        <div
                            class="card-custom rounded-2xl overflow-hidden backdrop-blur-xl"
                            >
                            <!-- Header -->
                            <div
                                class="header-gradient-override p-8 text-center"
                                >
                                <h1
                                    class="text-4xl font-black text-white uppercase tracking-tight mb-2 font-bebas"
                                    style="letter-spacing: 2px;"
                                    >
                                    SPORTZONE
                                </h1>
                                <p class="text-white font-semibold text-gray-400 text-sm">
                                    Start Your Athletic Journey Today!
                                </p>
                            </div>
                            
                            <!-- Success Message -->
                                <% if (request.getAttribute("success") != null) { %>
                                <div class="mt-2 mb-6 p-4 border border-green-500 rounded-lg bg-green-500/15 flex items-center gap-3 animate-fadeIn">
                                    <i class="fas fa-check-circle text-green-400 text-lg"></i>
                                    <p class="text-green-400 text-sm font-semibold tracking-wide text-center">
                                        <%= request.getAttribute("success") %>
                                    </p>
                                </div>
                                <% } %>

                            <!-- Form -->
                            <div class="p-8 font-inter">
                                <form action="signup" method="POST" id="signupForm">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                        <!-- Full Name -->
                                        <div>
                                            <label
                                                class="block font-semibold text-white  mb-2 tracking-wide text-base"
                                                >
                                                Full Name
                                            </label><input
                                                type="text"
                                                name="fullname"
                                                id="fullname"
                                                placeholder="John Doe"
                                                required
                                                value="${formData_fullname}"
                                                class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                                />
                                        </div>

                                        <!-- Username -->
                                        <div>
                                            <label
                                                class="block text-white font-semibold mb-2  tracking-wide text-base"
                                                >

                                                Username
                                            </label>
                                            <input
                                                type="text"
                                                name="username"
                                                id="username"
                                                placeholder="johndoe"
                                                required
                                                value="${formData_username}"
                                                class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                                />
                                        </div>
                                    </div>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                        <!-- Date of Birth -->
                                        <div class="mb-6">
                                            <label
                                                class="block text-white font-semibold mb-2 tracking-wide text-base"
                                                >

                                                Date Of Birth
                                            </label>
                                            <input
                                                type="date"
                                                name="dob"
                                                id="dob"
                                                required
                                                value="${formData_dob}"
                                                class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                                />
                                        </div>

                                        <!-- Gender -->
                                        <div class="mb-6">
                                            <label
                                                class="block text-white font-semibold mb-3 tracking-wide text-base"
                                                >
                                                Gender
                                            </label>
                                            <div class="flex pt-2 items-center gap-6 text-gray-300">
                                                <label class="flex items-center gap-2 cursor-pointer">
                                                    <input
                                                        type="radio"
                                                        name="gender"
                                                        value="Male"
                                                        required
                                                        ${formData_gender == 'Male' ? 'checked' : ''}
                                                        class="text-yellow-400 focus:ring-yellow-400"
                                                        />
                                                    <span>Male</span>
                                                </label>
                                                <label class="flex items-center gap-2 cursor-pointer">
                                                    <input
                                                        type="radio"
                                                        name="gender"
                                                        value="Female"
                                                        required
                                                        ${formData_gender == 'Female' ? 'checked' : ''}
                                                        class="text-yellow-400 focus:ring-yellow-400"
                                                        />
                                                    <span>Female</span>
                                                </label><label class="flex items-center gap-2 cursor-pointer">
                                                    <input
                                                        type="radio"
                                                        name="gender"
                                                        value="Other"
                                                        required
                                                        ${formData_gender == 'Other' ? 'checked' : ''}
                                                        class="text-yellow-400 focus:ring-yellow-400"
                                                        />
                                                    <span>Other</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Email -->
                                    <div class="mb-6">
                                        <label
                                            class="block text-white font-semibold mb-2 tracking-wide text-base"
                                            >

                                            Email
                                        </label>
                                        <input
                                            type="email"
                                            name="email"
                                            id="email"
                                            placeholder="john@example.com"
                                            required
                                            value="${formData_email}"
                                            class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                            />
                                    </div>

                                    <!-- Address -->
                                    <div class="mb-6">
                                        <label
                                            class="block text-white font-bold mb-2 tracking-wide text-base"
                                            >
                                            Address
                                        </label>
                                        <input
                                            type="text"
                                            name="address"
                                            id="address"
                                            placeholder="123 Nguyen Trai, Hanoi"
                                            required
                                            value="${formData_address}"
                                            class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                            />
                                    </div>

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                        <!-- Password -->
                                        <div>
                                            <label
                                                class="block text-white font-semibold mb-2 tracking-wide text-base"
                                                >
                                                Password
                                            </label>
                                            <div class="relative">
                                                <input
                                                    type="password"
                                                    name="password"
                                                    id="password"
                                                    placeholder="Min. 8 characters"
                                                    required
                                                    minlength="8"
                                                    class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                                    />
                                                <button
                                                    type="button"
                                                    onclick="togglePassword('password', 'toggleIcon1')"class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-yellow-400 transition-colors duration-300"
                                                    >
                                                    <i class="fas fa-eye" id="toggleIcon1"></i>
                                                </button>
                                            </div>
                                        </div>

                                        <!-- Confirm Password -->
                                        <div>
                                            <label
                                                class="block text-white font-semibold mb-2 tracking-wide text-base"
                                                >
                                                Confirm Password
                                            </label>
                                            <div class="relative">
                                                <input
                                                    type="password"
                                                    name="confirmPassword"
                                                    id="confirmPassword"
                                                    placeholder="Re-enter password"
                                                    required
                                                    minlength="8"
                                                    class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                                    />
                                                <button
                                                    type="button"
                                                    onclick="togglePassword('confirmPassword', 'toggleIcon2')"
                                                    class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-yellow-400 transition-colors duration-300"
                                                    >
                                                    <i class="fas fa-eye" id="toggleIcon2"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Phone Number -->
                                    <div class="mb-6">
                                        <label
                                            class="block text-white font-semibold mb-2 tracking-wide text-base"
                                            >
                                            Phone Number
                                        </label>
                                        <input
                                            type="tel"
                                            name="phone"
                                            id="phone"
                                            placeholder="+84 123 456 789"
                                            value="${formData_phone}"
                                            class="w-full px-4 py-3 bg-zinc-800 border-2 border-zinc-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-yellow-400 transition-all duration-300"
                                            />
                                    </div>

                                    <!-- Terms & Conditions -->
                                    <div class="mb-6">
                                        <label class="flex items-start cursor-pointer group">
                                            <input
                                                type="checkbox"
                                                name="terms"
                                                id="terms"
                                                required
                                                class="w-5 h-5 mt-1 rounded border-2 border-zinc-700 bg-zinc-800 text-yellow-400 focus:ring-yellow-400 focus:ring-2 cursor-pointer"
                                                />
                                            <span
                                                class="px-2 text-gray-400 group-hover:text-white transition-colors duration-300 text-base"
                                                >
                                                I agree to the
                                                <a
                                                    href="#"class="text-yellow-400 hover:text-white font-semibold"
                                                    >Terms & Conditions</a
                                                >
                                                and
                                                <a
                                                    href="#"
                                                    class="text-yellow-400 hover:text-white font-semibold"
                                                    >Privacy Policy</a
                                                >
                                            </span>
                                        </label>
                                    </div>

                                    <!-- Newsletter -->
                                    <div class="mb-6">
                                        <label class="flex items-center cursor-pointer group">
                                            <input
                                                type="checkbox"
                                                name="newsletter"
                                                class="w-5 h-5 rounded border-2 border-zinc-700 bg-zinc-800 text-yellow-400 focus:ring-yellow-400 focus:ring-2 cursor-pointer"
                                                />
                                            <span
                                                class="px-2 text-gray-400 group-hover:text-white transition-colors duration-300 text-base"
                                                >
                                                Subscribe to newsletter for exclusive deals and updates
                                            </span>
                                        </label>
                                    </div>


                                    <!-- Password Strength Indicator -->
                                    <div id="passwordStrength" class="mb-6 hidden">
                                        <div class="flex items-center gap-2 mb-2">
                                            <div
                                                class="flex-1 h-2 bg-zinc-700 rounded-full overflow-hidden"
                                                >
                                                <div
                                                    id="strengthBar"
                                                    class="h-full transition-all duration-300 rounded-full"
                                                    ></div>
                                            </div>
                                            <span id="strengthText" class="text-sm font-semibold"></span>
                                        </div>
                                    </div>

                                    <div
                                        id="js-error-box"
                                        class="mb-6 p-4 bg-red-500/20 border border-red-500/50 rounded-lg text-red-400 text-sm font-semibold"
                                        style="display: none;"
                                        >

                                    </div>


                                    <!-- Submit Button -->
                                    <button
                                        type="submit"
                                        class="w-full py-4 bg-yellow-400 hover:bg-white text-black font-extrabold tracking-widest uppercase rounded-lg transition-all duration-300 transform hover:scale-105 hover:shadow-lg hover:shadow-yellow-400/50 cursor-pointer text-xl"
                                        >
                                        Create Account
                                    </button>
                                </form>

                                 <% 
                                 // Lấy lỗi từ server (nếu có)
                                 String serverError = (String) request.getAttribute("error");
                                 boolean hasError = (serverError != null && !serverError.isEmpty());
                                  %>

                                <div
                                    id="error-box-container"
                                    style='display: <%= hasError ? "block" : "none" %>;'
                                    class="mb-6 p-4 border border-red-500 rounded-lg bg-red-500/15 flex items-center gap-3 animate-fadeIn"
                                    >
                                    <i class="fas fa-exclamation-circle text-red-400 text-lg"></i>
                                    <span id="error-text" class="text-red-400 text-sm font-semibold tracking-wide">
                                        <%= hasError ? serverError : "" %>
                                    </span>
                                </div>

                                <!-- Login Link -->
                                <p class="text-center text-gray-400 py-5">
                                    Already have an account?
                                    <a
                                        href="login"
                                        class="text-yellow-400 hover:text-white font-bold transition-colors duration-300"
                                        >
                                        Login
                                    </a>
                                </p>
                            </div>
                        </div>

                        <!-- Benefits -->
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center p-5">
                            <div class="group">
                                <i
                                    class="fas fa-gift text-2xl text-yellow-400 mb-2 group-hover:scale-110 transition-transform duration-300"
                                    ></i>
                                <p class="text-xs text-gray-400 font-semibold uppercase">
                                    Welcome Bonus
                                </p>
                            </div>
                            <div class="group cursor-default">
                                <i
                                    class="fas fa-percent text-2xl text-yellow-400 mb-2 group-hover:scale-110 transition-transform duration-300"
                                    ></i>
                                <p class="text-xs text-gray-400 font-semibold uppercase">
                                    Exclusive Deals
                                </p>
                            </div>
                            <div class="group cursor-default">
                                <i
                                    class="fas fa-star text-2xl text-yellow-400 mb-2 group-hover:scale-110 transition-transform duration-300"
                                    ></i>
                                <p class="text-xs text-gray-400 font-semibold uppercase">
                                    Rewards Points
                                </p>
                            </div>
                            <div class="group cursor-default">
                                <i
                                    class="fas fa-shipping-fast text-2xl text-yellow-400 mb-2 group-hover:scale-110 transition-transform duration-300"
                                    ></i>
                                <p class="text-xs text-gray-400 font-semibold uppercase">
                                    Free Shipping
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                // Toggle Password Visibility
                function togglePassword(inputId, iconId) {
                    const passwordInput = document.getElementById(inputId);
                    const toggleIcon = document.getElementById(iconId);

                    if (passwordInput.type === "password") {
                        passwordInput.type = "text";
                        toggleIcon.classList.remove("fa-eye");
                        toggleIcon.classList.add("fa-eye-slash");
                    } else {
                        passwordInput.type = "password";
                        toggleIcon.classList.remove("fa-eye-slash");
                        toggleIcon.classList.add("fa-eye");
                    }
                }

                // Password Strength Checker
                const passwordInput = document.getElementById("password");
                const strengthIndicator = document.getElementById("passwordStrength");
                const strengthBar = document.getElementById("strengthBar");
                const strengthText = document.getElementById("strengthText");

                if (passwordInput) {
                    passwordInput.addEventListener("input", function () {
                        const password = this.value;
                        if (password.length > 0) {
                            strengthIndicator.classList.remove("hidden");
                            const strength = checkPasswordStrength(password);
                            updateStrengthIndicator(strength);
                        } else {
                            strengthIndicator.classList.add("hidden");
                        }
                    });
                }

                function checkPasswordStrength(password) {
                    let strength = 0;

                    // Length
                    if (password.length >= 8)
                        strength++;
                    if (password.length >= 12)
                        strength++;

                    // Contains lowercase
                    if (/[a-z]/.test(password))
                        strength++;

                    // Contains uppercase
                    if (/[A-Z]/.test(password))
                        strength++;

                    // Contains numbers
                    if (/\d/.test(password))
                        strength++;

                    // Contains special characters
                    if (/[!@#$%^&*(),.?":{}|<>]/.test(password))
                        strength++;

                    return strength;
                }

                function updateStrengthIndicator(strength) {
                    const levels = [
                        {
                            width: "16%",
                            color: "bg-red-500",
                            text: "Very Weak",
                            textColor: "text-red-400",
                        },
                        {
                            width: "33%",
                            color: "bg-orange-500",
                            text: "Weak",
                            textColor: "text-orange-400",
                        },
                        {
                            width: "50%",
                            color: "bg-yellow-500",
                            text: "Fair",
                            textColor: "text-yellow-400",
                        },
                        {
                            width: "66%",
                            color: "bg-lime-500",
                            text: "Good",
                            textColor: "text-lime-400",
                        },
                        {
                            width: "83%",
                            color: "bg-green-500",
                            text: "Strong",
                            textColor: "text-green-400",
                        },
                        {
                            width: "100%",
                            color: "bg-emerald-500",
                            text: "Very Strong",
                            textColor: "text-emerald-400",
                        },
                    ];

                    const level = levels[Math.min(strength, 5)];
                    if (strengthBar) {
                        strengthBar.style.width = level.width;
                        strengthBar.className = `h-full transition-all duration-300 rounded-full ${level.color}`;
                    }
                    if (strengthText) {
                        strengthText.className = `text-sm font-semibold ${level.textColor}`;
                        strengthText.textContent = level.text;
                    }
                }

                // Form Validation
                const signupForm = document.getElementById("signupForm");
                if (signupForm) {
                    signupForm.addEventListener("submit", function (e) {
                        const password = document.getElementById("password").value;
                        const confirmPassword =
                                document.getElementById("confirmPassword").value;
                        const terms = document.getElementById("terms").checked;

                        // Lấy các phần tử của ô lỗi (mà bạn vừa sửa ở Bước 1)
                        const errorContainer = document.getElementById("error-box-container");
                        const errorText = document.getElementById("error-text");

                        // Hàm trợ giúp để hiển thị lỗi
                        function showError(message) {
                            e.preventDefault(); // Ngăn gửi form
                            if (errorText)
                                errorText.textContent = message; // Ghi nội dung lỗi
                            if (errorContainer)
                                errorContainer.style.display = "block"; // Hiện ô lỗi
                        }

                        // 1. Kiểm tra mật khẩu
                        if (password !== confirmPassword) {
                            showError("Mật khẩu và xác nhận mật khẩu không khớp!");
                            return;
                        }

                        // 2. Kiểm tra terms
                        if (!terms) {
                            showError("Bạn phải đồng ý với Điều khoản & Điều kiện.");
                            return;
                        }

                        // 3. Kiểm tra độ dài mật khẩu
                        if (password.length < 8) {
                            showError("Mật khẩu phải có ít nhất 8 ký tự.");
                            return;
                        }

                        if (errorContainer)
                            errorContainer.style.display = "none";
                        if (errorText)
                            errorText.textContent = "";
                    });
                }
            </script>
        </body>
    </html>
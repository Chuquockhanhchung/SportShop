<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Document : login
Created on: Oct 4, 2025 Author : phu --%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Login</title>

        <!-- keep icons & fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
        <link rel="stylesheet" href="./css/output.css">

        <style>
            /* ----- Theme variables: dark + cyan accent to match signup ----- */
            :root{
                --page-bg: #050607;
                --panel-bg: linear-gradient(180deg, rgba(255,255,255,0.02), transparent) ;
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

            /* base page */
            html,body{
                height:100%;
                margin:0;
                color:var(--text);
                -webkit-font-smoothing:antialiased;
                -moz-osx-font-smoothing:grayscale;
                background: radial-gradient(125% 125% at 50% 100%, #000000 40%, #010133 100%);
            }
            a{
                color:inherit;
                text-decoration:none;
            }
            .min-h-screen{
                min-height:100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .wrap{
                max-width:500px;
                width: 100%;
                padding:18px;
                
            }

            /* subtle decorative blobs (kept dim) */
            .bg-decor{
                position:fixed;
                inset:0;
                z-index:-10;
                pointer-events:none;
            }
            .blob{
                position:absolute;
                border-radius:50%;
                filter:blur(40px);
                opacity:.03;
            }
            .blob.b1{
                left:-140px;
                top:-80px;
                width:480px;
                height:480px;
                background:radial-gradient(circle,#000 0,#0000 60%);
            }
            .blob.b2{
                right:-80px;
                bottom:-80px;
                width:460px;
                height:460px;
                background:radial-gradient(circle,#000 0,#0000 60%);
            }
            .blob.b3{
                left:50%;
                top:50%;
                transform:translate(-50%,-50%);
                width:360px;
                height:360px;
                background:radial-gradient(circle,#000 0,#0000 55%);
                opacity:.02;
            }

            /* back link */
            .back-link{
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
            .back-link:hover {
                background: rgba(255,255,255,0.1);
                transform: translateX(-3px);
            }
            .back-link i{
                font-size:14px;
                color:white;
            }

            /* main card: dark panel with cyan left stripe like signup */
            .card {
                background: var(--panel-surface);
                border-radius: var(--card-radius);
                overflow:hidden;
                border: 2px solid gray;
                box-shadow: var(--shadow);

            }

            /* header */
            .card-head {
                background: transparent;
                padding:30px 22px;
                text-align:center;
                border-bottom: 1px solid rgba(255,255,255,0.02);
            }
            .brand {
                font-family: Oswald, sans-serif;
                font-size:40px;
                letter-spacing:2px;
                text-transform:uppercase;
                margin:0;
                color:var(--text);
                font-weight:800;
            }
            .brand-sub {
                color: var(--muted);
                margin-top:6px;
                font-weight:600;
            }

            /* card body */
            .card-body {
                padding:28px 28px 34px 28px;
            }

            label.block {
                display:block;
                color:var(--text);
                font-weight:700;
                margin-bottom:8px;
                font-size:13px;
                text-transform:uppercase;
                letter-spacing:0.6px;
            }

            /* inputs: dark surface, cyan focus */
            input[type="text"],
            input[type="password"] {
                width:100%;
                padding:12px 14px;
                border-radius:10px;
                border:1px solid var(--input-border);
                background: var(--input-bg);
                color:var(--text);
                font-size:15px;
                transition: box-shadow .12s, border-color .12s, background .12s;
            }
            ::placeholder {
                color: rgba(255,255,255,0.25);
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                outline:none;
                border-color: rgba(0,207,232,0.95);
                box-shadow: 0 0 0 6px rgba(0,207,232,0.06);
                background: rgba(0,0,0,0.18);
            }

            /* toggle icon */
            .toggle-pass {
                position:absolute;
                right:14px;
                top:50%;
                transform:translateY(-50%);
                background:transparent;
                border:none;
                color:var(--muted);
                cursor:pointer;
                font-size:18px;
                padding: 8px;
                transition: color 0.2s ease;
            }

            .toggle-pass:hover {
                color: var(--accent);
            }

            .form-row {
                margin-bottom:28px;
                position:relative;
            }

            /* Input styling matching signup */
            .input-group {
                margin-bottom: 24px;
            }

            .input-group label {
                display: block;
                color: white;
                font-weight: 600;
                font-size: 16px;
                margin-bottom: 8px;
                letter-spacing: 0.5px;
            }

            .input-group input {
                width: 100%;
                padding: 12px 16px;
                background: #1a1a1a;
                border: 2px solid rgba(255,255,255,0.1);
                border-radius: 8px;
                color: #fff;
                font-size: 15px;
                transition: all 0.3s ease;
            }

            .input-group input::placeholder {
                color: #9ca3af;
            }

            .input-group input:focus {
                outline: none;
                border-color: var(--accent);
                box-shadow: 0 0 0 4px rgba(224,224,224,0.1);
                background: rgba(0,0,0,0.4);
            }

            /* remember / forgot */
            .row-between {
                display:flex;
                align-items:center;
                justify-content:space-between;
                gap:12px;
                margin-bottom:18px;
            }
            .remember {
                display:flex;
                align-items:center;
                gap:8px;
                color:var(--muted);
                font-size:14px;
            }
            .remember input[type="checkbox"] {
                width:16px;
                height:16px;
                accent-color: var(--accent);
            }

            /* server error */
            .error-box {
                margin-bottom:14px;
                padding:12px;
                border-radius:8px;
                background: #3b1b1b;
                border: 1px solid rgba(255,50,50,0.06);
                color:#ffb3b3;
                font-weight:600;
            }

            /* primary cyan button */
            .btn-submit {
                display:inline-flex;
                align-items:center;
                justify-content:center;
                gap:12px;
                width:100%;
                padding:16px 24px;
                border-radius:10px;
                border: none;
                cursor:pointer;
                color: #061013;
                background: linear-gradient(135deg, var(--accent) 0%, var(--accent-2) 100%);
                transition: all .2s ease;
                margin-top: 24px;
                box-shadow: 0 2px 15px var(--accent-2);
            }
            .btn-submit:hover {
                transform: translateY(-3px);
                box-shadow: 0 3px 25px var(--accent);
            }
            .btn-submit:active {
                transform: translateY(-1px);
            }

            .signup-note {
                text-align:center;
                color:var(--muted);
                margin-top:18px;
            }
            .signup-note a {
                color: var(--accent);
                font-weight:700;
            }

            /* Forgot Password Link */
            .forgot-link {
                display: block;
                color: var(--accent);
                font-weight: 600;
                font-size: 16px;
                text-decoration: none;
                margin-bottom: 5px;
                transition: all 0.2s ease;
                text-align: right;
            }

            .forgot-link:hover {
                color: var(--accent-2);
                transform: translateX(3px);
            }

            .features {
                display:flex;
                gap:18px;
                margin-top:18px;
                justify-content:space-between;
            }
            .feature {
                flex:1;
                text-align:center;
                color:var(--muted);
                font-size:13px;
            }
            .feature i {
                color:var(--accent);
                font-size:20px;
                margin-bottom:8px;
                display:block;
            }

            /* small tweaks for icons and label icons color */
            label.block i {
                color: var(--accent);
                margin-right:8px;
                font-size:14px;
                vertical-align:middle;
            }

            /* responsiveness */
            @media (max-width:640px){
                .wrap{
                    padding:14px;
                }
                .card-head{
                    padding:20px;
                }
                .card-body{
                    padding:18px;
                }
                .brand{
                    font-size:32px;
                }
            }
        </style>
        <!-- ========== end style ========== -->
    </head>

    <body class="min-h-screen relative overflow-x-hidden font-inter" >

        <!-- Decorative background (subtle) -->
        <div class="bg-decor" aria-hidden="true">
            <div class="blob b1"></div>
            <div class="blob b2"></div>
            <div class="blob b3"></div>
        </div>


        <!-- Main Container -->
        <div class="wrap">
            <div>
                <a href="home" class="back-link">
                    <i class="fas fa-arrow-left"></i>
                    <span>Back to Home</span>
                </a>
            </div>

            <!-- CARD (structure unchanged) -->
            <div class="card w-full max-w-md border border-gray-700">
                <div class="card-head">
                    <h1 class="brand">SPORTZONE</h1>
                    <p class="brand-sub">Welcome Back!</p>
                </div>

                <div class="card-body">
                    <form action="login" method="POST" id="loginForm">
                        <div class="login-container">
                            <!-- Username -->
                            <div class="input-group">
                                <label for="username">
                                    Username
                                </label>
                                <input
                                    type="text"
                                    name="username"
                                    id="username"
                                    placeholder="Enter your username"
                                    value="${requestScope.username}"
                                    required
                                    />
                            </div>

                            <!-- Password -->
                            <div class="input-group">
                                <label for="password">
                                    Password
                                </label>
                                <div style="position: relative;">
                                    <input
                                        type="password"
                                        name="password"
                                        id="password"
                                        placeholder="Enter your password"
                                        required
                                        />
                                    <button type="button" onclick="togglePassword()" class="toggle-pass" aria-label="Toggle password">
                                        <i class="fas fa-eye" id="toggleIcon"></i>
                                    </button>
                                </div>
                            </div>

                        </div>

                        <!-- Remember & Forgot -->    
                        <a class="forgot-link" href="forgot">Forgot Password?</a>

                        <!-- Server-side error display -->
                        <c:if test="${not empty error}">
                            <div class="error-box">
                                <i class="fas fa-exclamation-circle" style="margin-right:8px"></i>
                                ${error}
                            </div>
                        </c:if>


                        <!-- Submit -->
                        <button type="submit" class="btn-submit font-semibold text-xl">
                            <span>Login</span>
                        </button>
                    </form>

                    <p class="signup-note py-2">
                        Don't have an account?
                        <a href="signup">Sign Up</a>
                    </p>

                    <div class="features" aria-hidden="true">
                        <div class="feature">
                            <i class="fas fa-shipping-fast"></i>
                            <div>Free Shipping</div>
                        </div>
                        <div class="feature">
                            <i class="fas fa-shield-alt"></i>
                            <div>Secure Payment</div>
                        </div>
                        <div class="feature">
                            <i class="fas fa-headset"></i>
                            <div>24/7 Support</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- original scripts (unchanged) -->
        <script>
            // Toggle Password Visibility
            function togglePassword() {
                const passwordInput = document.getElementById("password");
                const toggleIcon = document.getElementById("toggleIcon");

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

            // Form Validation (unchanged)
            document
                    .getElementById("loginForm")
                    .addEventListener("submit", function (e) {
                        const username = document.getElementById("username").value;
                        const password = document.getElementById("password").value;

                        if (!username || !password) {
                            e.preventDefault();
                            alert("Please fill in all fields");
                        }
                    });
        </script>
    </body>
</html>
<%-- 
    Document   : forgot
    Created on : Oct 22, 2025, 3:00:59 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link rel="stylesheet" href="./css/output.css" />
        <style>
            :root{
                --bg-1: #07090b;
                --bg-2: #0c0f12;
                --card: rgba(255,255,255,0.015);
                --glass: rgba(255,255,255,0.03);
                --accent: #dfe6eb;
                --accent-2: #b7bec4;

                --muted: #9aa4ad;
                --text: #e4e8ec;

                --danger: #ff6b6b;

                --success-bg: rgba(200, 255, 220, 0.08);
                --error-bg: rgba(255, 140, 140, 0.08);

                --radius-lg: 14px;
                --radius-md: 10px;
            }


            *{
                box-sizing: border-box
            }
            html,body{
                height:100%
            }
            body{
                margin:0;
                font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
                background: radial-gradient(1200px 600px at 10% 10%, rgba(8,20,30,0.6), transparent),
                    linear-gradient(180deg, var(--bg-1) 0%, var(--bg-2) 100%);
                color:var(--text);
                -webkit-font-smoothing:antialiased;
                display:flex;
                align-items:center;
                justify-content:center;
                padding:28px;
            }

            .wrap{
                width:100%;
                max-width:600px;
                padding:18px;
            }


            .card {
                border-radius: var(--radius-lg);
                overflow: hidden;
                background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
                border: 1px solid rgba(255,255,255,0.04);
                backdrop-filter: blur(8px) saturate(120%);
                box-shadow: 0 10px 30px rgba(2,8,12,0.6), inset 0 1px 0 rgba(255,255,255,0.02);
            }

            .banner {
                display:flex;
                align-items:center;
                gap:16px;
                padding:28px 28px;
                background: linear-gradient(90deg, rgba(255,255,255,0.12), rgba(180,180,180,0.06));

                border-bottom: 1px solid rgba(255,255,255,0.03);
            }
            .brand {
                display:flex;
                flex-direction:column;
            }
            .brand h1{
                margin:0;
                font-size:20px;
                letter-spacing:4px;
                color:var(--text);
                font-weight:800;
            }
            .brand p{
                margin:4px 0 0;
                color:var(--muted);
                font-size:13px;
                font-weight:600;
            }

            /* ---------- Body ---------- */
            .body {
                padding:28px;
            }

            .lead {
                font-size:15px;
                margin:0 0 12px 0;
                color:var(--muted);
            }

            label{
                display:block;
                font-size:13px;
                color:var(--text);
                font-weight:700;
                margin-bottom:8px;
            }

            input[type="email"], input[type="text"], input[type="password"]{
                width:100%;
                padding:14px 16px;
                border-radius: var(--radius-md);
                background: rgba(255,255,255,0.02);
                border: 1px solid rgba(255,255,255,0.08);
                color:var(--text);
                font-size:15px;
                outline:none;
                transition: 0.25s ease;
            }

            input::placeholder{
                color: rgba(255,255,255,0.35);
                font-weight:300;
            }

            input:focus{
                border-color: rgba(255,255,255,0.25);
                box-shadow: 0 0 0 6px rgba(255,255,255,0.04),
                    0 4px 20px rgba(255,255,255,0.06);
                transform: translateY(-1px);
            }


            .note {
                color: var(--muted);
                font-size: 14px;
                margin: 10px 0 18px;
            }

            .msg {
                display:flex;
                gap:12px;
                align-items:center;
                padding:12px 14px;
                border-radius:10px;
                font-weight:700;
                font-size:14px;
                margin-bottom:16px;
                border: 1px solid rgba(255,255,255,0.03);
                backdrop-filter: blur(6px);
            }
            .msg .icon{
                width:34px;
                height:34px;
                min-width:34px;
                display:inline-flex;
                align-items:center;
                justify-content:center;
                border-radius:8px;
                font-size:16px;
            }
            .msg.success{
                background: var(--success-bg);
                color: var(--accent);
                border: 1px solid rgba(22,211,154,0.18);
            }

            
            .msg.error{
                background: var(--error-bg);
                color: #ff9b9b;
                border:1px solid rgba(255,107,107,0.14);
            }


            .actions {
                display:flex;
                gap:12px;
                align-items:center;
                margin-top:8px;
            }

            button.btn {
                flex:1;
                padding:12px 16px;
                border-radius:10px;
                border:none;
                cursor:pointer;
                font-weight:700;
                font-size:15px;
                color:#0b0d10;

                background: linear-gradient(90deg, #ffffff, #dce2e7);
                box-shadow:
                    0 0 22px rgba(255,255,255,0.45),
                    0 8px 34px rgba(0,0,0,0.65);

                transition: transform .18s ease, box-shadow .18s ease;
            }

            button.btn:hover{
                transform: translateY(-3px);
                box-shadow:
                    0 0 32px rgba(255,255,255,0.55),
                    0 12px 40px rgba(0,0,0,0.75);
            }

            button.btn:active{
                transform: translateY(0);
                box-shadow:
                    0 0 12px rgba(255,255,255,0.35),
                    0 6px 18px rgba(0,0,0,0.5);
            }


            a.link {
                color: var(--muted);
                text-decoration: none;
                font-weight:700;
                font-size:14px;
                padding:6px 8px;
                border-radius:8px;
                transition: color .12s ease;
            }
            a.link:hover{
                color: var(--text)
            }

            .footer{
                padding:12px 20px;
                border-top: 1px solid rgba(255,255,255,0.02);
                background: linear-gradient(180deg, rgba(255,255,255,0.01), transparent);
                text-align:center;
                font-size:13px;
                color:var(--muted);
            }

            /* Responsive */
            @media (max-width:520px){
                .wrap{
                    padding:12px
                }
                .banner{
                    padding:20px 18px
                }
                .body{
                    padding:20px 16px
                }
                .brand h1{
                    font-size:18px
                }
            }

        </style>
    </head>
    <body>
        <div class="wrap">
            <div class="card">
                <div class="banner">
                    <div class="brand">
                        <h1>SPORTZONE</h1>
                        <p>Reset your password</p>
                    </div>
                </div>

                <div class="body">

                    <% if (error != null) { %>
                    <!-- Error box (modern) -->
                    <div class="msg error" role="alert" style="margin-top:8px;">
                        <div class="icon" aria-hidden="true">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="text"><%= error %></div>
                    </div>
                    <% } %>

                    <% if (request.getAttribute("success") != null) { %>
                    <!-- Success box -->
                    <div class="msg success" role="status" style="margin-top:8px;">
                        <div class="icon" aria-hidden="true">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="text"><%= request.getAttribute("success") %></div>
                    </div>
                    <% } %>

                    <form action="forgot" method="post" novalidate>
                        <p class="lead">Enter your account email and we'll send instructions to reset your password.</p>

                        <label for="email">Email address</label>
                        <input id="email" name="email" type="email" required placeholder="you@example.com" />

                        <div class="actions">
                            <button class="btn" type="submit">Send reset link</button>
                        </div>
                    </form>
                </div>

                <div class="footer">
                    <a class="link" href="<%= request.getContextPath() %>/login">← Back to sign in</a>
                </div>
            </div>
        </div>

    </body>
</html>

<%-- 
    Document   : forgot-sent
    Created on : Oct 22, 2025, 3:04:35 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String resetLink = (String) request.getAttribute("resetLink");
    String info = (String) request.getAttribute("info");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yêu cầu đã được gửi</title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <style>
            :root{
                --bg:#0b0c0c;
                --card:#0f1112;
                --gold:#d4a701;
                --muted:#bdbdbd
            }
            body{
                margin:0;
                background:#070707;
                color:#eee;
                min-height:100vh;
                display:flex;
                align-items:center;
                justify-content:center;
                padding:20px;
                font-family:Inter,Arial
            }
            .wrap{
                max-width:760px;
                width:100%
            }
            .card{
                background:var(--card);
                border-radius:12px;
                overflow:hidden;
                border:1px solid rgba(255,215,0,0.06)
            }
            .banner{
                background:var(--gold);
                padding:34px;
                text-align:center;
                color:#111
            }
            .banner h1{
                margin:0;
                font-size:36px;
                font-weight:800
            }
            .body{
                padding:28px
            }
            p.lead{
                color:#ddd;
                font-size:16px;
                margin:0 0 12px
            }
            .box{
                background:#0b0b0b;
                padding:16px;
                border-radius:10px;
                border:1px solid rgba(255,255,255,0.02);
                color:var(--muted)
            }
            a.resetlink{
                display:inline-block;
                margin-top:12px;
                color:#111;
                background:var(--gold);
                padding:10px 14px;
                border-radius:8px;
                text-decoration:none;
                font-weight:700
            }
            .muted{
                color:var(--muted)
            }
        </style>
    </head>
    <body>
        <div class="wrap">
            <div class="card">
                <div class="banner"><h1>Yêu cầu đã được gửi</h1></div>
                <div class="body">
                    <p class="lead">Nếu email tồn tại trong hệ thống, chúng tôi đã gửi đường dẫn đặt lại mật khẩu.</p>

                    <% if (info != null) { %>
                    <div class="box"><%= info %></div>
                    <% } %>

                    <!-- DEV ONLY: show reset link to test -->
                    <% if (resetLink != null) { %>
                    <div style="margin-top:16px">
                        <div class="box"><strong>Dev reset link (test only):</strong><br/>
                            <a class="resetlink" href="<%= resetLink %>"><%= resetLink %></a>
                        </div>
                    </div>
                    <% } %>

                    <div style="margin-top:20px">
                        <a style="color:var(--gold);font-weight:700;text-decoration:none" href="<%= request.getContextPath() %>/">Quay lại đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

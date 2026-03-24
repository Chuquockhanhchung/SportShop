<%-- 
    Document   : reset-success
    Created on : Oct 22, 2025, 3:12:23 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = (String) request.getAttribute("email");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thay mật khẩu thành công</title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
<style>
  :root{--card:#0f1112;--gold:#d4a701;--muted:#bdbdbd}
  body{margin:0;background:linear-gradient(180deg,#060606,#0b0c0c);color:#eee;font-family:Inter,Arial;display:flex;align-items:center;justify-content:center;padding:28px;min-height:100vh}
  .card{width:100%;max-width:680px;background:var(--card);border-radius:12px;border:1px solid rgba(255,215,0,0.06);overflow:hidden}
  .banner{background:var(--gold);padding:28px;text-align:center;color:#111}
  .banner h2{margin:0;font-size:34px;font-weight:800}
  .body{padding:24px;text-align:center}
  .btn{display:inline-block;margin-top:18px;padding:12px 18px;border-radius:10px;background:var(--gold);color:#111;font-weight:800;text-decoration:none}
  .muted{color:var(--muted)}
</style>
    </head>
    <body>
  <div class="card">
    <div class="banner"><h2>Thành công!</h2></div>
    <div class="body">
      <p class="muted">Mật khẩu cho tài khoản <strong><%= (email!=null?email:"(unknown)") %></strong> đã được cập nhật.</p>
      <a class="btn" href="<%= request.getContextPath() %>/">Đăng nhập ngay</a>
    </div>
  </div>
</body>
</html>

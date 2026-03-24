<%-- 
    Document   : reset
    Created on : Oct 22, 2025, 3:09:11 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String token = (String) request.getAttribute("token");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lại mật khẩu</title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
<style>
  :root{--card:#0f1112;--gold:#d4a701;--muted:#bdbdbd}
  body{margin:0;background:linear-gradient(180deg,#060606,#0b0c0c);color:#eee;font-family:Inter,Arial;display:flex;align-items:center;justify-content:center;padding:28px;min-height:100vh}
  .panel{width:100%;max-width:480px;background:var(--card);border-radius:12px;border:1px solid rgba(255,215,0,0.06);overflow:hidden}
  .head{background:var(--gold);padding:28px;text-align:center;color:#111}
  .head h2{margin:0;font-size:34px;font-weight:800}
  .content{padding:24px}
  label{display:block;color:var(--gold);font-weight:700;margin-bottom:8px}
  input{width:100%;padding:12px 14px;border-radius:10px;border:1px solid rgba(255,255,255,0.04);background:#141415;color:#eee;font-size:15px}
  .error{background:#3b1b1b;color:#ffc9c9;padding:10px;border-radius:8px;margin-bottom:12px}
  .btn{margin-top:16px;background:var(--gold);color:#111;border:none;padding:12px 16px;border-radius:10px;font-weight:800;cursor:pointer;width:100%}
  .small{margin-top:12px;color:var(--muted);font-size:13px;text-align:center}
</style>
    </head>
    <body>
  <div class="panel">
    <div class="head"><h2>Đặt lại mật khẩu</h2></div>
    <div class="content">
      <% if (error != null) { %>
        <div class="error"><%= error %></div>
      <% } %>

      <form action="<%= request.getContextPath() %>/reset" method="post">
        <input type="hidden" name="token" value="<%= token %>"/>
        <label for="pwd">Mật khẩu mới</label>
        <input id="pwd" name="password" type="password" required placeholder="Nhập mật khẩu mới" />
        <label for="confirm" style="margin-top:12px">Xác nhận mật khẩu</label>
        <input id="confirm" name="confirm" type="password" required placeholder="Nhập lại mật khẩu" />
        <button class="btn" type="submit">Lưu mật khẩu mới</button>
      </form>
      <div class="small">
        <a style="color:var(--gold);text-decoration:none;font-weight:700" href="<%= request.getContextPath() %>/">Quay về đăng nhập</a>
      </div>
    </div>
  </div>
</body>
</html>

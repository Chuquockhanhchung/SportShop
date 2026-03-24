<%-- 
    Document   : reset-invalid
    Created on : Oct 22, 2025, 3:13:49 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Liên kết không hợp lệ</title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
<style>
  :root{--card:#0f1112;--gold:#d4a701;--muted:#bdbdbd}
  body{margin:0;background:linear-gradient(180deg,#060606,#0b0c0c);color:#eee;font-family:Inter,Arial;display:flex;align-items:center;justify-content:center;padding:28px;min-height:100vh}
  .box{width:100%;max-width:680px;background:var(--card);border-radius:12px;border:1px solid rgba(255,215,0,0.06);overflow:hidden}
  .head{background:var(--gold);padding:28px;text-align:center;color:#111}
  .head h2{margin:0;font-size:34px;font-weight:800}
  .body{padding:24px;text-align:center}
  a.link{color:#111;background:var(--gold);padding:12px 16px;border-radius:10px;text-decoration:none;font-weight:800}
  .muted{color:var(--muted)}
</style>
    </head>
    <body>
  <div class="box">
    <div class="head"><h2>Liên kết không hợp lệ</h2></div>
    <div class="body">
      <p class="muted">Đường dẫn đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.</p>
      <p style="margin-top:12px"><a class="link" href="<%= request.getContextPath() %>/forgot">Yêu cầu lại</a></p>
    </div>
  </div>
</body>
</html>

</html>

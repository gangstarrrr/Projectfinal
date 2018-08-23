<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>JavaScript Shield UI Demos</title>
    <link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" />
    <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
</head>
<script type="text/javascript">

</script>
<style>

</style>
<body>

 <c:if test="${empty sessionScope }">
     <button class="bar-item button m_side" style="margin: 0">LOGIN</button>
 </c:if>
 <c:if test="${sessionScope.user.status==1}">
 	${sessionScope.user.status==1
     <button onclick="document.getElementById('logout')" class="bar-item button m_side" id="logout" style="margin: 0">LOGOUT</button>
 </c:if>
 

<form class="modal-content animate" action="login">

    <div class="container">
      <label for="id"><b>ID</b></label>
      <input type="text" placeholder="Enter Username" name="id" required>

      <label for="password"><b>PASSWORD</b></label>
      <input type="password" placeholder="Enter Password" name="password" required>
        
      <button type="submit" style="background-color: #6e9dcc">Login</button>
    </div>
  </form>
</body>
</html>
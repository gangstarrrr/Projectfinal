<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<title>HOLA JEJU</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#see").on("click",function(){
		location.href="/see_something";
		
	});
});

</script>
<style>
body,h1 {font-family: "Raleway", sans-serif}
body, html {height: 100%;padding: 0}
body{margin:0}
.bgimg {
    background-image: url('/resources/img/home.png');
    min-height: 100%;
    background-position: center;
    background-size: cover;
}
.display-container{position:relative} 
.animate-opacity{animation:opac 0.8s}@keyframes opac{from{opacity:0} to{opacity:1}}
.text-white{color:#fff!important}
.display-middle{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%)}
.jumbo{font-size:100px!important;transform: translateY(-150px)} .jumbo:hover{cursor: pointer;color:#52505c}
.animate-top{position:relative;animation:animatetop 0.4s}@keyframes animatetop{from{top:-300px;opacity:0} to{top:0;opacity:1}}
.border{background-color:white!important;transform: translateY(-220px);border: solid 1.5px white;width:100%;}
.sub{font-size:30px!important;transform: translateY(-230px); font-weight: bolder;}
.center{text-align:center!important}
.w3-display-bottomright{position:absolute;right:0;bottom:0}
.padding-large{padding:12px 24px!important}  
</style>
<body>

<div class="bgimg display-container animate-opacity text-white">
  <div class="display-middle">
    <h1 class="jumbo animate-top" id="see">HōLA JEJU</h1>
    <hr class="border">
    <p class="sub center">ANALYSIS SITE</p>
  </div>
  <div class="display-bottomleft padding-large">
    갱's portfolio
  </div>
</div>

</body>
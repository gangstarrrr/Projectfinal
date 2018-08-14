<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<title>to do something</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#gochart").on("click",function(){
		location.href="/gang/chart";
		
	});
	$("#gotable").on("click",function(){
		location.href="";
		
	});
});

</script>
<style>
::-webkit-scrollbar { 
    display: none; 
}
article,aside,details,figcaption,figure,footer,header,main,menu,nav,section,summary{display:block}
body{margin:0}
.top{top:0;position:fixed;width:100%;z-index:1}
.bar{width:100%;overflow:hidden}

.white{color:#000!important;background-color:#fff!important}
.wide{letter-spacing:4px}
.padding{padding:0px 16px!important}
.card{box-shadow:0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)}
.bar-item{float:left;width:auto;border:none;display:block;outline:0;font-size: 35px;}
.button{border:none;display:inline-block;padding: 0px 20px;vertical-align:middle;overflow:hidden;text-decoration:none;color:inherit;background-color:inherit;text-align:center;cursor:pointer;white-space:nowrap;}
.button{-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none} 
.button:disabled{cursor:not-allowed;opacity:0.3}.w3-disabled *,:disabled *{pointer-events:none}
.button:hover{color:#000!important;background-color:#ccc!important}
.bar .button{white-space:normal}
.right{float:right!important}

.content{max-width:980px;margin:auto;}
.m_side{font-size: 20px;padding: 10px 20px;transform: translateX(-40px)}
.image{width:1000px;height:974px;transform: translateX(-50px);background-size:cover}
.display-bottom{position:absolute;bottom:2%;left:0.5%; font-weight: 500;z-index: 1;}
    
.display-middle{position:absolute;top:30%;transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%);z-index: 1;}
.left_text{left:23%}
.right_text{right: 0%;transform: translate(-15%,-50%)}  
    
.margin-top{margin-top:16px!important}
.center{text-align:center!important}
.xxlarge{font-size:36px!important}
.text-white{color:#fff!important}
.w3-display-bottomright{position:absolute;right:0;bottom:0}
.padding-large{padding:12px 24px!important} 
.float_left{float: left}
.float_right{float: right}
.left_img{background-image: url(/gang/resources/img/home.png);left: 0%}
.right_img{background-image: url(/gang/resources/img/img.jpg);right: 0%;transform: translateX(30px)}
.position_absoult{position:absolute;top:0%}
.black{color:#fff!important; font-size: 50px}
#gotable:hover, #gochart:hover{cursor: pointer;color: black}
</style>
<body>
<!-- Navbar -->
<div class="top">
  <div class="bar white wide padding card">
    <a href="#home" class="bar-item button"><b>HōLA JEJU</b></a>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="right hide-small">
      <a href="#projects" class="bar-item button m_side">SIGN</a>
      <a href="#about" class="bar-item button m_side">LOGIN</a>
    </div>
  </div>
</div>

<!-- contents -->
<header class="content wide" style="margin-left:0;" id="home">
    
<div class="display-middle margin-top center left_text">
    <h1 class="xxlarge text-white">
        <span class="padding black opacity-min"><b id="gochart">CHART ANALYSIS</b></span></h1>
  
 </div>
    
<div class="display-middle margin-top center right_text">
    <h1 class="xxlarge text-white">
        <span class="padding black opacity-min"><b id="gotable">FIND YOUR TRAVELMATE</b></span></h1>
  
 </div>
<div class="position_absoult left_img image"></div>
<div class="position_absoult right_img image"></div>
<div class="padding-large text-white display-bottom">
    갱's portfolio
</div>
</header>

</body>
</html>
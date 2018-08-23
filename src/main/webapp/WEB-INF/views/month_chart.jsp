<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>
<html>
<head>
<meta charset="UTF-8">
<title>월 별 차트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd96e06027a0320acba403cccb6d68be&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" type="text/css" href="/gang/resources/css/see_something.css">
<style>
/*나중에 배경 투명도 조절해서 낮춰버리기*/
html, body {padding: 0; margin: 0;}
h1 {text-align: center; padding: 20px 0;}
#wrap {width: 80%; margin-left: 10%;}
#dataList li {cursor: pointer;list-style: none;text-align: center}
#dataList li:hover {background-color: yellow;}
#bar_body {width: 100%; background-color: red; margin-bottom: 50px;}
#bar_div {width: 0%; height: 25px; background-color: red; text-align: center; font-weight: bold; color: white;}
.btn1 {width: 100%;; display: inline-block;}
.active {background-color: yellow;}
#chart_body {width: 100%; height: 300px;}
#img{background-image: url(/gang/resources/img/%EA%B1%B8%EC%96%B4%EA%B0%90.gif);width: 230px;height: 200px;position: absolute;top: 0;background-size: cover;}
#btn1{transform: translateY(130px);}
</style>
<script>
$(document).ready(function(){
	
	if(<%=session.getAttribute("status")%>==null){
		alert("PLZ LOGIN FIRST");
		location.href="/gang/see_something";
	}
	$("#logout").on("click",function(){
		location.href="/gang/logout";
		alert("LOGOUT DONE");
	});
	var month=getparam('month');
	$("#step1").append("<h1>"+month+"월 유동인구 분석</h1>");
	$("#step2").prepend("<h3>"+month+"월 시간당 유동인구 분석 결과</h3>");
	$("#step3").prepend("<h3>"+month+"월 지역별 유동인구 분석 결과</h3>");
	
	$("#btn1").on("click",function(){
		$.ajax({
			type:"post",
			url:"/gang/analysis",
			data:{"btn":'2',"month":month}
		}).done(function(data){
			name=data.name;
			$.ajax({
				type:"post",
				url:"/gang/readfile",
				data:{"name":name}
			}).done(function(data){
				var result = data.result;
				console.log(result);
				google.charts.load('current', {'packages':['corechart', 'line']});
			    google.charts.setOnLoadCallback(drawChart);
			    
			    function drawChart() {
			    	var chartData = new google.visualization.DataTable();
	 		    	chartData.addColumn("string", "Time");
		    		chartData.addColumn("number", "유동인구량");
	
			        var option = {
	        		 hAxis: {
	        	          title: 'Time'
	        	        },
	        	        vAxis: {
	        	          title: 'amount'
	        	        } ,
	        	        height : 400,
	                    width  : 1600,
	                    pointSize: 5,
	                    legend : 'none',
	                    colors:['red','#004411']
			        };
			        
			        $.each(result, function(index, value) {
		    			var row = [];
		    			for(var i = 0; i < 2; i++){
		    				row[i] = (i != 0) ? Number(value[i]) : value[i];
		    			}
		    			chartData.addRows([ row ]);
		    		});
			        
			        var chart = new google.visualization.LineChart(document.getElementById('chart_body'));
			        chart.draw(chartData, option);
			      }
			});			
		
	});
});	
	$("#btn2").on("click",function(){
		$.ajax({
			type:"post",
			url:"/gang/analysis",
			data:{"btn":'1',"month":month}
		}).done(function(data){
			name=data.name;
			$.ajax({
				type:"post",
				url:"/gang/readfile",
				data:{"name":name}
			}).done(function(data){
				var result = data.result;
				console.log(result);
			});
		});
	});
	
	
	$("#btn3").on("click",function(){
		location.href="/gang/see_something";
		
	});
	
});	
	function getparam(paramName){ 
		var _tempUrl = window.location.search.substring(1); 
	 var _tempArray = _tempUrl.split('&');
	 for(var i = 0; _tempArray.length; i++) { 
		 var _keyValuePair = _tempArray[i].split('=');
		 if(_keyValuePair[0] == paramName){ 
			 return _keyValuePair[1]; 
			 } 
		 } 
	 } 
	window.onload = function (){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(33.378885, 126.530975), // 지도의 중심좌표
	        level: 9, // 지도의 확대 레벨
	        mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
	    }; 

		// 지도를 생성한다 
		var map = new daum.maps.Map(mapContainer, mapOption); 
	}
	
</script>
</head>
<body>
<!-- Navbar -->
<div class="top">
  <div class="bar white wide padding card">
    <a href="/gang" class="bar-item button" id="gang"><b style="color:black">HōLA JEJU</b></a>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="right hide-small" id="silo">
    <c:if test="${sessionScope.status==0}">
        <button onclick="document.getElementById('sign').style.display='block'" class="bar-item button m_side" style="margin: 0">SIGN</button>
        <button onclick="document.getElementById('login').style.display='block'" class="bar-item button m_side" style="margin: 0">LOGIN</button>
    </c:if>
    <c:if test="${sessionScope.status==null}">
        <button onclick="document.getElementById('sign').style.display='block'" class="bar-item button m_side" style="margin: 0">SIGN</button>
        <button onclick="document.getElementById('login').style.display='block'" class="bar-item button m_side" style="margin: 0">LOGIN</button>
    </c:if>
    <c:if test="${sessionScope.status==1}">
    	<button onclick="document.getElementById('infoupdate').style.display='block'" class="bar-item button m_side" style="margin: 0; height:47px;">${sessionScope.user.name}'s INFO</button>
  
        <button onclick="document.getElementById('logout')" class="bar-item button m_side" id="logout" style="margin: 0">LOGOUT</button>
    </c:if>
    </div>
  </div>
</div>
	<div id="wrap">
		<div style='height: 100px'></div>
        <div id="img"></div>
        <div id="step1"></div>
		
        <hr>
		<div id="step2" style='height: 500px'>
			<div id="chart_body">Chart 영역</div>
			<button type="button" id="btn1" class="btn1">분석 & 결과보기</button>
		</div>
		<hr>
        <div id="step3" style='height: 700px'>
			<div id="map" style="width:1500px;height:650px;"></div>	
		</div>
		<button type="button" id="btn2" class="btn1">분석 & 결과보기</button>
		<hr>
		<div id="step4">
			<button type="button" id="btn3" class="btn1">돌아가기</button>
			<hr>
		</div>
	</div>
</body>
</html>
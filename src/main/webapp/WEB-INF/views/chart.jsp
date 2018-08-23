<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>
<html>
<head>
<meta charset="UTF-8">
<title>테스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" type="text/css" href="/gang/resources/css/see_something.css">
<style>
html{background-image: ;}
/*나중에 배경 투명도 조절해서 낮춰버리기*/
html, body {padding: 0; margin: 0;}
h1 {text-align: center; padding: 20px 0;}
#wrap {width: 80%; margin-left: 10%;}
#dataList li {cursor: pointer;list-style: none;text-align: center}
#dataList li:hover {background-color: yellow;}
#bar_body {width: 100%; background-color: red; margin-bottom: 50px;}
#bar_div {width: 0%; height: 25px; background-color: red; text-align: center; font-weight: bold; color: white;}
#btn1, #btn2 {width: 100%;; display: inline-block;}
.active {background-color: yellow;}
#chart_body {width: 100%; height: 300px;}
#img{background-image: url(/gang/resources/img/%ED%9D%94%EB%93%A4%ED%9D%94%EB%93%A4.gif);width: 230px;height: 200px;position: absolute;top: 0;background-size: cover;}

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
	var month;
	/* $.ajax({
		type:"post",
		url:"/gang/analysis",
		data:{"btn":'3',"month":'2015.csv'}
	}).done(function(data){
		name=data.name;
		$.ajax({
			type:"post",
			url:"/gang/readfile",
			data:{"name":name}
		}).done(function(data){
			var result = data.result;
			google.charts.load('current', {'packages':['corechart', 'line']});
		    google.charts.setOnLoadCallback(drawChart);
		    
		    function drawChart() {
		    	var chartData = new google.visualization.DataTable();
 		    	chartData.addColumn("string", "Month");
	    		chartData.addColumn("number", "유동인구량");

		        var option = {
        		 hAxis: {
        	          title: 'Month'
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
		
	}) */
	
	$.ajax({
		type:"post",
		url:"/gang/dir"
	}).done(function(data){
		var result=data.result;
		
		for(var i =0 ; i < result.length;i++){
			for(var key in result[i]){
				key = key.split("2015").join("");
				$("#dataList").append("<li><input type='radio' name='month' value='"+key+"'>2015년 "+ key +"월</input></li>");
			}
		}
		$("input:radio[name='month']").click(function(){
			month = $(this).val();
		});

		$("#btn1").on("click",function(){
			console.log(month);
 			location.href = "/gang/month_chart?month=" + month;
		});
		
		$("#btn2").on("click",function(){
			location.href="/gang/see_something";
			
		});
	});
	
	
});

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
    	<button class="bar-item button m_side" style="margin: 0; height:47px;cursor:default">${sessionScope.user.name}</button>
        <button onclick="document.getElementById('logout')" class="bar-item button m_side" id="logout" style="margin: 0">LOGOUT</button>
    </c:if>
    </div>
  </div>
</div>
	<div id="wrap">
		<div style='height: 100px'></div>
        <div id="img"></div>
		<h1>제주도 유동인구 분석 ${sessionScope}</h1>
        <hr>
		<div id="step1" style='height: 450px'>
			<h3>2015년 월별 유동인구 분석 결과</h3>
			<div id="chart_body">Chart 영역</div>
		</div>
		<hr>
        <div id="step2">
			<h3>2015년 월별 데이터 분석</h3>
			<ol id="dataList">
			</ol>
			<hr>
		</div>
		<div id="step3">
			<button type="button" id="btn1">선택년도 분석하기</button>
			<hr>
		</div>
		<div id="step4">
			<button type="button" id="btn2">돌아가기</button>
			<hr>
		</div>
	</div>
</body>
</html>
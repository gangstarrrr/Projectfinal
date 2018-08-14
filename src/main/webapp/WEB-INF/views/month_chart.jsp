<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta charset="UTF-8">
<title>테스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
</style>
<script>
$(document).ready(function(){
	console.log(getparam('month'));
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
			console.log(name);
		});
		$.ajax({
			type:"post",
			url:"/gang/readfile",
			data:{"name":name}
		}).done(function(data){
			var result = data.result;
			console.log(result);
		});
	});
	
	$("#btn2").on("click",function(){
		$.ajax({
			type:"post",
			url:"/gang/analysis",
			data:{"btn":'1',"month":month}
		}).done(function(data){
			name=data.name;
			console.log(name);
		});
		$.ajax({
			type:"post",
			url:"/gang/readfile",
			data:{"name":name}
		}).done(function(data){
			var result = data.result;
			console.log(result);
		});
	});
	
	
	$("#btn3").on("click",function(){
		location.href="/gang/see_something";
		
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
});
</script>
</head>
<body>
	<div id="wrap">
		<div style='height: 100px'></div>
        <div id="img"></div>
        <div id="step1"></div>
		
        <hr>
		<div id="step2">
			<div id="chart_body">Chart 영역</div>
			<button type="button" id="btn1" class="btn1">분석 & 결과보기</button>
			<hr>
		</div>
        <div id="step3">
			<div id="chart_body">Chart 영역</div>
			<button type="button" id="btn2" class="btn1">분석 & 결과보기</button>
			<hr>
		</div>
		<div id="step4">
			<button type="button" id="btn3" class="btn1">돌아가기</button>
			<hr>
		</div>
	</div>
</body>
</html>
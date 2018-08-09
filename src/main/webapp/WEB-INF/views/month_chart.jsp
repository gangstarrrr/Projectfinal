<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta charset="UTF-8">
<title>테스트</title>
<link rel="stylesheet" href="/eis/resources/css/common.css">
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
</style>

</head>
<body>
	<div id="wrap">
		<h1>?월 유동인구 분석</h1>
        <hr>
		<div id="step3">
			<h3>?월 시간당 유동인구 분석 결과</h3>
			<div id="chart_body">Chart 영역</div>
			<hr>
		</div>
        <div id="step4">
			<h3>?월 지역별 유동인구 분석 결과</h3>
			<div id="chart_body">Chart 영역</div>
			<hr>
		</div>
		<div id="step5">
			<button type="button" id="btn1" class="btn1">돌아가기</button>
			<hr>
		</div>
	</div>
</body>
</html>
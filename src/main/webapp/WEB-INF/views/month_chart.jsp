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
<link rel="stylesheet" type="text/css" href="/resources/css/see_something.css">
<style>
/*나중에 배경 투명도 조절해서 낮춰버리기*/
html, body {padding: 0; margin: 0;}
h1 {text-align: center; padding: 20px 0;}
#wrap {width: 80%; margin-left: 10%;}
#dataList li {cursor: pointer;list-style: none;text-align: center}
#dataList li:hover {background-color: #e8acc5;}
#bar_body {width: 100%; background-color: red; margin-bottom: 50px;}
#bar_div {width: 0%; height: 25px; background-color: red; text-align: center; font-weight: bold; color: white;}
.btn1 {width: 100%;; display: inline-block;}
.active {background-color: #b1c6e6;}
#chart_body {width: 100%; height: 300px;}
#img{background-image: url(/resources/img/%EA%B1%B8%EC%96%B4%EA%B0%90.gif);width: 220px;height: 190px;position: absolute;top: 40px;background-size: cover;}
#btn1{transform: translateY(130px);}
.area {
    position: absolute;
    background: #fff;
    border: 1px solid #888;
    border-radius: 3px;
    font-size: 12px;
    top: -5px;
    left: 15px;
    padding:2px;
}

.info {
    font-size: 12px;
    padding: 5px;
}
.info .title {
    font-weight: bold;
}
</style>
<script>
$(document).ready(function(){
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.378885, 126.530975), // 지도의 중심좌표
        level: 9, // 지도의 확대 레벨
        mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
    };

	// 지도를 생성한다 
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	if(<%=session.getAttribute("status")%>==null){
		alert("PLZ LOGIN FIRST");
		location.href="/see_something";
	}
	$("#logout").on("click",function(){
		location.href="/logout";
		alert("LOGOUT DONE");
	});
	var month=getparam('month');
	$("#step1").append("<h1>"+month+"월 유동인구 분석</h1>");
	$("#step2").prepend("<h3>"+month+"월 시간당 유동인구 분석 결과</h3>");
	$("#step3").prepend("<h3>"+month+"월 지역별 유동인구 분석 결과</h3>");
	
	$("#btn1").on("click",function(){
		var top = $('#gang').position().top;
		$(window).scrollTop( top );
		$("#loading2").show();
		$("#dark2").show();
 		$(document).on('scroll touchmove mousewheel', function(event) { 
			// 터치무브와 마우스휠 스크롤 방지    
			event.preventDefault();     
			event.stopPropagation();     
			return false; }); 
		$.ajax({
			type:"post",
			url:"/analysis",
			data:{"btn":'2',"month":month}
		}).done(function(data){
			name=data.name;
			$.ajax({
				type:"post",
				url:"/readfile",
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
	                    pointSize: 15,
	                    lineWidth: 8,
	                    legend : 'none',
	                    colors:['#7b9be2','#3d5f95']
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
			var top = $('#gang').position().top;
			$(window).scrollTop( top );
			$("#loading2").hide();
			$("#dark2").hide();
		    $(document).off('scroll touchmove mousewheel');
	});
});	
	$("#btn2").on("click",function(){
		var top = $('#gang').position().top;
		$(window).scrollTop( top );
		$(document).on('scroll touchmove mousewheel', function(event) { 
			// 터치무브와 마우스휠 스크롤 방지    
			event.preventDefault();     
			event.stopPropagation();     
			return false; });
		$("#loading2").show();
		$("#dark2").show();
		$.ajax({
			type:"post",
			url:"/analysis",
			data:{"btn":'1',"month":"03"}
		}).done(function(data){
			name=data.name;
			$.ajax({
				type:"post",
				url:"/readfile",
				data:{"name":name}
			}).done(function(data){
				var result = data.result;
				$.getJSON("resources/json/json.json", function(geojson) {
					 
				    var data = geojson.features;
				    var coordinates = [];    //좌표 저장할 배열
				    var name = '';            //행정 구 이름
				 
				    $.each(data, function(index, val) {
				 		
				        coordinates = val.geometry.coordinates;
				        name = val.properties.adm_nm;
				        displayArea(coordinates, name,result);
				    })
				})
				$("#map").empty();
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new daum.maps.LatLng(33.378885, 126.530975), // 지도의 중심좌표
			        level: 9 // 지도의 확대 레벨
			    };

			var map = new daum.maps.Map(mapContainer, mapOption),
			    customOverlay = new daum.maps.CustomOverlay({}),
			    infowindow = new daum.maps.InfoWindow({removable: true});

			/* // 지도에 영역데이터를 폴리곤으로 표시합니다 
			for (var i = 0, len = areas.length; i < len; i++) {
			    displayArea(areas[i]);
			} */
			
			// 다각형을 생상하고 이벤트를 등록하는 함수입니다
			function displayArea(coordinates, name,result) {
				var path = [];            //폴리곤 그려줄 path
			    var points = [];        //중심좌표 구하기 위한 지역구 좌표들
			  //new daum.maps.LatLng가 없으면 인식을 못해서 path 배열에 추가
			    for(var i=0;i<coordinates.length;i++){
			    	$.each(coordinates[i], function(index, coordinate) {        //console.log(coordinates)를 확인해보면 보면 [0]번째에 배열이 주로 저장이 됨.  그래서 [0]번째 배열에서 꺼내줌.
			    		 for(var j=0;j<coordinate.length;j++){
			        		var point = new Object(); 
			                point.x = coordinate[j][1];
			                point.y = coordinate[j][0];
			                points.push(point);
			                path.push(new daum.maps.LatLng(coordinate[j][1], coordinate[j][0]));  
			    		}
			    		 var color;
			    		for(var a=0; a<result.length;a++){
			    			if(name==result[a][0]){
				    			if(result[a][1]<=10000){
				    				color= '#f0b058';
				    			}else if(result[a][1]<=20000){
				    				color= '#e59931';
				    			}else if(result[a][1]<=30000){
				    				color= '#f08224';
				    			}else if(result[a][1]<=40000){
				    				color= '#e56617';
				    			}else if(result[a][1]<=50000){
				    				color= '#d83e10';
				    			}else{
				    				color= '#d1241d';
				    			}
				    				
				    		}	
			    		}	
			    		
			    	
			    	// 다각형을 생성합니다 
			    		var polygon = new daum.maps.Polygon({
			    	        map: map, // 다각형을 표시할 지도 객체
			    	        path: path,
			    	        strokeWeight: 2,
			    	        strokeColor: 'rgba(255, 255, 255, 0.5)',//이거는 선색
			    	        strokeOpacity: 0.8,
			    	        fillColor: color,//이거는 배경색
			    	        fillOpacity: 0.5 
			    	    }); 
			    		// 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
			    		daum.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
			    	        polygon.setOptions({fillColor: 'rgb(36, 36, 36)'});//이건 호버했을때 색
			    	     // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
			    	        customOverlay.setContent('<div class="area">' + name + '</div>');
			    	        
			    	        customOverlay.setPosition(mouseEvent.latLng); 
			    	        customOverlay.setMap(map);
			    	    });

			    	    // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
			    	    //daum.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
			    	        
			    	        //customOverlay.setPosition(mouseEvent.latLng); 
			    	    //});

			    	    // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
			    	    // 커스텀 오버레이를 지도에서 제거합니다 
			    	    daum.maps.event.addListener(polygon, 'mouseout', function() {
			    	        polygon.setOptions({fillColor: color});//마우스 떼졌을때 색 다시 돌아가는거
			    	        customOverlay.setMap(null);
			    	    });
			    	})
			    }

			}
			var top = $('#step3').position().top;
			$(window).scrollTop( top );
			$("#loading2").hide();
			$("#dark2").hide(); 
		    $(document).off('scroll touchmove mousewheel');
			});
			
		});
		
	});
	
	
	$("#btn3").on("click",function(){
		location.href="/see_something";
		
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
	 

</script>
</head>
<body>
<!-- 로딩이미지 -->
<div id="dark2" style="position: absolute; top: 0;left: 0; width: 100% ; height: 100%;display: none;background-color: rgba(255, 255, 255, 0.87); margin-left: : 0;z-index:10"></div>
<div id="loading2" style="position: absolute; top: 30%;left: 40%; width:400px;height:400px;background-image: url(/resources/img/loading_gif_servere.gif);z-index:10;background-position: center;background-size: cover;display:none">
</div>
<!-- Navbar -->
<div class="top">
  <div class="bar white wide padding card">
    <a href="/" class="bar-item button" id="gang"><b style="color:black">HōLA JEJU</b></a>
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
		<div style='height: 150px'></div>
        <div id="img"></div>
        <div id="step1"></div>
		
        <hr>
		<div id="step2" style='height: 500px'>
			<div id="chart_body">Chart 영역</div>
			<button type="button" id="btn1" class="btn1" style="background-color:#274a81">분석 & 결과보기</button>
		</div>
		<hr>
        <div id="step3" style='height: 700px'>
			<div id="map" style="width:1500px;height:650px;"></div>	
		</div>
		<button type="button" id="btn2" class="btn1" style="background-color:#274a81">분석 & 결과보기</button>
		<hr>
		<div id="step4">
			<button type="button" id="btn3" class="btn1" style="background-color:#272727">돌아가기</button>
			<hr>
		</div>
	</div>
</body>
</html>
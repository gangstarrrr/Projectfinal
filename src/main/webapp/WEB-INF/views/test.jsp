<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>
<html>
<head>
    <meta charset="utf-8">
    <title>다각형에 이벤트 등록하기2</title>
    <style>
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
</head>
<body>
<div id="map" style="width:600px;height:350px;"></div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd96e06027a0320acba403cccb6d68be&libraries=services,clusterer,drawing"></script>
<script>
// 지도에 폴리곤으로 표시할 영역데이터 배열입니다 

//행정구역 구분
$(document).ready(function(){
	$.ajax({
		type:"post",
		url:"/gang/analysis",
		data:{"btn":'1',"month":"03"}
	}).done(function(data){
		name=data.name;
		$.ajax({
			type:"post",
			url:"/gang/readfile",
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
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new daum.maps.LatLng(33.378885, 126.530975), // 지도의 중심좌표
		        level: 10 // 지도의 확대 레벨
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
			    				color= '#fff4d5';
			    			}else if(result[a][1]<=20000){
			    				color= '#ffb949';
			    			}else if(result[a][1]<=30000){
			    				color= '#ff7126';
			    			}else if(result[a][1]<=40000){
			    				color= '#f74a64';
			    			}else if(result[a][1]<=50000){
			    				color= '#cb1e67';
			    			}else{
			    				color= '#c40000';
			    			}
			    				
			    		}	
		    		}	
		    		
		    	//new daum.maps.LatLng가 없으면 인식을 못해서 path 배열에 추가
		    		var polygon = new daum.maps.Polygon({
		    	        map: map, // 다각형을 표시할 지도 객체
		    	        path: path,
		    	        strokeWeight: 2,
		    	        strokeColor: 'rgba(255, 255, 255, 0.5)',//이거는 선색
		    	        strokeOpacity: 0.8,
		    	        fillColor: color,//이거는 배경색
		    	        fillOpacity: 0.9 
		    	    }); 
		    		daum.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
		    	        polygon.setOptions({fillColor: 'rgb(36, 36, 36)'});//이건 호버했을때 색

		    	        customOverlay.setContent('<div class="area">' + name + '</div>');
		    	        
		    	        customOverlay.setPosition(mouseEvent.latLng); 
		    	        customOverlay.setMap(map);
		    	    });

		    	    // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
		    	    daum.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
		    	        
		    	        customOverlay.setPosition(mouseEvent.latLng); 
		    	    });

		    	    // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
		    	    // 커스텀 오버레이를 지도에서 제거합니다 
		    	    daum.maps.event.addListener(polygon, 'mouseout', function() {
		    	        polygon.setOptions({fillColor: color});//마우스 떼졌을때 색 다시 돌아가는거
		    	        customOverlay.setMap(null);
		    	    });
		    	})
		    }
		    // 다각형을 생성합니다 
		    
		    // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
		    // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
		     

		    // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다 
		/*     daum.maps.event.addListener(polygon, 'click', function(mouseEvent) {
		        var content = '<div class="info">' + 
		                    '   <div class="title">' + area.name + '</div>' +
		                    '   <div class="size">총 면적 : 약 ' + Math.floor(polygon.getArea()) + ' m<sup>2</sup></area>' +
		                    '</div>';

		        infowindow.setContent(content); 
		        infowindow.setPosition(mouseEvent.latLng); 
		        infowindow.setMap(map);
		    }); */
		}
			
		});
	});
})

		






</script>
</body>
</html>
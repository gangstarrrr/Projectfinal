<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>

<html>
<title>HOLA JEJU</title>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/see_something.css">
<link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
<script type="text/javascript">

// Get the modal
$(document).ready(function(){
	
	if(<%=session.getAttribute("status")%>==null){
		alert("PLZ LOGIN FIRST");
		location.href="/see_something";
	}
	
	//보드리스트 출력
	$.ajax({
		type:"post",
		url:"boardlist"
	}).done(function(data){
		var d = JSON.parse(data);
		var list = d.list;
		$(".type tbody").empty();
		var len;
		if(list.length>10){
			len=10;
		}else{
			len=list.length;
		}
		list_for(0,len,list);
		
		var list_num = Math.ceil(list.length/10);
		var before ="";
		var b_10;
		//보드 리스트 100개 넘으면 << >> 생김 아니면 안생겨
		if(list.length>100){
			b_10=10;
			$("#paging").append("<span><<</span>");
		}else{
			b_10=list_num;
		}
		
		for(var i=0;i<b_10;i++){
			var html1="<span>"+(i+1)+"</span>";
			$("#paging").append(html1);
		}
		
		if(list.length>100){
			$("#paging").append("<span>>></span>");
		}
		
		//보드 넘기는 버튼 눌렀을 때, document로 한 이유는 하위로 생긴 친구에게도 이벤트 먹이기 위해
 		$(document).on("click","#paging span",function(){	
 			$("#paging span").css("font-weight","normal");
			var bold=$(this).index();
 			var text=$(this).text();
			var index;
			var div = $(this).parent();
			var span=div.children();
			if(text=="<<"){
				//<<눌렀을때	
				var span_1=span.eq(1).text()
				//이미 1-10이면 1번째 눌리게
				if(span_1=="1"){
					index=0;
					bold=1;
				}else{
					bold=10;
					//아니면 그다음 10개 페이지 버튼 보여주고
					index=Number(span_1)-10;
					$("#paging").empty();
					var max_b;
					$("#paging").append("<span><<</span>");
					for(var i=index;i<index+10;i++){
						var html1="<span>"+(i)+"</span>";
						$("#paging").append(html1);
					}
					$("#paging").append("<span>>></span>");
					index-=1;
				}
			}else if(text==">>"){
			//>> 눌렀을때
				var span_1=span.eq(10).text()
				if(span_1==""){
					//이미 마지막 버튼 들이면 제일 마지막 버튼 눌렀을때와 같음
					index=list_num-1;
					bold=$("#paging span:last").index()-1;
				}else{
					bold=1;
					//아니면 그다음 열개 버튼 보이게
					index=Number(span_1)+1;
					$("#paging").empty();
					var max_b;
					//그다음 열개가 페이지 리스트보다 작으면 딱 페이지 리스트만 보이게
					if(list_num<index+9){
						max_b=list_num+1;
					}else{
						max_b=index+10;
					}
					$("#paging").append("<span><<</span>");
					for(var i=index;i<max_b;i++){
						var html1="<span>"+(i)+"</span>";
						$("#paging").append(html1);
					}
					$("#paging").append("<span>>></span>");
					index-=1;
				}
			}else{
			// >> 혹은 << 아닌 숫자 눌렀을때
				index = text-1;
			}
			$("#paging span").eq(bold).css("font-weight","bolder");
			$(".type tbody").empty();
			var max;
			//인덱스 위에서 구한거를 이제 여기서 리스트 출력
			if(list.length<index*10+10){
				//마지막 페이지에서 10개 못채울때의 에러를 피하기 위한 예외처리
				max=list.length;
			}else if(index==0){
				max=10;
			}else{
				max=index*10+10;
			}
			list_for(index*10,max,list);
			
			
		}); 


	});

	
	$("#insertboard").on("submit",function(){
		var queryString = $("#insertboard").serialize();
		$.ajax({
			type:"post",
			url:"insertboard",
			data:queryString
		}).done(function(data){
			var d = JSON.parse(data);
			alert(d.msg);
			location.href="/see_something?table=1";
			
		})
		return false;
	});
	

})
var modal = document.getElementById('insert');
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
var modal = document.getElementById('send');
var modal = document.getElementById('update');
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

jQuery(function ($) {
    $(".ret_date").shieldDatePicker({
   		events: {
           change: function (e) {   
        	   if($(".dep_date").attr('value')!=""){
        		   console.log(1);
        		   var dep = new Date($(".dep_date").attr('value'));
              	   var ret = new Date($(".ret_date").attr('value'));
              	 if(ret<dep){
              		 alert("PLZ CHECK YOUR DATE EXACTLY :()");
              		$( '.ret_date' ).removeAttr( 'value' );
               		$( '.dep_date' ).removeAttr( 'value' );
              		$(".sui-picker-input").val("");
              	 }
        	   }    	    
           }
    	},
    	min:new Date()
    });
    
});

jQuery(function ($) {
    $(".dep_date").shieldDatePicker({
   		events: {
            change: function (e) {
            	if($(".ret_date").attr('value')!=""){
            		console.log(2);	   
             	  var dep = new Date($(".dep_date").attr('value'));
             	  var ret = new Date($(".ret_date").attr('value'));
	               	if(ret<dep){
	               		alert("PLZ CHECK YOUR DATE EXACTLY :(");
	               		$( '.ret_date' ).removeAttr( 'value' );
	               		$( '.dep_date' ).removeAttr( 'value' );     		
	              		 $(".sui-picker-input").val("");
	              	 }
         	   }
            }
     	},
    	min:new Date()
     }); 

});
jQuery(function ($) {
    $(".ret_date_up").shieldDatePicker({
   		events: {
           change: function (e) {   
        	   if($(".dep_date_up").attr('value')!=""){
        		   console.log(1);
        		   var dep = new Date($(".dep_date_up").attr('value'));
              	   var ret = new Date($(".ret_date_up").attr('value'));
              	 if(ret<dep){
              		 alert("PLZ CHECK YOUR DATE EXACTLY :(");
              		$( '.ret_date_up' ).removeAttr( 'value' );
               		$( '.dep_date_up' ).removeAttr( 'value' );
              		$(".sui-picker-input").val("");
              	 }
        	   }
        	    
           }
    	},
    	min:new Date()
    });
    
});
jQuery(function ($) {
    $(".dep_date_up").shieldDatePicker({
   		events: {
            change: function (e) {
            	if($(".ret_date_up").attr('value')!=""){
            		console.log(2);	   
             	  var dep = new Date($(".dep_date_up").attr('value'));
             	  var ret = new Date($(".ret_date_up").attr('value'));
	               	if(ret<dep){
	               		alert("PLZ CHECK YOUR DATE EXACTLY :(");
	               		$( '.ret_date_up' ).removeAttr( 'value' );
	               		$( '.dep_date_up' ).removeAttr( 'value' );     		
	              		 $(".sui-picker-input").val("");
	              	 }
         	   }
            }
     	},
    	min:new Date()
     }); 

});


function cancle(){
	$('input[type=text]').val('');
	$('input[type=text]').removeAttr('value');
}

function msg(val){
	var td = val.children();
	var id = td.eq(5).text();
	$(".send").empty();
	$(".send").prepend("<h1>SEND TO '"+id+"'</h1>");
	document.getElementById('send').style.display='block';
	if(id==$("#from").val()){
		alert("NOT TO SEND A MESSAGE TO YOU :(")
		document.getElementById('send').style.display='none';
		id="";
	}
	var close;
	$(".close2").on("click",function(){
		id="";
		return false;
	});

	
	$("#sendmessage").on("submit",function(){
		console.log(id);
		if(id==""){
			return false;
		}
		var queryString = $("#sendmessage").serialize();
		$.ajax({
			type:"post",
			url:"sendmessage",
			data:queryString+ "&to_=" + id
		}).done(function(data){
			var d = JSON.parse(data);
			alert(d.msg);
			location.href="/see_something?table=1";
		})
		return false;
	});
	
};

function del(val){
	var td = val.children();
	var no = td.eq(1).text();
	console.log(no);
	$.ajax({
		type:"post",
		url:"deleteboard",
		data:{"no":no}
	}).done(function(data){
		var d = JSON.parse(data);
		alert(d.msg);
		location.href="/see_something?table=1";
	});
};

function up(val){
	document.getElementById('update2').style.display='block';
	var td = val.children();
	var no = td.eq(1).text();
	var con = td.eq(2).text();
	var date=td.eq(3).text().split("-");
	var dep = date[1]+"/"+date[2]+"/"+date[0];
	var date=td.eq(4).text().split("-");
	var ret = date[1]+"/"+date[2]+"/"+date[0];
	var id = td.eq(5).text();
	$(".con").val(con);
	$(".sui-picker-input:nth-child(1)").eq(2).val(dep);
	$(".sui-picker-input:nth-child(1)").eq(3).val(ret);
	$('input[name=dep_date]').attr('value',dep);
	$('input[name=ret_date]').attr('value',ret);
	if(id!=$("#id_up").val()){
		alert("NOT YOUR PERMITTION :(")
		document.getElementById('update2').style.display='none';
	}
	$("#updateboard").on("submit",function(){
		var queryString = $("#updateboard").serialize();
		$.ajax({
			type:"post",
			url:"updateboard",
			data:queryString+ "&no=" + no
		}).done(function(data){
			var d = JSON.parse(data);
			alert(d.msg);
			location.href="/see_something?table=1";
			
		}); 
		return false;
	});
}

function list_for(index,max,list){
	for(var i =index;i<max;i++){
		var html="<tr>";
		html+="<td>"+(list.length-i)+"</td>";
		html+="<td style='display:none;'>"+list[i].no+"</td>";
		html+="<td>"+list[i].content+"</td>";
		html+="<td>"+list[i].arr+"</td>";
		html+="<td>"+list[i].dep+"</td>";
		html+="<td>"+list[i].id+"</td>";
		html+="<td><div class='msg' onclick='msg($(this).parent().parent())'>쪽지</div></td>";
		html+="<td><div class='up' onclick='up($(this).parent().parent())'>수정</div></td>";
		html+="<td><div class='delete' onclick='del($(this).parent().parent())'>삭제</div></td>";
		html+="</tr>"
		$(".type tbody").append(html); 
	}
}
</script>
<style>
#no{width: 5%!important}
#con{width: 45%!important}
#dep{width: 10%!important}
#ret{width: 10%!important}
#id{width: 10%!important}
#mesage{width: 10%!important}
#update{width: 5%!important}
#del{width: 5%!important}
#home.content.wide{margin:0!important}
#table.type{width:100%!important}
#paging span:nth-child(n){
      padding: 0px 10px; text-decoration: underline;
 }
#paging span:hover{cursor: pointer}
</style>
    
<body>

<table class="type">
    <thead>
    <tr>
        <th scope="cols" id="no">No</th>
        <th scope="cols" id="con">Content</th>
        <th scope="cols" id="dep">Departing</th>
        <th scope="cols" id="ret">Returning</th>
        <th scope="cols" id="id">ID</th>
        <th scope="cols" id="mesage"></th>
        <th scope="cols" id="update"></th>
        <th scope="cols" id="del"></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <div id="paging" style="transform: translateY(100px);text-align: center;width: 100%;height: 20px">

            

    </div>
<!-- 글 작성 폼 -->
    
<div id="insert" class="modal">
  
  <form class="modal-content animate" id="insertboard">
    <div class="imgcontainer">
      <span onclick="document.getElementById('insert').style.display='none'; cancle();" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container">
      <h1>INSERT TABLE </h1>
      <p>Please fill in this form to create a table.</p>
      <hr>
      <label for="Content"><b>Content</b></label>
      <input type="text" placeholder="Enter Content" name="content" style="height:100px;"  maxlength="200" required>
      <input type="hidden" name="id" value="${sessionScope.user.id}">
      <label for="dep"><b>Departing Date</b></label>
      <input type='text' class="date dep_date" name ="dep_date"  required>
        
      <label for="ret"><b>Returning Date</b></label>
      <input type='text' class="date ret_date" name ="ret_date"  required>


      <div class="clearfix">
        <button type="button" onclick="document.getElementById('insert').style.display='none'; cancle();" class="cancelbtn2" style="background-color: #e55959;color:white">Cancel</button>
        <button type="submit" class="insertbtn" style="background-color:#6e9dcc;color:white">INSERT</button>
      </div>
    </div>
  </form>
</div>

<!-- 글 수정 폼 -->
    
<div id="update2" class="modal">
  
  <form class="modal-content animate" id="updateboard">
  <div class="imgcontainer">
      <span onclick="document.getElementById('update2').style.display='none'; cancle();" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container">
      <h1>UPDATE TABLE </h1>
      <p>Please fill in this form to update a table.</p>
      <hr>
      <label for="Content"><b>Content</b></label>
      <input type="text" placeholder="Enter Content" name="content" class="con" style="height:100px"  maxlength="200" required>
      <input type="hidden" name="id" id="id_up" value="${sessionScope.user.id}">
     <label for="dep"><b>Departing Date</b></label>
      <input type='text' class="date dep_date_up" name ="dep_date"  required>
        
      <label for="ret"><b>Returning Date</b></label>
      <input type='text' class="date ret_date_up" name ="ret_date"  required>


      <div class="clearfix">
        <button type="button" onclick="document.getElementById('update2').style.display='none'; cancle();" class="cancelbtn2" style="background-color: #e55959;color:white">Cancel</button>
        <button type="submit" class="insertbtn" style="background-color:#6e9dcc;color:white">UPDATE</button>
      </div>
    </div>
  </form>
</div>

<!-- 쪽지 보내기 폼 -->
<div id="send" class="modal">

  <form class="modal-content animate" method="post" id="sendmessage">
    <div class="imgcontainer">
      <span onclick="document.getElementById('send').style.display='none'; cancle();" class="close close2" title="Close Modal">&times;</span>
    </div>
    <div class="container">
    <div class="send"></div>
      <p>Please fill in this form to send a message.</p>
      <hr>
      <input type="hidden" name="from_" id="from" value="${sessionScope.user.id}">
      <label for="title"><b>TITLE</b></label>
      <input type="text" placeholder="Enter Title" name="title" maxlength="50" required>
	  <label for="message"><b>MESSAGE</b></label>
      <input type="text" placeholder="Enter message" name="message" style="height:100px"  maxlength="200" required>
    <div class="clearfix">
        <button type="button" onclick="document.getElementById('send').style.display='none'; cancle();" class="cancelbtn2 close2" style="background-color: #e55959;color:white">Cancel</button>
        <button type="submit" class="insertbtn" style="background-color:#6e9dcc;color:white">SEND</button>
      </div>    
    </div>   
  </form>
</div>

<button onclick="document.getElementById('insert').style.display='block'" id="btn">글작성</button>


</body>
</html>
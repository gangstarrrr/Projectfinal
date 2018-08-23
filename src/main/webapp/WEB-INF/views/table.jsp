<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>

<html>
<title>table</title>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/gang/resources/css/see_something.css">
<link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
<script type="text/javascript">

// Get the modal
$(document).ready(function(){
	
	if(<%=session.getAttribute("status")%>==null){
		alert("PLZ LOGIN FIRST");
		location.href="/gang/see_something";
	}
	
	
	$.ajax({
		type:"post",
		url:"boardlist"
	}).done(function(data){
		var d = JSON.parse(data);
		var list = d.list;
		$("tbody").empty();
		for(var i =0;i<list.length;i++){
			var html="<tr>";
			html+="<td>"+list[i].no+"</td>";
			html+="<td>"+list[i].content+"</td>";
			html+="<td>"+list[i].arr+"</td>";
			html+="<td>"+list[i].dep+"</td>";
			html+="<td>"+list[i].id+"</td>";
			html+="<td><div class='msg'>쪽지</div></td>";
			html+="<td><div class='up'>수정</div></td>";
			html+="<td><div class='delete'>삭제</div></td>";
			html+="</tr>"
			$("tbody").append(html); 
		}
		
		$(".delete").on("click",function(){
			var del=$(this);
			var tr = del.parent().parent();
			var td = tr.children();
			var no = td.eq(0).text();
			console.log(no);
			$.ajax({
				type:"post",
				url:"deleteboard",
				data:{"no":no}
			}).done(function(data){
				var d = JSON.parse(data);
				alert(d.msg);
				location.href="/gang/see_something?table=1";
			});
		});
		
		
		$(".msg").on("click",function(){

			var up=$(this);
			var tr = up.parent().parent();
			var td = tr.children();
			var id = td.eq(4).text();
			$(".container").prepend("<h1>SEND TO '"+id+"'</h1>");
			document.getElementById('send').style.display='block';
			if(id==$("#from_").val()){
				alert("NOT TO SEND A MESSAGE TO YOU")
				document.getElementById('send').style.display='none';
			}
			
			$("#sendmessage").on("submit",function(){
				var queryString = $("#sendmessage").serialize();
				$.ajax({
					type:"post",
					url:"sendmessage",
					data:queryString+ "&to_=" + id
				}).done(function(data){
					var d = JSON.parse(data);
					alert(d.msg);
					location.href="/gang/see_something?table=1";
				})
				return false;
			});
			
		});
		
		$(".up").on("click",function(){
			document.getElementById('update2').style.display='block';
			var up=$(this);
			var tr = up.parent().parent();
			var td = tr.children();
			var no = td.eq(0).text();
			var con = td.eq(1).text();
			$(".con").val(con);
			$("#updateboard").on("submit",function(){
				var queryString = $("#updateboard").serialize();
				console.log(no);
				//alert("잠깐");
				$.ajax({
					type:"post",
					url:"updateboard",
					data:queryString+ "&no=" + no
				}).done(function(data){
					var d = JSON.parse(data);
					alert(d.msg);
					location.href="/gang/see_something?table=1";
				}); 
				return false;
			});
		})

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
			modal.style.display = "none";
			location.href="/gang/see_something?table=1";
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
        	   console.log($(".sui-picker-input").val());
        	   console.log($(".ret_date").val());
        	   if($(".dep_date").val()!=""){
        		   console.log(1);
        		   var ret = new Date($(".ret_date").val());
              	   var dep = new Date($(".dep_date").val());
              	 if(ret<dep){
              		 alert("PLZ CHECK YOUR DATE EXACTLY");
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
            	console.log($(".sui-picker-input").val());
            	console.log($(".ret_date").val());
            	console.log($(".dep_date").val());
            	if($(".ret_date").val()!=""){
            		console.log(1);
         		   var ret = new Date($(".ret_date").val());
             	   var dep = new Date($(".dep_date").val());
	               	if(ret<dep){
	               		alert("PLZ CHECK YOUR DATE EXACTLY");
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
<!-- 글 작성 폼 -->
    
<div id="insert" class="modal">
  <span onclick="document.getElementById('insert').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content animate" id="insertboard">
    <div class="container">
      <h1>INSERT TABLE </h1>
      <p>Please fill in this form to create a table.</p>
      <hr>
      <label for="Content"><b>Content</b></label>
      <input type="text" placeholder="Enter Content" name="content" style="height:100px;" required>
      <input type="hidden" name="id" value="${sessionScope.user.id}">
      <label for="dep"><b>Departing</b></label>
      <input type='text' class="date dep_date" name ="dep_date"  required>
        
      <label for="ret"><b>Returning</b></label>
      <input type='text' class="date ret_date" name ="ret_date"  required>


      <div class="clearfix">
        <button type="button" onclick="document.getElementById('insert').style.display='none'" class="cancelbtn2" style="background-color: #e55959;color:white">Cancel</button>
        <button type="submit" class="insertbtn" style="background-color:#6e9dcc;color:white">INSERT</button>
      </div>
    </div>
  </form>
</div>

<!-- 글 수정 폼 -->
    
<div id="update2" class="modal">
  <span onclick="document.getElementById('update2').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content animate" id="updateboard">
    <div class="container">
      <h1>UPDATE TABLE </h1>
      <p>Please fill in this form to update a table.</p>
      <hr>
      <label for="Content"><b>Content</b></label>
      <input type="text" placeholder="Enter Content" name="content" class="con" style="height:100px" required>
      <input type="hidden" name="id" value="${sessionScope.user.id}">
     <label for="dep"><b>Departing</b></label>
      <input type='text' class="date dep_date" name ="dep_date"  required>
        
      <label for="ret"><b>Returning</b></label>
      <input type='text' class="date ret_date" name ="ret_date"  required>


      <div class="clearfix">
        <button type="button" onclick="document.getElementById('update2').style.display='none'" class="cancelbtn2" style="background-color: #e55959;color:white">Cancel</button>
        <button type="submit" class="insertbtn" style="background-color:#6e9dcc;color:white">UPDATE</button>
      </div>
    </div>
  </form>
</div>

<!-- 쪽지 보내기 폼 -->
<div id="send" class="modal">

  <form class="modal-content animate" method="post" id="sendmessage">
    <div class="imgcontainer">
      <span onclick="document.getElementById('send').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>

    <div class="container">
      <p>Please fill in this form to send a message.</p>
      <hr>
      <input type="hidden" name="from_" id="from" value="${sessionScope.user.id}">
      <label for="title"><b>TITLE</b></label>
      <input type="text" placeholder="Enter Title" name="title" required>
	  <label for="message"><b>MESSAGE</b></label>
      <input type="text" placeholder="Enter message" name="message" style="height:100px" required>
    <div class="clearfix">
        <button type="button" onclick="document.getElementById('send').style.display='none'" class="cancelbtn2" style="background-color: #e55959;color:white">Cancel</button>
        <button type="submit" class="insertbtn" style="background-color:#6e9dcc;color:white">SEND</button>
      </div>    
    </div>   
  </form>
</div>

<button onclick="document.getElementById('insert').style.display='block'" id="btn">글작성</button>


</body>
</html>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<title>to do something</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/gang/resources/css/see_something.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
<style>
#msg_list .solid
{width: 100%!important;
    padding: 12px 20px!important;
    margin: 8px 0!important;
    display: inline-block!important;
    border: 1px solid #ccc!important;
    box-sizing: border-box!important;}
</style>
<script>
$(document).ready(function(){

	var id = $('#id_').val();
	$.ajax({
		type:"post",
		url:"messagelist",
		data:{id:id}
	}).done(function(data){
		var d = JSON.parse(data);
		var list = d.list;
		$("#msg_list").empty();
		if(list.length==0){
			$("#msg_list").append("<p>You Don't Have Any Message.</p>")
		}else{
			$("#msg_list").append("<p>This is Your Message.</p>")
			for(var i =0;i<list.length;i++){
				var html="<div>";
				html+="<p style='display:none'>"+list[i].no+"</p>";
				html+="<label><b>FROM</b></label>";
				html+="<input type='hidden' name='no' value="+list[i].no+">";
				html+="<div class='from solid'>"+list[i].from_+"</div>";
				html+="<label><b>TITLE</b></label>";
				html+="<div class='title solid'>"+list[i].title+"</div>";
				html+="<label><b>MESSAGE</b></label>";
				html+="<div class='message solid' style='height:100px;word-wrap: break-word;'>"+list[i].message+"</div>";
				html+="<button type='button' class='delmsgbtn' style='background-color: #2f2d36;color:white'>DELETE</button>";
				html+="</div>";
				
				$("#msg_list").append(html);
			}
		}

		$(".delmsgbtn").on("click",function(){
			var del=$(this);
			var list=del.parent();
			var ch=list.children('p');
			var no=ch.eq(0).text();
			console.log(no);
			$.ajax({
				type:"post",
				url:"deletemessage",
				data:{"no":no}
			}).done(function(data){
				var d = JSON.parse(data);
				alert(d.msg);
				location.href="/gang/see_something?msg=1";
			});
		})
		
	})
	
	
	 $("#gochart").on("click",function(){
		 if(<%=session.getAttribute("status")%>==1){
			 	
			 location.href="/gang/chart";
			}else{
				alert("PLZ LOGIN FIRST");
			}
		 
		
	}); 
	
	$("#logout").on("click",function(){
		location.href="/gang/logout";
		alert("LOGOUT DONE");
	});
	
	$("#gotable").click(function(){
		if(<%=session.getAttribute("status")%>==1){
	 		$("#change").load("table");
	        localStorage.setItem("url", "table");	
		}else{
			alert("PLZ LOGIN FIRST");
		}
    });
	
	$("#login2").on("submit",function(){
		var queryString = $("#login2").serialize();
		$.ajax({
			type:"post",
			url:"login",
			data:queryString
		}).done(function(data){
			var d = JSON.parse(data);
			console.log(d.msg);
			alert(d.msg);
			location.href="/gang/see_something";
		})
		return false;
	});
	
	
	
    $('input[type="checkbox"][name="gender"]').click(function(){
        //클릭 이벤트 발생한 요소가 체크 상태인 경우
        if ($(this).prop('checked')) {
            //체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
            $('input[type="checkbox"][name="gender"]').prop('checked', false);
            $(this).prop('checked', true);
        }
    });

//Get the modal
var modal = document.getElementById('login');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
// Get the modal
var modal = document.getElementById('sign');
var modal = document.getElementById('checkm');
var modal = document.getElementById('infoupdate');
// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
};
var para = document.location.href.split("?");

if(para[1]=='table=1'){
	$("#change").load("table");
    localStorage.setItem("url", "table");	
}
if(para[1]=='msg=1'){
	document.getElementById('checkm').style.display='block';	
}
});

function signup(){
	alert("WELCOME TO SIGNUP");
}

function infoupdate(){
	alert("SUCCESS TO UPDATE YOUR INFOMATION");
}
var idCheck = 0;

function checkpw(){
	var password=$(".o_password").val();
	var id = $('#id_').val();
	console.log(password);
	console.log(id);
	$.ajax({
		data:{
			password : password,
			id:id
		},
		url:"checkpw",
		success : function(data){
			console.log(data);
			if (data == '1') {
                $(".o_password").css("background-color", "#B0F6AC");
                $(".signupbtn").prop("disabled", false);
                $(".signupbtn").css("background-color", "#6e9dcc");
            } else if (data == '0') {
                $(".signupbtn").prop("disabled", true);
                $(".signupbtn").css("background-color", "#aaaaaa");
                $(".o_password").css("background-color", "#FFCECE");
            } 
		}
	});
}

function checkId() {
    var id = $('.id').val();
    $.ajax({
        data : {
            id : id
        },
        url : "checkId",
        success : function(data) {
            if (data == '0') {
                $(".id").css("background-color", "#B0F6AC");
                $(".signupbtn").prop("disabled", false);
                $(".signupbtn").css("background-color", "#6e9dcc");
                idCheck = 1;
            } else if (data == '1') {
                $(".signupbtn").prop("disabled", true);
                $(".signupbtn").css("background-color", "#aaaaaa");
                $(".id").css("background-color", "#FFCECE");
                idCheck = 0;
            } 
        }
    });
}


function deleteuserbtn(){
	if(confirm("REALLY?")){
		var id = $('#id_').val();
		$.ajax({
			data:{id:id},
			url:"deleteuser",
			success : function(data){
				var d = JSON.parse(data);
				console.log(d.msg);
				alert(d.msg);
				if(d.status==0){
					location.href="/gang/see_something";
				}else{
					location.href="/gang/logout";
				}
			}
		});
	}else{
		return false;
	}
	
}

</script>
<body>
<input type="hidden" name="id" id="id_" value="${sessionScope.user.id}">
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
    	<button onclick="document.getElementById('checkm').style.display='block'" class="bar-item button m_side" style="margin: 0">MESSAGE</button>
        <button onclick="document.getElementById('logout')" class="bar-item button m_side" id="logout" style="margin: 0">LOGOUT</button>
    </c:if>
    </div>
  </div>
</div>
<!-- 로그인 폼 -->
<div id="login" class="modal">

  <form class="modal-content animate" method="post" id="login2">
      <span onclick="document.getElementById('login').style.display='none'" class="close" title="Close Modal">&times;</span>

    <div class="container">
      <label for="id"><b>ID</b></label>
      <input type="text" placeholder="Enter Username" name="id" required>

      <label for="password"><b>PASSWORD</b></label>
      <input type="password" placeholder="Enter Password" name="password" required>
        
      <button type="submit" style="background-color: #6e9dcc">Login</button>
    </div>

    <div class="container" style="background-color:#f1f1f1">
      <button type="button" onclick="document.getElementById('login').style.display='none'" class="cancelbtn" style="background-color: #e55959">Cancel</button>
    </div>
  </form>
</div>
    
<!-- 회원가입 폼 -->
    
<div id="sign" class="modal">
  <span onclick="document.getElementById('sign').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content animate" action="userInsert" onsubmit="signup()">
    <div class="container">
      <h1>SIGN UP</h1>
      <p>Please fill in this form to create an account.</p>
      <hr>
      <label for="id"><b>ID</b></label>
      <input type="text" placeholder="Enter id" name="id" class="id" oninput="checkId()" required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" required>
        
      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="Enter name" name="name" required>
        
      <label for="email"><b>Email</b></label>
      <input type="email" placeholder="Enter Email" name="email" required>
        
      <label for="intro"><b>Gender</b></label><br>
      <input type="checkbox" name="gender" value="남" checked="checked"> MALE<br>
      <input type="checkbox" name="gender" value="여"> FEMALE
        <br>
      <label for="intro"><b>Introduce</b></label>
      <input type="text" placeholder="Enter Your Plan" name="intro" style="height:100px"  required>

      <div class="clearfix">
        <button type="button" onclick="document.getElementById('sign').style.display='none'" class="cancelbtn2" style="background-color: #e55959">Cancel</button>
        <button type="submit" class="signupbtn" style="background-color:#6e9dcc">SIGN UP</button>
      </div>
    </div>
  </form>
</div>

<!-- 정보수정 폼 -->
    
<div id="infoupdate" class="modal" style="z-index:5;">
  <span onclick="document.getElementById('infoupdate').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content animate" action="infoupdate" onsubmit="infoupdate()">
    <div class="container">
      <h1>${sessionScope.user.id}'s INFOMATION UPDATE</h1>
      <p>Please fill in this form to update an account.</p>
      <hr>
      <label for="psw"><b>Before Password</b></label>
      <input type="password" placeholder="Enter Your Old Password" class="o_password" name="o_password" oninput="checkpw()" required>
        
      <label for="psw"><b>After Password</b></label>
      <input type="password" placeholder="Enter New Password" name="password" required>
        
      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="Enter name" name="name" value="${sessionScope.user.name}" required>
        
      <label for="email"><b>Email</b></label>
      <input type="email" placeholder="Enter Email" name="email" value="${sessionScope.user.email}" required>
        
      <label for="intro"><b>Gender</b></label><br>
      <input type="checkbox" name="gender" value="남" checked="checked"> MALE<br>
      <input type="checkbox" name="gender" value="여"> FEMALE
        <br>
      <label for="intro"><b>Introduce</b></label>
      <input type="text" placeholder="Enter Your Plan" name="intro" style="height:100px" value="${sessionScope.user.intro}" required>

      <div class="clearfix">
        <button type="button" onclick="document.getElementById('infoupdate').style.display='none'" class="cancelbtn2" style="background-color: #e55959">Cancel</button>
        <button type="submit" class="signupbtn" style="background-color:#6e9dcc">SIGN UP</button>
        <button type="button" class="deleteuserbtn" style="background-color:#2f2d36" onclick="deleteuserbtn()">LEAVE MEMBERSHIP</button>
      </div>
    </div>
  </form>
</div>

<!-- 쪽지 확인 폼 -->
<div id="checkm" class="modal" style="z-index:5!important;">
  <span onclick="document.getElementById('checkm').style.display='none'" class="close" title="Close Modal">&times;</span>
    <div class="container modal-content animate">
      <h1>MESSAGE BOX</h1>
      
      <div id="msg_list">
	      
    </div>
    <div class="clearfix">
        <button type="button" onclick="document.getElementById('checkm').style.display='none'" style="background-color: #e55959;color:white">Cancel</button>
    </div>
    </div>   
</div>

<!-- contents -->
<div id="change">
<div class="content wide" style="margin-left:0;" id="home">
    
<div class="display-middle margin-top center " style="left:10%">
    <h1 class="xxlarge text-white">
        <span class="padding black opacity-min"><b id="gochart" >CHART ANALYSIS</b></span></h1>
 </div>
    
<div class="display-middle margin-top center " style="right: 5%!important;" >
    <h1 class="xxlarge text-white">
        <span class="padding black opacity-min"><b id="gotable" >FIND YOUR TRAVELMATE</b></span></h1>
  
</div>
<div class="position_absoult left_img image"></div>
<div class="position_absoult right_img image"></div>
</div>
</div>
<div class="padding-large text-white display-bottom">
    갱's portfolio
</div>
</body>
</html>

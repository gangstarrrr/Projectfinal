<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<title>HOLA JEJU</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/resources/css/see_something.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" />
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
<style>
#msg_list_to .solid,#msg_list_from .solid
{width: 100%!important;
    padding: 12px 20px!important;
    margin: 8px 0!important;
    display: inline-block!important;
    border: 1px solid #ccc!important;
    box-sizing: border-box!important;}
img.avatar {
    width: 20vw;
    height:20vw;
    border-radius: 50%;
}
.imgcontainer {
    text-align: center;
    margin: 24px 0 12px 0;
    position: relative;
}
</style>
<script>
$(document).ready(function(){
	var id = $('#id_').val();
	$.ajax({
		type:"post",
		url:"messagelist_to",
		data:{id:id}
	}).done(function(data){
		var d = JSON.parse(data);
		var list = d.list;
		$("#msg_list_to").empty();
		if(list.length==0){
			$("#msg_list_to").append("<p>You Don't Have Any Received Message.</p>")
		}else{
			$("#msg_list_to").append("<p>This is Your Received Message.</p>")
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
				
				$("#msg_list_to").append(html);
			}
		}
		
		$.ajax({
			type:"post",
			url:"messagelist_from",
			data:{id:id}
		}).done(function(data){
			var d = JSON.parse(data);
			var list = d.list;
			$("#msg_list_from").empty();
			if(list.length==0){
				$("#msg_list_from").append("<p>You Don't Have Any Sent Message.</p>")
			}else{
				$("#msg_list_from").append("<p>This is Your Received Message.</p>")
				for(var i =0;i<list.length;i++){
					var html="<div>";
					html+="<p style='display:none'>"+list[i].no+"</p>";
					html+="<label><b>TO</b></label>";
					html+="<input type='hidden' name='no' value="+list[i].no+">";
					html+="<div class='from solid'>"+list[i].to_+"</div>";
					html+="<label><b>TITLE</b></label>";
					html+="<div class='title solid'>"+list[i].title+"</div>";
					html+="<label><b>MESSAGE</b></label>";
					html+="<div class='message solid' style='height:100px;word-wrap: break-word;'>"+list[i].message+"</div>";
					html+="<button type='button' class='delmsgbtn' style='background-color: #2f2d36;color:white'>DELETE</button>";
					html+="</div>";
					
					$("#msg_list_from").append(html);
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
					location.href="/see_something?table=1&msg=1";
				});
			})
		})

		
		
	})
	
	
	 $("#gochart").on("click",function(){
		 if(<%=session.getAttribute("status")%>==1){
			 	
			 location.href="/chart";
			}else{
				alert("PLZ LOGIN FIRST :)");
			}
		 
		
	}); 
	
	$("#logout").on("click",function(){
		location.href="/logout";
		alert("LOGOUT DONE");
	});
	
	$("#gotable").click(function(){
		if(<%=session.getAttribute("status")%>==1){
	 		$("#change").load("table");
	        localStorage.setItem("url", "table");	
		}else{
			alert("PLZ LOGIN FIRST :)");
		}
    });
	
	$("#login2").on("submit",function(event){
		event.preventDefault();
		var queryString = $("#login2").serialize();
		$.ajax({
			type:"post",
			url:"login",
			data:queryString
		}).done(function(data){
			var d = JSON.parse(data);
			console.log(d.msg);
			alert(d.msg);
			if(d.status==0){
				$('input[type=text]').val('');
				$('input[type=password]').val('');
				document.getElementById('login').style.display='block';
			}else{
				location.href="/see_something";
			}
			
		})
	});
	
	$("#signup").on("submit",function(event){
		event.preventDefault();
		if($("input[name=photo]").val()==""){
			$("input[name=photo]").val(null);
		}
		
 		$.ajax({
 			type:"post",
 			url:"userInsert",
 			data:new FormData($("#signup")[0]),
 			contentType:false,
            cache:false,
            processData:false
 		}).done(function(data){
 			alert("CONGRATULATIONS :)");
 			location.href="/see_something";
 		}); 
	})
	
	$("#info_btn").on("click",function(){
		$("input[type='text'][name='name']").val($("input[type='hidden'][name='name']").val());
		$("input[type='email'][name='email']").val($("input[type='hidden'][name='email']").val());
		$("input[type='text'][name='intro']").val($("input[type='hidden'][name='intro']").val());
	  var image = document.getElementById('up_img');
	  if($("#photo_dns").text()==""){
		  image.src = "/resources/img/img_avatar2.png";
	  }else{
		  image.src=$("#photo_dns").text();
	  }
	})
	
	$("#infoup").on("submit",function(event){
		event.preventDefault();
		if($("#photo_dns").val()==""){
			$("#photo_dns").val(null);
			console.log(1);
		}
		var id = $('#id_').val();	
		var formdata=new FormData($("#infoup")[0]);
		formdata.append('id', id);
		console.log(formdata);
		$.ajax({
			type:"post",
			url:"infoupdate",
			data:formdata,
 			contentType:false,
            cache:false,
            processData:false
		}).done(function(data){
			alert("SUCCESS TO UPDATE YOUR INFOMATION");
			location.href="/see_something";
		})
	})

	
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

// var para = document.location.href.split("?");
// var param = para[1].split("&");
// if(param[0]=='table=1'|param[1]=='table=1'){
// 	console.log(1);
// 	$("#change").load("table");
//     localStorage.setItem("url", "table");	
// }
// if(param[0]=='msg=1'|param[1]=='msg=1'){
// 	console.log(2);
// 	document.getElementById('checkm').style.display='block';	
// }
var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
	 if(vars[0]=='table'|vars[1]=='table'){
	 	$("#change").load("table");
	     localStorage.setItem("url", "table");	
	}
	if(vars[0]=='msg'|vars[1]=='msg'){
	 	document.getElementById('checkm').style.display='block';	
	}
	    
});

function readURL(input) { 
	if (input.files && input.files[0]) {
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$('.blah').attr('src', e.target.result); 
			} 
		reader.readAsDataURL(input.files[0]); 
		$('.blah_con').css("display", "block");
	} 

}

function checkpw(){
	var pw=$("#infoupdate input[name=password]").val();
	var pw2=$("#infoupdate input[name=password2]").val();
	var pwd=$("input[name=pwd]").val();
	var pwd2=$(".o_password").val();
	
	if (pwd==pwd2 & pw==pw2) {
	        $(".o_password").css("background-color", "#B0F6AC");
	        Matchpw(pw,pw2);
    } else if (pwd!=pwd2 & pw==pw2) {
	    	Matchpw(pw,pw2);
	    	disabled();
            $(".o_password").css("background-color", "#FFCECE");
    }else if (pwd==pwd2 & pw!=pw2) {
    		NotMatchpw(pw,pw2);
	        $(".o_password").css("background-color", "#B0F6AC");
	}else if (pwd!=pwd2 & pw!=pw2) {
			NotMatchpw(pw,pw2);
		    $(".o_password").css("background-color", "#FFCECE");
	} 
		
}

function checkId() {
	var pw=$("#sign input[name=password]").val();
	var pw2=$("#sign input[name=password2]").val();
    var id = $('.id').val();
    if($('.id').val()!=""){
        $.ajax({
            data : {
                id : id
            },
            url : "checkId",
            success : function(data) {
                if (data == '1' & pw!=pw2) {
                    $(".id").css("background-color", "#FFCECE");
                    NotMatchpw(pw,pw2);
                } else if (data == '1' & pw==pw2) {
                	Matchpw(pw,pw2);
                	disabled();
                    $(".id").css("background-color", "#FFCECE");
                }else if (data == '0' & pw!=pw2) {
                    NotMatchpw(pw,pw2);
                    $(".id").css("background-color", "#B0F6AC");
                } else if (data == '0' & pw==pw2) {
                    Matchpw(pw,pw2);
                    $(".id").css("background-color", "#B0F6AC");
                } 
            }
        });
    }else{
    	alert("PLZ INPUT ID FIRST :()");
    	$('input[type=password]').val('');
    }

}

function Matchpw(pw,pw2){
	if(pw!="" & pw2!=""){
		$("input[name=password]").css("background-color", "#B0F6AC");
		$("input[name=password2]").css("background-color", "#B0F6AC");
		abled();
	}else{
		disabled();
	}
}
function NotMatchpw(pw,pw2){
	if(pw!="" & pw2!=""){
		$("input[name=password]").css("background-color", "#FFCECE");
		$("input[name=password2]").css("background-color", "#FFCECE");
		disabled();
	}
}
function abled(){
	$(".signupbtn").prop("disabled", false);
	$(".signupbtn").css("background-color", "#6e9dcc");
}
function disabled(){
	$(".signupbtn").prop("disabled", true);
     $(".signupbtn").css("background-color", "#aaaaaa");
}


function cancle(){
	$('input[type=text]').val('');
	$('input[type=email]').val('');
	$('input[type=password]').val('');
	$('input[type=file]').val('');
	$('.blah').removeAttr('src');
	$('.blah_con').css("display", "none");
	$('input[type=text]').css('background-color','');
	$('input[type=password]').css('background-color','');
	$(".signupbtn").prop("disabled", false);
	$(".signupbtn").css("background-color", "#6e9dcc");
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
					location.href="/see_something";
				}else{
					location.href="/logout";
				}
			}
		});
	}else{
		return false;
	}
	
}

// function focusout(t){
// 	var len = t.val().length;
// 	console.log(len);
// 	if(len==0){
// 		return false;
// 	}
// 	if(len<5 | len>12){
// 		console.log("?");
// 		alert("YOUR VALUE LENGTH MUST BE BEWEEN 5 AND 12");
// 		t.val('');
// 		t.css('background-color','');
// 		t.focus();
// 	}
// }

// function engnum(obj) {
// 	 str = obj.val(); 
// 	 len = str.length; 
// 	 ch = str.charAt(0);
// 	 for(i = 0; i < len; i++) { 
// 	  ch = str.charAt(i); 
// 	  if( (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') ) { 
// 	   continue; 
// 	  } else { 
// 	   alert("ONLY ENGLISH AND NUMBER");
// 	   obj.val('');
// 	   obj.focus();
// 	   return false; 
// 	  } 
// 	 }
// 	 return true; 
// 	}

function focusout(obj) {
	var v=obj.val();
	if(v==""){
		return false; 
	}
    if(!/^[a-zA-Z0-9]{5,12}$/.test(v)) {
    	alert("YOUR VALUE LENGTH MUST BE BEWEEN 5 AND 12 :(");
        obj.val('');
        obj.focus();
        return false; 
    }
    var chk_num = v.search(/[0-9]/g);
    var chk_eng = v.search(/[a-z]/ig);
    if(chk_num < 0 || chk_eng < 0 ) {
        alert('PLA MIX ENGLISH AND NUMBER :()');
        obj.val('');
        obj.focus();
        return false; 
    }
    return true; 
} 


</script>
<body>
<input type="hidden" name="name" value="${sessionScope.user.name}">
<input type="hidden" name="pwd" value="${sessionScope.user.password}">
<input type="hidden" name="id" id="id_" value="${sessionScope.user.id}">
<input type="hidden" name="email" value="${sessionScope.user.email}">
<input type="hidden"  name="intro" value="${sessionScope.user.intro}" >
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
    	<button onclick="document.getElementById('infoupdate').style.display='block'" id="info_btn" class="bar-item button m_side" style="margin: 0; height:47px;">${sessionScope.user.name}'s INFO</button>
    	<button onclick="document.getElementById('checkm').style.display='block'" class="bar-item button m_side" style="margin: 0">MESSAGE</button>
        <button onclick="document.getElementById('logout')" class="bar-item button m_side" id="logout" style="margin: 0">LOGOUT</button>
    </c:if>
    </div>
  </div>
</div>
<!-- 로그인 폼 -->
<div id="login" class="modal">

  <form class="modal-content animate" method="post" id="login2">
  <div class="imgcontainer">
      <span onclick="document.getElementById('login').style.display='none'; cancle();" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container">
      <label for="id"><b>ID</b></label>
      <input type="text" placeholder="Enter Username" name="id" pattern=".{5,12}" required>

      <label for="password"><b>PASSWORD</b></label>
      <input type="password" placeholder="Enter Password" name="password" pattern=".{5,12}" required>
 	<div class="clearfix">
        <button type="button" onclick="document.getElementById('login').style.display='none'; cancle();" class="cancelbtn2" style="background-color: #e55959">Cancel</button>
        <button type="submit" class="signupbtn" style="background-color:#6e9dcc">LOGIN</button>
      </div>
    </div>
      
  </form>
</div>
    
<!-- 회원가입 폼 -->
    
<div id="sign" class="modal">
  <form class="modal-content animate" id="signup" enctype="multipart/form-data">
  <div class="imgcontainer">
      <span onclick="document.getElementById('sign').style.display='none'; cancle();" class="close" title="Close Modal">&times;</span>
      <img src="/resources/img/img_avatar2.png" alt="Avatar" class="avatar">
    </div>
    <div class="container">
      <h1>SIGN UP</h1>
      <p>Please fill in this form to create an account.</p>
      <hr>
      <label for="id"><b>ID</b></label>
      <input type="text" placeholder="Enter id (with english and numver / between 5-12)" name="id" class="id" onfocusout="focusout($(this))"  maxlength="12" oninput="checkId()" style="ime-mode:inactive" required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="Enter Password (with english and numver / between 5-12)" class="pwd" name="password" oninput="checkId()"  maxlength="12" onfocusout="focusout($(this))" required>
        
      <label for="psw"><b>Check Password</b></label>
      <input type="password" placeholder="Enter Password" name="password2" oninput="checkId()"  maxlength="12" onfocusout="focusout($(this))" required>  
        
      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="Enter name" name="name" required>
        
      <label for="email"><b>Email</b></label>
      <input type="email" placeholder="Enter Email" name="email" required>
        
      <label for="gender"><b>Gender</b></label><br>
      <input type="checkbox" name="gender" value="남" checked="checked"> MALE<br>
      <input type="checkbox" name="gender" value="여"> FEMALE
        <br>
      <label for="intro"><b>Introduce</b></label>
      <input type="text" placeholder="Enter Your Plan" name="intro" style="height:100px"  required>
	  <label for="intro"><b>Photo</b></label>
	  <input type="file" name="photo" class="file" onchange="readURL(this);">
	  <div class="imgcontainer blah_con" style="display:none">
      <img  src="#" alt="your image" class="avatar blah" />
    	</div> 
      <div class="clearfix">
        <button type="button" onclick="document.getElementById('sign').style.display='none'; cancle();" class="cancelbtn2" style="background-color: #e55959">Cancel</button>
        <button type="submit" class="signupbtn" style="background-color:#6e9dcc">SIGN UP</button>
      </div>
    </div>
  </form>
</div>

<!-- 정보수정 폼 -->
    
<div id="infoupdate" class="modal" style="z-index:5;">
  <form class="modal-content animate" id="infoup">
    <div class="imgcontainer">
      <span onclick="document.getElementById('infoupdate').style.display='none'; cancle();" class="close" title="Close Modal">&times;</span>
      <img id="up_img" alt="Avatar" class="avatar">
    </div>
    <div class="container">
      <h1>${sessionScope.user.id}'s INFOMATION UPDATE</h1>
      <p>Please fill in this form to update an account.</p>
      <hr>
      <label for="psw"><b>Old Password</b></label>
      <input type="password" placeholder="Enter Your Old Password" class="o_password" name="o_password"  maxlength="12" oninput="checkpw()"  required>
        
      <label for="psw"><b>New Password</b></label>
      <input type="password" placeholder="Enter New Password" name="password" oninput="checkpw()"  maxlength="12" onfocusout="focusout($(this))" required>
      
      <label for="psw"><b>Check New Password</b></label>
      <input type="password" placeholder="Enter Password" name="password2" oninput="checkpw()"  maxlength="12" onfocusout="focusout($(this))" required>  
      
        
      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="Enter name" name="name" maxlength="12" required>
<%--       <input type="hidden" name="photo_" id="photo_dns" value="${sessionScope.user.photo_dns}" required> --%>
      <div id="photo_dns" style="display:none">${sessionScope.user.photo_dns}</div>  
      <label for="email"><b>Email</b></label>
      <input type="email" placeholder="Enter Email" name="email" maxlength="20" required>
        
      <label for="intro"><b>Gender</b></label><br>
      <input type="checkbox" name="gender" value="남" checked="checked"> MALE<br>
      <input type="checkbox" name="gender" value="여"> FEMALE
        <br>
      <label for="intro"><b>Introduce</b></label>
      <input type="text" placeholder="Enter Your Plan" name="intro" style="height:100px"  maxlength="200">
	  <label for="file"><b>Photo</b></label>
	  <input class="file" type="file" name="photo" onchange="readURL(this);">
	  <div class="imgcontainer blah_con" style="display:none">
      <img  src="#" alt="your image" class="avatar blah" />
    	</div> 
      <div class="clearfix">
        <button type="button" onclick="document.getElementById('infoupdate').style.display='none'; cancle();" class="cancelbtn2" style="background-color: #e55959">Cancel</button>
        <button type="submit" class="signupbtn" style="background-color:#6e9dcc">UPDATE</button>
        <button type="button" class="deleteuserbtn" style="background-color:#2f2d36" onclick="deleteuserbtn()">LEAVE MEMBERSHIP</button>
      </div>
    </div>
  </form>
</div>

<!-- 쪽지 확인 폼 -->
<div id="checkm" class="modal" style="z-index:5!important;">
	<div class="modal-content animate">
	
	<div class="imgcontainer">
      <span onclick="document.getElementById('checkm').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container">
      <h1>MESSAGE BOX</h1>
      
      <div id="msg_list_to"></div>
      <hr>
      <h1>MESSAGE BOX</h1>
      <div id="msg_list_from"></div>
    <div class="clearfix">
        <button type="button" onclick="document.getElementById('checkm').style.display='none'" style="background-color: #e55959;color:white">Cancel</button>
    </div>
    </div>  
	
	</div>
	 
</div>

<!-- contents -->
<div id="change" class="wide">

   
<div class="change_div left_img image">
<div style="height:30%;"></div>
<h1 class="xxlarge text-white">
        <span class="padding" id="gochart">CHART ANALYSIS</span></h1>
</div>
<div class="change_div right_img image">
<div style="height:30%;"></div>
<h1 class="xxlarge text-white">
        <span class="padding" id="gotable">FIND YOUR TRAVELMATE</span></h1>
</div>

</div>
<div class="padding-large text-white display-bottom">
    갱's portfolio
</div>
</body>
</html>

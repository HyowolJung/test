<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
    line-height: 1.6;
}

a {
    color: #333;
    text-decoration: none;
}

a:hover {
    color: #555;
}

input[type="text"] {
    width: 100%;
    padding: 8px;
    margin: 5px 0 22px 0;
    display: inline-block;
    border: none;
    background: #f1f1f1;
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

button:hover {
    opacity: 0.8;
}
.logout-button {
  background-color: #007bff; /* 로그아웃 버튼 배경색 */
  color: #fff; /* 로그아웃 버튼 글자색 */
  border: none;
  padding: 5px 9px; /* 로그아웃 버튼 패딩값 조절 */
  border-radius: 4px; /* 로그아웃 버튼 모서리 둥글게 */
  text-decoration: none;
  cursor: pointer;
}

.logout-button:hover {
  background-color: #0056b3; /* 로그아웃 버튼 호버시 배경색 변경 */
}
</style>
</head>
<body>
<p style="text-align: center;">메인 페이지</p>

<br><br>
<!--style="display: none"  -->
<%-- <div id="LoginForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  id="member_Id_csrf"/>
	아이디 : <input type="text" id="member_Id" placeholder="부여받은 사번을 입력하세요." value="11111111"><br>
	혹은 99999999<br>
	비밀번호 : <input type="text" id="member_Pw" placeholder="본인의 전화번호 뒷자리를 입력하세요" value="1234"><br>
	<button id="login_Button">로그인</button><br>
</div> --%>

<form action="/login" method="post">
	<div>
		아이디 : <input type="text" id="member_Id" name="member_Id" placeholder="부여받은 사번을 입력하세요." value="95956301"><br>
	</div>
	<!-- 아이디 : <input type="text" id="member_Id" name="member_Id" placeholder="부여받은 사번을 입력하세요." value="user"><br> -->
	혹은 99999999<br>
	<div>
		비밀번호 : <input type="password" id="member_Pw" name="member_Pw" placeholder="본인의 전화번호 뒷자리를 입력하세요" value="1234"><br>
	</div>
	<!-- 비밀번호 : <input type="password" id="member_Pw" name="member_Pw" placeholder="본인의 전화번호 뒷자리를 입력하세요" value="user"><br> -->
	<button type="submit">로그인</button>
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<%-- <csrfInput /> --%>
</form>

</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#welcomeMessage").hide();
	/* let member_Id = $("#member_Id");
	let member_Id_csrf = $("#member_Id_csrf");
	let member_Pw = $("#member_Pw");
	$("#login_Button").click(function(){
		let member_Id_val = member_Id.val();
		let member_Id_csrf_val = member_Id_csrf.val();
		let member_Pw_val = member_Pw.val();
		
		$.ajax({
			type : 'POST',
			url: '/login',
			data: {
				"member_Id" :  member_Id_val,
				"member_Id_csrf" : member_Id_csrf.val,
			 	"member_Pw" : member_Pw_val
			},
			success : function(data) {
				if(data.length == 0){
					alert("로그인 실패");
					return;
				}
				location.href="/main";
			},	
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("로그인 실패");
			}
		});
	}); */	//$("#login_Button").click(function(){
});
</script>
</html>
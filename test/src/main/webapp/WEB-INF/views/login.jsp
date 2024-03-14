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

.container {
    max-width: 500px; /* 최대 너비 설정 */
    margin: 0 auto; /* 가운데 정렬 */
    padding: 20px; /* 패딩 추가 */
    background-color: white; /* 배경색 */
    border-radius: 8px; /* 모서리 둥글게 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

input[type="text"], input[type="password"] {
    width: 100%; /* 너비를 최대로 설정 */
    padding: 8px;
    margin-bottom: 20px; /* 하단 마진 설정 */
    display: inline-block;
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    background: #f1f1f1;
}

button, .logout-button {
    width: 100%; /* 너비를 최대로 설정 */
    padding: 14px 20px;
    margin-bottom: 20px; /* 하단 마진 설정 */
    border: none;
    border-radius: 4px; /* 모서리 둥글게 */
    cursor: pointer;
}

button:hover, .logout-button:hover {
    opacity: 0.8;
}
</style>
</head>
<body>
<div class="container">
    <p style="text-align: center;">환영합니다!</p>
    <br><br>
    <form action="/login" method="post">
        <div>
            아이디 <input type="text" id="memberId" name="memberId" placeholder="부여받은 사번을 입력하세요." value="99999999"><br>
        </div><br>
        <div>
            비밀번호 <input type="password" id="memberPw" name="memberPw"  value="1234"><br>
        </div><br>
        <button type="submit">로그인</button>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</div>
</body>
<%-- <style type="text/css">
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

input[type="password"] {
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
<p style="text-align: center;">환영합니다!</p>
<br><br>
<form action="/login" method="post">
	<div>
		아이디 <input type="text" id="member_Id" name="member_Id" placeholder="부여받은 사번을 입력하세요." value="99999999"><br>
	</div><br>
	<div>
		비밀번호 <input type="password" id="member_Pw" name="member_Pw"  value="1234"><br>
	</div><br>
	<button type="submit">로그인</button>
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

</body> --%>
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
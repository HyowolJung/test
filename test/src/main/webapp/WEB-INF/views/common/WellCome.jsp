<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
.user-info {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  padding: 5px; /* /* 원하는 패딩값 설정 */ */
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
<div class="user-info">
	${member_Id} 님 환영합니다. <a href="/logout" class="logout-button">로그아웃</a>
</div>
</body>
</html>
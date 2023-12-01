<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	테이블
	<table border="1">
		<thead>
			<tr>
				<th>ㅁ</th>
				<th>글 번호</th>
				<th>글 타입</th>
				<th>글 제목</th>
				<th>글 내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="boardList" items="${boardList}">
				<tr>
					<td><input type="checkbox" class="checkbox" name="checkbox"
						value="${boardList.BNO}" data-bno="${boardList.BNO}"></td>
					<td>${boardList.BNO }</td>
					<td>${boardList.BType }</td>
					<td>${boardList.BTitle }</td>
					<td>${boardList.BContent }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<button type="button" value="delete" id="deleteButton">삭제</button>
	<button type="button" value="modify" id="modifyButton">수정</button>
	<a href="/board/createB">추가</a>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//1. 체크 박스를 선택했을 때
			$(".checkbox").click(function() {
				var checkNum = $(this).data("bno");
				console.log("체크박스 번호: " + checkNum);

				$("#deleteButton").click(function() {
					console.log("삭제 버튼 클릭");

					$.ajax({
						type : 'get',
						url: '/board/deleteB',
						//dataType: 'json',
						data: {
							 "checkNum" : checkNum
						},
						success : function(result) { // 결과 성공 콜백함수        
							console.log(result);
							console.log("전송 성공");
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							console.log(error);
							console.log("전송 실패")
						}
					});	// $.ajax({
					
				});	// $("#deleteButton").click(function() {
				
				$("#modifyButton").click(function() {
					$.ajax({
						type : 'get',
						url: '/board/modifyB',
						//dataType: 'json',
						data: {
							 "checkNum" : checkNum
						},
						success : function(result) { // 결과 성공 콜백함수        
							console.log(result);
							console.log("전송 성공");
							//window.location.href = "/board/modifyB";
							window.location.href = "/board/boardModify.jsp";						
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							console.log(error);
							console.log("전송 실패")
						}
					});
				});
			});
		});
	</script>
</body>
</html>
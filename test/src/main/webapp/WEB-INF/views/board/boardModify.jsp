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
	도착했어요.
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>글 타입</th>
					<th>글 제목</th>
					<th>글 내용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardList" items="${boardList}">
				<tr>
					<td><input type="text" name="BNO" id="BNO" disabled="disabled" value ="${boardList.BNO }"/></td>
					<td><input type="text" name="BType" id="BType" value ="${boardList.BType }"/></td>
					<td><input type="text" name="BTitle" id="BTitle" value ="${boardList.BTitle }"/></td>
					<td><input type="text" name="BContent" id="BContent" value ="${boardList.BContent }"/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<button type="button" id="modifyButton">수정하기</button>
		


	</div>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		//var createButton = document.getElementById("create");
		$("#modifyButton").click(function() {
			console.log("수정버튼 클릭됨");
			
			let BNO = document.getElementById("BNO").value;
			let BType = document.getElementById("BType").value;
			let BTitle = document.getElementById("BTitle").value;
			let BContent = document.getElementById("BContent").value;
			
			console.log("BType : " , BType);	
			
			$.ajax({
				type : 'POST',
				url: '/board/modifyB',
				//dataType: 'json',
				data: {
					"BNO" : BNO,
					"BType" : BType,
					"BTitle" : BTitle,
					"BContent" : BContent
				},
				success : function(result) { // 결과 성공 콜백함수        
					alert("수정 성공");
					location.href = "/board/boardList";
				},    
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("수정 실패");
				}
			});
		});
	});
	</script>
</body>
</html>
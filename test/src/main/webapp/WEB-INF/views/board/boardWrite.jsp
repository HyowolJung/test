<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 1. Form 전송은 나중에 -->
<!-- <form id="insertForm">
	<div>
		<label>타입</label>
		<input type="text" name="BType">
	</div>
	<div>
      	<label>제목</label>
      	<input type="text" name="BTitle"  />
    </div>
    <div>
      	<label>내용</label>
      	<input type="text" name="BContent"  />
    </div>
</form> -->
<div>
	<input type="text" name="BType" id="BType"/>
	<input type="text" name="BTitle" id="BTitle"/>
	<input type="text" name="BContent" id="BContent"/>
</div>
<button type="button" value="create" id="create">추가</button>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	//var createButton = document.getElementById("create");
	$("#create").click(function() {
		console.log("추가버튼 클릭됨");
		
		let BType = document.getElementById("BType").value;
		let BTitle = document.getElementById("BTitle").value;
		let BContent = document.getElementById("BContent").value;
		
		console.log("BType : " , BType);	
		
		$.ajax({
			type : 'POST',
			url: '/board/createB',
			//dataType: 'json',
			data: {
				"BType" : BType,
				"BTitle" : BTitle,
				"BContent" : BContent
			},
			success : function(result) { // 결과 성공 콜백함수        
				alert("등록 성공");
				location.href = "/board/boardList";
			},    
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("등록 실패");
			}
		});
	});
});
</script>
</body>
</html>
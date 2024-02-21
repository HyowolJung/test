<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .form-container {
    display: flex;
    justify-content: space-between;
    width: 1000px;
  }
  .board_Type {
    width: 10%;
  }
  .board-title-input {
    width: 88%;
    height: 30px;
    margin-left: 2%;
  }
  /* .board-title-input {
    width: 997px;
    height: 30px;
  } */
  .board-content-textarea {
    width: 1000px; /* Adjusted to match cols attribute and container width */
    height: auto; /* Height is automatically adjusted based on rows attribute */
  }
  /* .hidden-input {
    display: none;
  } */
  .page-title {
	display: flex;
	align-items: center;
	width: 100%; /* 컨테이너의 너비를 지정 */
	position: relative; /* 버튼을 오른쪽 끝에 위치시키기 위한 기준점 제공 */
}

.page-title p {
	margin: 0 auto; /* 자동 마진을 사용하여 가운데 정렬 */
}

.page-title button {
	position: absolute; /* 절대 위치를 사용하여 오른쪽 끝에 배치 */
	right: 0; /* 오른쪽 끝에 위치 */
}

</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/WellCome.jsp"%><br><br>
	<form id="postForm" action="/board/comunity/insert" method="post">
		<div class="page-title">
			<p>게시글 작성<p>
			<button type="submit" id="submitButton">등록</button>
		</div><br>
		<input type="text" id="member_Id" name="member_Id" value="${member_Id}" class="hidden-input">
		<div class="form-container">
			<select id="board_Type" name="board_Type" class="board_Type">
				<option value="B00" selected="selected">선택</option>
				<option value="B01">자유게시판</option>
				<option value="B02">익명게시판</option>
				<option value="B03">사진게시판</option>
			</select>
			<input type="text" id="board_Title" name="board_Title" placeholder="제목을 입력해주세요" class="board-title-input">
		</div>
		<!-- <input type="text" name="board_Title" placeholder="제목을 입력해주세요" class="board-title-input"><br> -->
		<textarea id="board_Content" name="board_Content" rows="20" placeholder="내용을 입력해주세요" class="board-content-textarea"></textarea>
	</form>
	
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$("#postForm").submit(function(event) {
    var member_Id = $("#member_Id").val();
    var board_Type = $("#board_Type").val();
    var board_Title = $("#board_Title").val();
    var board_Content = $("#board_Content").val();

    // 조건 검사
    if (!board_Title) {
        alert("제목을 입력해주세요");
        event.preventDefault(); // 폼 제출 방지
        return false; // 이벤트 처리기 종료
    }

    if (!board_Content) {
        alert("내용을 입력해주세요");
        event.preventDefault(); // 폼 제출 방지
        return false; // 이벤트 처리기 종료
    }
    
    if(board_Type == "B00"){
    	alert("게시글 타입을 선택해주세요");
    	event.preventDefault(); // 폼 제출 방지
        return false;
    }
});
/* var member_Id = $("#member_Id").val();
var board_Title = $("#board_Title").val();
var board_Content = $("#board_Content").val();
$("#submitButton").click(function () {
	alert("member_Id : " + member_Id + "/ board_Title : " + board_Title + "/ board_Content : " + board_Content);
	if(!board_Title){
		alert("제목을 입력해주세요");
		return;
	}
	
	if(!board_Content){
		alert("내용을 입력해주세요");
		return;
	}
}); */
</script>
</body>
</html>
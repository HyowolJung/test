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
  .board-type {
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
  .hidden-input {
    display: none;
  }
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
	<form action="/board/comunity/insert" method="post">
		<div class="page-title">
			<p>게시글 작성<p>
			<button type="submit">등록</button>
		</div><br>
		<input type="text" name="member_Id" value="${member_Id}" class="hidden-input">
		<div class="form-container">
			<select name="Board_Type" class="board-type">
				<option value="" selected="selected">선택</option>
				<option value="B01">자유게시판</option>
				<option value="B02">익명게시판</option>
				<option value="B03">사진게시판</option>
			</select>
			<input type="text" name="board_Title" placeholder="제목을 입력해주세요" class="board-title-input">
		</div>
		<!-- <input type="text" name="board_Title" placeholder="제목을 입력해주세요" class="board-title-input"><br> -->
		<textarea name="board_Content" rows="20" placeholder="내용을 입력해주세요" class="board-content-textarea"></textarea>
	</form>
	<%-- <form action="/board/comunity/insert" method="post">
게시글 등록
<button type="submit">등록</button>
<input type="text" name ="member_Id" value="${member_Id}" style="display: none">
<!-- <label>제목</label> -->
<select id="Board_Type">
		<option value="" selected="selected">선택</option>
		<option value="B01">자유게시판</option>
		<option value="B02">익명게시판</option>
		<option value="B03">사진게시판</option>
	</select><br><br>
<input type="text" name="board_Title" placeholder="제목을 입력해주세요" style="width: 997px; height: 30px;"><br>
<!-- <label>게시글</label><br> -->
<!-- <input type="text" id="boardContent" style="width: 1000px; height: 300px;"> -->
<textarea name="board_Content" rows="20" cols="140" placeholder="내용을 입력해주세요"></textarea>
</form>
 --%>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>
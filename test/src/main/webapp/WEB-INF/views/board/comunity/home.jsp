<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.grid-container {
	display: grid;
	grid-template-columns: repeat(2, 1fr); /* 2개의 열로 구성 */
	grid-template-rows: repeat(2, 1fr); /* 2개의 행으로 구성 */
	gap: 10px; /* 구역 사이의 간격 */
	height: 100vh; /* 전체 화면 높이 */
	padding: 10px;
}

.grid-item {
	background-color: #f0f0f0; /* 배경색 */
	padding: 20px;
	text-align: center;
}

.get-Free-BoardList{
	font-size: 17px;
	line-height: 2.1;
	/* text-align: left; */
}

.board-item {
    max-width: 400px; /* 최대 너비 설정 */
    overflow: hidden; /* 내용이 넘치면 숨김 */
    text-overflow: ellipsis; /* 내용이 넘칠 때 말줄임표로 표시 */
    white-space: nowrap; /* 텍스트를 한 줄로 표시 */
    text-align: left;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/WellCome.jsp"%><br><br>
<div class="grid-container">
		<div class="grid-item">
			자유게시판
			<button id="insertBoard" onclick="submitPost()">등록하기</button>
			<br><br>
			<div class="get-Free-BoardList">
    			<c:forEach var="getFreeBoardList" items="${getFreeBoardList}">
        			<div class="board-item"><a href = "#" onclick="moveBoard('${getFreeBoardList.board_Title}')">${getFreeBoardList.board_Title}</a></div>
    			</c:forEach>
			</div>
		</div>

		<div class="grid-item">2</div>
    	<div class="grid-item">3</div>
    	<div class="grid-item">4</div>
</div>
<input type="text" id="member_Id" value="${member_Id}" disabled="disabled" ><br><!-- style="display: none" -->


</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
var member_Id = $("#member_Id").val();
function submitPost() {
	alert("클릭되었다. : " + member_Id);
    var form = $('<form></form>', {
        method: 'POST',
        action: '/board/comunity/insert'
    });

    // memberId와 pageNo 값을 input으로 추가
    form.append($('<input>', {
        type: 'hidden',
        name: 'member_Id',
        value: member_Id
    }));
    /* form.append($('<input>', {
        type: 'hidden',
        name: 'pageNo',
        value: pageNo
    })); */

    // 폼을 body에 추가하고 제출
    $('body').append(form);
    form.submit();
}

function moveBoard(board_Title) {
	alert("여기는 moveBoard()");
	var form = $('<form></form>', {
        method: 'POST',
        action: '/board/comunity/read'
    });

    // memberId와 pageNo 값을 input으로 추가
    form.append($('<input>', {
        type: 'hidden',
        name: 'member_Id',
        value: member_Id
    }));
   form.append($('<input>', {
        type: 'hidden',
        name: 'board_Title',
        value: board_Title
    }));

    // 폼을 body에 추가하고 제출
    $('body').append(form);
    form.submit();
	
}
</script>
</html>
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
/* .get-Free-BoardList td {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	max-width: 150px; 	
	display: block; 	
} */
.get-Free-BoardList{
	font-size: 17px;
	line-height: 2.1;
	text-align: left;
}

</style>
</head>
<body>
<div class="grid-container">
	<div class="grid-item">
   	자유게시판 <button id="insertBoard" onclick="submitPost()">등록하기</button><br>
	<div class = "get-Free-BoardList" >
		<c:forEach var="getFreeBoardList" items="${getFreeBoardList}"><br>
			<tr>
				<%-- <td>${getFreeBoardList.board_No}</td> --%>
				<td>${getFreeBoardList.board_Title}</td>
			<tr>
		</c:forEach>
	</div>
	<%-- <div class="get-Free-BoardList">
		<c:forEach var="getFreeBoardList" items="${getFreeBoardList}">
			<div>
            	<span>${getFreeBoardList.board_No}</span>
            	<span class="ellipsis">${getFreeBoardList.board_Title}</span>
        	</div>
   		 </c:forEach>
	</div> --%>
	</div>
	
	<div class="grid-item">2</div>
    <div class="grid-item">3</div>
    <div class="grid-item">4</div>
</div>
<input type="text" id="member_Id" value="${member_Id}" disabled="disabled" style="display: none"><br>


</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function submitPost() {
	
	var member_Id = $("#member_Id").val();
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
</script>
</html>
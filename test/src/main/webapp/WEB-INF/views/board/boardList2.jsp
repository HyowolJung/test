<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
	<div>
		<!-- <input name="bno" value=""> --> <!-- type="hidden" --> 
		<input name="pageNo" value="${pageDto.cri.pageNo }"><br> <!-- type="hidden" --> 
		<select name="searchField" class="form-select" 
	    		aria-label="Default select example" id="searchField">
		  <option value="title" <c:if test = "${pageDto.cri.searchField == 'title' }">selected</c:if>>제목</option>
		  <option value="content" ${pageDto.cri.searchField == 'content' ? 'selected' : ''}>내용</option>
		  <option value="writer" ${pageDto.cri.searchField == 'writer' ? 'selected' : ''}>작성자</option>
		</select>
		<!-- <label for="searchWord" class="visually-hidden">Password</label> -->
	    <input name="searchWord" type="text" class="form-control" 
	    		id="searchWord" placeholder="검색어" 
	    		value="${pageDto.cri.searchWord }">
		<button id="searchButton">검색</button>
	</div>
	
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
		<tbody >
			<c:forEach var="boardList" items="${boardList}">
				<tr id="boardListTR" class='boardListTR'>
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

	<div>
		<ul class="pagination" style= "list-style: none;">
			<c:if test="${pageDto.prev }">
				<li class="pagination_button" style= "float: left; margin-right: 10px"><a onclick="go(${pageDto.startNo-1 })" href="#" style= "float: left; margin-right: 10px">Previous</a>
				</li>
			</c:if>

			<c:forEach var="i" begin="${pageDto.startNo }" end="${pageDto.endNo }">
				<li class="page-item">
		    	<a class="page-link ${pageDto.cri.pageNo==i ? 'active':'' }" 
		    		onclick="go(${i})"
		    		href="#" style= "float: left; margin-right: 10px">${i }</a>
		    	</li>
			</c:forEach>
	
			<c:if test="${pageDto.next }">
				<li class="pagination_button" style= "float: left; margin-right: 10px"><a onclick="go(${pageDto.endNo + 1 })"  href="#" style= "float: left; margin-right: 10px">Next</a>
				</li>
			</c:if>
		</ul>
	</div>
	
	<br><br><br><br><br><br><br>
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
			<c:forEach var="boardList2" items="${boardList2}">
				<tr>
					<td><input type="checkbox2" class="checkbox2" name="checkbox2"
						value="${boardList2.BNO}" data-bno="${boardList2.BNO}"></td>
					<td>${boardList2.BNO }</td>
					<td>${boardList2.BType }</td>
					<td>${boardList2.BTitle }</td>
					<td>${boardList2.BContent }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
<script type="text/javascript">
$(document).ready(function() {
	//$("tr.boardListTR").hide();
	//1. 검색 폼
	$("#searchButton").click(function(){
		//$("tr.boardListTR").hide();
		
		let searchField = document.getElementById("searchField").value; 
		let searchWord = document.getElementById("searchWord").value;
		console.log("searchField : " , searchField);
		console.log("searchWord : " , searchWord);
		
		$.ajax({
			type : 'get',
			url: '/board/boardList',
			data: {
				 "searchField" :  searchField,
				 "searchWord" : searchWord
			},
			success : function(result) { // 결과 성공 콜백함수        
				//alert("검색 성공");
				//location.href = "/board/boardList";
				//location.href = "/board/boardList?searchField="+searchField+"?searchWord="+searchWord;
				//$("tr.boardListTR").show();
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("검색 실패");
			}
		});
		
		$.ajax({
			type : 'get',
			url: '/board/boardList2',
			data: {
				 "searchField" :  searchField,
				 "searchWord" : searchWord
			},
			success : function(result) { // 결과 성공 콜백함수
				console.log("값을 보냈어요");
				//alert("검색 성공");
				//location.href = "/board/boardList";
				//location.href = "/board/boardList?searchField="+searchField+"?searchWord="+searchWord;
				//$("tr.boardListTR").show();
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("검색 실패");
			}
		});
	});
	
	//1. 체크 박스를 선택했을 때
	$(".checkbox").click(function() {
		let checkNum = $(this).data("bno");
		console.log("체크박스 번호: " + checkNum);
		
		$("#deleteButton").click(function() {
			$.ajax({
				type : 'get',
				url: '/board/deleteB',
				data: {
					 "checkNum" : checkNum
				},
				success : function(result) { // 결과 성공 콜백함수        
					alert("삭제 성공");
					location.href = "/board/boardList";
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("삭제 실패");
				}
			}); //ajax EndPoint
		});	//#deleteButton EndPoint

		$("#modifyButton").click(function() {
			$.ajax({
				type : 'get',
				url: '/board/modifyB',
				data: {
					 "bno" : checkNum
				},
				success : function(result) { // 결과 성공 콜백함수        
					console.log(result);
					console.log("전송 성공");
					alert("수정 버튼 작동")
					//window.location.href = "/board/modifyB";
					location.href = "/board/modifyB?bno=" + checkNum;						
				},    
				error : function(request, status, error) { // 결과 에러 콜백함수        
					console.log(error);
					console.log("전송 실패")
				}
			});	//ajax EndPoint
		});	//#modifyButton EndPoint
		
		
	});	//.checkBox EndPoint
});//document EndPoint

function go(pageNo){
	$.ajax({
		type : 'get',
		url: '/board/boardList',
		data: {
			 "pageNo" : pageNo
		},
		success : function(result) { // 결과 성공 콜백함수        
			location.href = "/board/boardList?pageNo="+pageNo;
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint

</script>
</body>
</html>
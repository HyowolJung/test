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

	<input type="text" id="numberSearch" placeholder="번호 검색" width="300px" value="1"/>
	<button id="searchButton">검색</button>
	
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
<script type="text/javascript">
$(document).ready(function() {
	//1. 검색 폼
	$("#searchButton").click(function(){
		let numberSearch = document.getElementById("numberSearch").value;
		console.log("numberSearch : " , numberSearch);
		alert("검색 버튼 클릭 : " , numberSearch);
		
		$.ajax({
			type : 'get',
			url: '/board/boardList',
			data: {
				 "numberSearch" : numberSearch
			},
			success : function(result) { // 결과 성공 콜백함수        
				alert("검색 성공");
				//location.href = "/board/boardList";
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
	
	/* var listForm = $("#listForm");
	
	$(".pagination_button a").on("click", function(e) {
		e.preventDefault();
		
		listForm.find("input[name='pageNum']").val($(this).attr("href"));
		listForm.submit();
	}); */
	
	
	
});//document EndPoint

function go(pageNo){
	//var pageNo = document.getElementById("pageNo").value;
	//document.searchForm.pageNo.value = page;
	//document.searchForm.submit();
	//alert("pageNo : " , pageNo);
	console.log("페이지 번호 클릭! + pageNo : " , pageNo);
	$.ajax({
		type : 'get',
		url: '/board/boardList',
		data: {
			 "pageNo" : pageNo
		},
		success : function(result) { // 결과 성공 콜백함수        
			//console.log(result);
			//console.log("전송 성공");
			//alert("페이지 버튼 작동");
			//window.location.href = "/board/modifyB";
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
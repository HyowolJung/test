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
		<button id="searchButton">조회</button>
	</div>
	
	<table border="1">
		<thead>
			<tr>
				<th>ㅁ</th>
				<th>번호</th>
				<th>이름</th>
				<th>성별</th>
				<th>직급</th>
				<th>전화번호</th>
				<th>언어</th>
				<th>데이터베이스</th>
				<th>입사일</th>
				<!--<th>투입여부</th> -->
				
			</tr>
		</thead>
		<tbody >
			<c:forEach var="memberList" items="${memberList}">
				<tr id="boardListTR" class='boardListTR'>
					<td><input type="radio" class="checkbox" name="checkbox"
						value="${memberList.member_Id}" data-id="${memberList.member_Id}"></td>
					<td>${memberList.member_Id }</td>
					<td>${memberList.member_Name }</td>
					<c:if test="${memberList.member_Sex eq 'D011'}">
						<td>남자</td>
					</c:if>
					<c:if test="${memberList.member_Sex eq 'D012'}">
						<td>여자</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D028'}">
						<td>사원</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D027'}">
						<td>대리</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D026'}">
						<td>과장</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D025'}">
						<td>차장</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D024'}">
						<td>부장</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D023'}">
						<td>이사</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D022'}">
						<td>상무</td>
					</c:if>
					<c:if test="${memberList.member_Position eq 'D021'}">
						<td>사장</td>
					</c:if>
					<td>${memberList.member_Tel }</td>
					<c:if test="${memberList.member_Skill_Language eq 'S010'}">
						<td>JAVA</td>
					</c:if>
					<c:if test="${memberList.member_Skill_Language eq 'S011'}">
						<td>PYTHON</td>
					</c:if>
					<c:if test="${memberList.member_Skill_Language eq 'S012'}">
						<td>C++</</td>
					</c:if>
					<c:if test="${memberList.member_Skill_Language eq 'S013'}">
						<td>RUBY</td>
					</c:if>
					<c:if test="${memberList.member_Skill_DB eq 'S020'}">
						<td>ORACLE</td>
					</c:if>
					<c:if test="${memberList.member_Skill_DB eq 'S021'}">
						<td>MSSQL</td>
					</c:if>
					<c:if test="${memberList.member_Skill_DB eq 'S022'}">
						<td>MYSQL</td>
					</c:if>
					<c:if test="${memberList.member_Skill_DB eq 'S023'}">
						<td>POSTGRESQL</td>
					</c:if>
					<td>${memberList.member_startDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" value="delete" id="deleteButton">삭제</button>
	<button type="button" value="modify" id="modifyButton">수정</button>
	<!-- <a href="/member/insertMember">추가</a> -->
	<button onclick="insertMember();">등록</button>

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
<script type="text/javascript">
$(document).ready(function() {
	//$("tr.boardListTR").hide();
	
	//1. 검색 폼
	$("#searchButton").click(function(){
		
		let searchField = document.getElementById("searchField").value; 
		let searchWord = document.getElementById("searchWord").value;
		let search_ck = "1";
		console.log("searchWord : " + searchWord);
		
		//1. 조건 없이 조회하는거니까 그냥 전체 조회
		if(searchWord === "" || searchWord == null){
			//alert("검색어가 없어요.");
			$.ajax({
				type : 'POST',
				url: '/member/memberList',
				data: {
						"search_ck" : search_ck,
					},
				success : function(result) { // 결과 성공 콜백함수  
					//alert("검색어 없이 조회 성공");
					//console.log(result);
					return;
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("검색어 없이 조회 실패");
					return;
				}
			});
		}else {
			$.ajax({
				type : 'get',
				url: '/member/memberList',
				data: {
				 	"searchField" :  searchField,
				 	"searchWord" : searchWord,
				},
				success : function(result) { // 결과 성공 콜백함수  
					alert("검색 성공")
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("검색 실패");
				}
			});
		}
		
		//2. 조건 검색
		/* console.log("2")
		if(searchWord != null){ 
			$.ajax({
				type : 'get',
				url: '/member/memberList',
				data: {
				 	"searchField" :  searchField,
				 	"searchWord" : searchWord,
				 	"search_ck" : search_ck
				},
				success : function(result) { // 결과 성공 콜백함수  
					alert("검색 성공")
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("검색 실패");
				}
			});
		} */
	});
	
	//1. 체크 박스를 선택했을 때
	$(".checkbox").click(function() {
		let member_Id = $(this).data("id");
		console.log("체크박스 번호: " + member_Id);
		
		$("#deleteButton").click(function() {
			$.ajax({
				type : 'get',
				url: '/member/memberDelete',
				data: {
					 "member_Id" : member_Id
				},
				success : function(result) { // 결과 성공 콜백함수        
					alert("삭제 성공");
					location.href = "/member/memberList";
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("삭제 실패");
				}
			}); //ajax EndPoint
		});	//#deleteButton EndPoint

		$("#modifyButton").click(function() {
			$.ajax({
				type : 'get',
				url: '/member/memberModify',
				data: {
					 "member_Id" : member_Id
				},
				success : function(result) { // 결과 성공 콜백함수        
					console.log(result);
					console.log("전송 성공");
					alert("수정 버튼 작동")
					//window.location.href = "/board/modifyB";
					location.href = "/member/memberModify?member_Id=" + member_Id;						
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

function insertMember(){
	location.href = "/member/memberInsert";
}

</script>
</body>
</html>
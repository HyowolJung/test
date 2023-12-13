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
		<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }"><br> <!-- type="hidden" --> 
		<select name="searchField" class="form-select" 
	    		aria-label="Default select example" id="searchField">
		  <option value="title" <c:if test = "${pageDto.cri.searchField == 'name' }">selected</c:if>>이름</option>
		  <!-- TODO : SELECT 검색 고치기 -->
		  <option value="content" ${pageDto.cri.searchField == 'content' ? 'selected' : ''}>전화번호</option>
		  <option value="writer" ${pageDto.cri.searchField == 'writer' ? 'selected' : ''}>입사일</option>
		</select>
		<!-- <label for="searchWord" class="visually-hidden">Password</label> -->
	    <input name="searchWord" type="text" class="form-control" 
	    		id="searchWord" placeholder="검색어" 
	    		value="${pageDto.cri.searchWord }">
		<button id="searchButton">조회</button>
	</div>
	
	<table border="1" id="memberTable">
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
		<tbody>
			<c:forEach var="memberList" items="${memberList}">
				<tr id="boardListTR" class='boardListTR'>
					<%-- <td><input type="radio" class="checkbox" name="checkbox"
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
					<td>${memberList.member_startDate}</td> --%>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%-- <c:forEach var="memberList" items="${memberList}">
		<div id="memberList">			
			<input type="radio" class="checkbox" name="checkbox"
				value="${memberList.member_Id}" data-id="${memberList.member_Id}">
			${memberList.member_Id }
			${memberList.member_Name }
			<c:if test="${memberList.member_Sex eq 'D011'}">
				<p>남자</p>
			</c:if>
			<c:if test="${memberList.member_Sex eq 'D012'}">
				<p>여자</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D028'}">
				<p>사원</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D027'}">
				<p>대리</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D026'}">
				<p>과장</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D025'}">
				<p>차장</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D024'}">
				<p>부장</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D023'}">
				<p>이사</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D022'}">
				<p>상무</p>
			</c:if>
			<c:if test="${memberList.member_Position eq 'D021'}">
				<p>사장</p>
			</c:if>
			<p>${memberList.member_Tel }</p>
			<c:if test="${memberList.member_Skill_Language eq 'S010'}">
				<p>JAVA</p>
			</c:if>
			<c:if test="${memberList.member_Skill_Language eq 'S011'}">
				<p>PYTHON</p>
			</c:if>
			<c:if test="${memberList.member_Skill_Language eq 'S012'}">
				<p>C++</p>
			</c:if>
			<c:if test="${memberList.member_Skill_Language eq 'S013'}">
				<p>RUBY</p>
			</c:if>
			<c:if test="${memberList.member_Skill_DB eq 'S020'}">
				<p>ORACLE</p>
			</c:if>
			<c:if test="${memberList.member_Skill_DB eq 'S021'}">
				<p>MSSQL</p>
			</c:if>
			<c:if test="${memberList.member_Skill_DB eq 'S022'}">
				<p>MYSQL</p>
			</c:if>
			<c:if test="${memberList.member_Skill_DB eq 'S023'}">
				<p>POSTGRESQL</p>
			</c:if>
			${memberList.member_startDate}
		</div>	
	</c:forEach> --%>
	
	
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
	$("#memberTable tbody").empty();
    $("#memberTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
	//1. 검색 폼
	$("#searchButton").click(function(){
		let searchField = document.getElementById("searchField").value; 
		let searchWord = document.getElementById("searchWord").value;
		let search_ck = "1";
		let pageNo = document.getElementById("pageNo").value; 
		console.log("pageNo : " + pageNo);
		console.log("searchWord : " + searchWord);
		
		//1. 조건 없이 조회하는거니까 그냥 전체 조회
		if(searchWord === "" || searchWord == null){
			//alert("검색어가 없어요.");
			//1. 데이터 불러오기
			$.ajax({
				type : 'POST',
				url: '/member/memberList',
				data: {
						"search_ck" : search_ck,
						"pageNo" : pageNo
				},
				success : function(result) { // 결과 성공 콜백함수  
					$("#memberTable tbody").empty();
               		if(result != null){
               			for (let i = 0; i < result.length; i++) {
                        	let newRow = $("<tr>");
                        	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + result[i].member_Id + "' data-id='" + result[i].member_Id + "'></td>");
                        	newRow.append("<td>" + result[i].member_Id + "</td>");
                        	newRow.append("<td>" + result[i].member_Name + "</td>");
                        	newRow.append("<td>" + result[i].member_Sex + "</td>");
                        	newRow.append("<td>" + result[i].member_Position + "</td>");
                        	newRow.append("<td>" + result[i].member_Tel + "</td>");
                        	newRow.append("<td>" + result[i].member_Skill_Language + "</td>");
                        	newRow.append("<td>" + result[i].member_Skill_DB + "</td>");
                        	newRow.append("<td>" + result[i].member_startDate + "</td>");

                        	$("#memberTable tbody").append(newRow);
                    	}
                    	return;
               		}
               		if(result == null){
               			$("#memberTable tbody").empty();
               		    $("#memberTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
					}
				},
					error : function(request, status, error) { // 결과 에러 콜백함수        
						alert("검색어 없이 조회 실패");
						return;
					}
			});	//ajax EndPoint
		}//if EndPoint
		
		//2. 조건 검색
		if(searchWord !== "" || searchWord != null){ 
			$.ajax({
				type : 'POST',
				url: '/member/memberList',
				data: {
				 	"searchField" :  searchField,
				 	"searchWord" : searchWord,
				 	"search_ck" : search_ck,
				 	"pageNo" : pageNo
				},
				success : function(result) { // 결과 성공 콜백함수  
					$("#memberTable tbody").empty();
               		if(result != null){
               			for (let i = 0; i < result.length; i++) {
                        	let newRow = $("<tr>");
                        	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + result[i].member_Id + "' data-id='" + result[i].member_Id + "'></td>");
                        	newRow.append("<td>" + result[i].member_Id + "</td>");
                        	newRow.append("<td>" + result[i].member_Name + "</td>");
                        	newRow.append("<td>" + result[i].member_Sex + "</td>");
                        	newRow.append("<td>" + result[i].member_Position + "</td>");
                        	newRow.append("<td>" + result[i].member_Tel + "</td>");
                        	newRow.append("<td>" + result[i].member_Skill_Language + "</td>");
                        	newRow.append("<td>" + result[i].member_Skill_DB + "</td>");
                        	newRow.append("<td>" + result[i].member_startDate + "</td>");

                        	$("#memberTable tbody").append(newRow);
                    	}
                    	return;
               		}
               		if(result == null){
               			$("#memberTable tbody").empty();
               		    $("#memberTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
					}
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("검색 실패");
				}
			});
		}
	});

	
	//두 메서드의 차이는 무엇일까요? 단순히 바닐라와 제이쿼리 버전의 차이? 다른 이유도 있어요
	//$(document).on('click', '.radiobox', function() {});
	//$(".radiobox").click(function() {});
	
	/* $(".radiobox").click(function() { ... }); 코드는 페이지가 로드될 때 존재하는 모든 라디오 박스에 대해 클릭 이벤트 핸들러를 등록합니다. 그러나 동적으로 생성된 엘리먼트에 대한 이벤트 핸들러는 이 방식으로는 작동하지 않습니다.
	동적으로 생성된 엘리먼트에 대한 이벤트 핸들링을 위해서는 이벤트 위임(Event Delegation)을 사용해야 합니다. 이는 동적으로 생성된 엘리먼트가 특정한 상위 엘리먼트에 의해 관리되는 방식입니다.
	$(document).on('click', '.radiobox', function() { ... }); 코드에서는 document가 이벤트를 관리하는 상위 엘리먼트가 되어 동적으로 생성된 라디오 박스에도 이벤트가 적용됩니다. 이 방식을 사용하면 동적으로 생성된 엘리먼트에 대해서도 클릭 이벤트를 처리할 수 있습니다.
	만약 $(".radiobox").click(function() { ... }); 코드로 작성했을 때 작동하지 않는다면, 해당 라디오 박스가 동적으로 생성되었거나 이벤트가 등록되기 전에 실행되는 문제가 있을 수 있습니다. 이 경우 이벤트 위임을 사용하면 동적으로 생성된 엘리먼트에도 적용할 수 있습니다. */
	
	//1. 체크 박스를 선택했을 때
	$(document).on('click', '.radiobox', function() {
		console.log("체크박스");
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
			console.log("수정 버튼 작동")
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
	});//$(document).on('click', '.radiobox', function() { EndPoint
	
});//document EndPoint

function go(pageNo){
	$.ajax({
		type : 'POST',
		url: '/member/memberList',
		data: {
			 "pageNo" : pageNo
		},
		success : function(result) { // 결과 성공 콜백함수        
			location.href = "/member/memberList?pageNo="+pageNo;
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
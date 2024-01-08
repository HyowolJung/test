<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 조회</title>
  <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 20px;
        }

        div {
            margin-bottom: 20px;
        }

        input, select {
            margin-right: 10px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 10px;
            cursor: pointer;
        }

        #pagination {
            margin-top: 20px;
        }

        ul.pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li.page-item {
            margin-right: 10px;
        }

        a.page-link {
            text-decoration: none;
            padding: 8px 12px;
            border: 1px solid #ddd;
            color: #333;
            background-color: #fff;
            cursor: pointer;
        }

        a.page-link.active {
            background-color: #007bff;
            color: #fff;
        }

        .result-message {
            text-align: center;
            font-style: italic;
            color: #777;
        }
    </style>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
<div>
	<%-- <div>현재 ${pageDto.cri.pageNo } 페이지 입니다.</div><br> --%> <!-- id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" -->
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" type="hidden">
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
	  <option value="name" <c:if test = "${pageDto.cri.searchField == 'name' }">selected</c:if>>이름</option>
	  <option value="tel" ${pageDto.cri.searchField == 'tel' ? 'selected' : ''}>전화번호</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>입사일</label>
	<input type="date" name="searchDate" ${pageDto.cri.searchDate == 'date' ? 'selected' : ''} id = "searchDate" > <!-- ${pageDto.cri.searchField == 'date' ? 'selected' : ''} -->
	<button id="searchButton">조회</button>
</div>

<table border="1" id="memberTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<th>번호</th>
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>직급</th>
			<th>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>입사일</th>
			<!-- <th>상태</th> -->
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>

<button type="button" value="delete" id="deleteButton">삭제</button>
<button type="button" value="modify" id="modifyButton">수정</button>
<button onclick="insertMember();">등록</button>

<div id="pagination">
	<ul class="pagination" style= "list-style: none;">
	</ul>
</div>

<br><br><br><br><br><br><br>
</body>
<script type="text/javascript">
$(document).ready(function() {
	//let searchWord = $("#searchWord").val();
	//<input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
	//이렇게 하면 검색어를 입력하지 않았어도 최초 브라우저가 로딩되면 당연히 공백같은 값들이 들어가지..
	//우리는 입력된 값을 원하는 거지 value 값을 원하는게 아니잖아?
	//그러니까 .value 혹은 .val() 를 하는게 아니라 innerText 같은걸 써야지...
	
	$("#memberTable tbody").empty();
    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
    
    $("#memberTable").on("click", ".member-id", function () {
	    let member_Id = $(this).data("memberid");
	    window.location.href = "/member/memberRead?member_Id=" + member_Id;
	});
    
	//1. 검색 폼
	$("#searchButton").click(function(){
		let searchDate = $("#searchDate").val();
		let searchField = document.getElementById("searchField").value; 
		let searchWord = $("#searchWord").val();
		let search_ck = 1;
		let pageNo = document.getElementById("pageNo").value; 
		console.log("searchWord : " + searchWord);
		
		$.ajax({
			type : 'POST',
			url: '/member/memberList',
			data: {
			 	"searchField" :  searchField,
			 	"searchWord" : searchWord,
			 	"search_ck" : search_ck,
			 	"pageNo" : pageNo,
			 	"searchDate" : searchDate
			},
			success : function(resultMap) { // 결과 성공 콜백함수  
				var memberList = resultMap.memberList;
				var pageDto = resultMap.pageDto;
				$("#memberTable tbody").empty();
				
           		if (memberList && memberList.length > 0) {
					console.log("memberList가 있어요");               			
           			for (let i = 0; i < memberList.length; i++) {
                    	let newRow = $("<tr>");
                    	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	newRow.append("<td>" + memberList[i].member_No + "</td>");
                    	newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
                    	newRow.append("<td>" + memberList[i].member_Name + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Sex + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Position + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Tel + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_Language + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_DB + "</td>");
                    	newRow.append("<td>" + memberList[i].member_startDate + "</td>");
                    	//newRow.append("<td>" + memberList[i].member_status + "</td>");
                    	//newRow.append("<td style='color: red;'>" + "미구현" + "</td>");
                    	
                    	$("#memberTable tbody").append(newRow);
           			}
           			
           			var pagination = $("#pagination ul");
           	        pagination.empty();

           	        if (pageDto.prev) {
           	            pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
           	        }

           	        for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
           	            pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
           	        }

           	        if (pageDto.next) {
           	        	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
           	        }
           			
           		}else{
           			console.log("memberList 가 NULL 이에요.")
           			$("#memberTable tbody").empty();
           		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
           		}
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("검색 실패");
			}
		}); //$.ajax EndPoint
	});//$("#searchButton").click EndPoint
	
	//1. 체크 박스를 선택했을 때
	$(document).on('click', '.radiobox', function() {
		//console.log("체크박스");
		let member_Id = $(this).data("id");
		//console.log("체크박스 번호: " + member_Id);
		
		$("#deleteButton").click(function() {
			$.ajax({
				type : 'get',
				url: '/member/memberDelete',
				data: {
					 "member_Id" : member_Id
				},
				success : function(result) { // 결과 성공 콜백함수        
					alert("삭제 성공");
					location.href = "/member/memberList?pageNo=1";
				}, 
				error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("삭제 실패");
				}
			}); //ajax EndPoint
		});	//#deleteButton EndPoint

		$("#modifyButton").click(function() {
			//console.log("수정 버튼 작동");
			var pageNo = $("#pageNo").val();
			$.ajax({
				type : 'get',
				url: '/member/memberModify',
				data: {
					 "member_Id" : member_Id,
					 "pageNo" : pageNo
				},
				success : function(result) { // 결과 성공 콜백함수        
					location.href = "/member/memberModify?member_Id=" + member_Id + "&pageNo=" + pageNo;						
				},    
				error : function(request, status, error) { // 결과 에러 콜백함수        
					//console.log("전송 실패")
				}
			});	//ajax EndPoint
		});	//#modifyButton EndPoint
	});//$(document).on('click', '.radiobox', function() { EndPoint
	
});//document EndPoint

function go(pageNo){
	let searchField = document.getElementById("searchField").value; 
	let searchWord = document.getElementById("searchWord").value;
	//var pageNo = document.getElementById("pageNo").value; 
	$.ajax({
		type : 'POST',
		url: '/member/memberList',
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 "searchField" : searchField,
		},
		success : function(resultMap) { // 결과 성공 콜백함수    
			if (searchWord.trim() !== "") {
			    //console.log("검색어가 있습니다.");
			    location.href = "/member/memberList?pageNo=" + pageNo + "&searchWord=" + searchWord;
			} else {
			    //console.log("검색어가 없습니다.");
			    location.href = "/member/memberList?pageNo=" + pageNo;
			}
			
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
</html>

<%-- <c:forEach var="memberList" items="${memberList}">
				<tr> --%>
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
				<%-- </tr>
			</c:forEach> --%>
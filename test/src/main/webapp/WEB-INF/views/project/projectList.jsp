<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>프로젝트 목록 조회</title>
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
<%@include file="/WEB-INF/views/common/header.jsp" %><br><br>
<div>
	<!-- 사원 : 어떤 프로젝트 / 프로젝트 : 어떤 사원들 / 사원 : 어떤팀 + 팀원 -->
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo ? 1 : pageDto.cri.pageNo}" type="hidden"><!-- type="hidden" -->
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
	  <option value="id" <c:if test = "${pageDto.cri.searchField == 'id'}">selected</c:if>>아이디</option>
	  <option value="name" ${pageDto.cri.searchField == 'name' ? 'selected' : ''}>이름</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>시작일</label>
	<input type="date" name="searchDate" ${pageDto.cri.search_startDate == 'search_startDate' ? 'selected' : ''} id = "search_startDate" >
	~
	<label>종료일</label>
	<input type="date" name="searchDate" ${pageDto.cri.search_endDate == 'search_endDate' ? 'selected' : ''} id = "search_endDate" >
	<button id="searchButton">조회</button>
	<button id="searchButton">검색</button>
</div>
<table border="1" id="projectTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<!-- <th>번호</th> -->
			<th>프번</th>
			<th>이름</th>
			<th>고객사</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>시작일</th>
			<th>종료일</th>
		</tr>
	</thead>
	<tbody>
	
	</tbody>
</table>
	
<button type="button" value="delete" id="deleteButton">삭제</button>
<button type="button" value="modify" id="modifyButton">수정</button>
<!-- <a href="/member/insertMember">추가</a> -->
<button onclick="insertProject()">등록</button>

<div id="pagination">
	<ul class="pagination" style= "list-style: none;">
	</ul>
</div>
<br><br><br><br><br><br><br>
</body>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$("#projectTable tbody").empty();
$("#projectTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
//1. 검색 폼
$("#searchButton").click(function(){
	//let searchDate = $("#searchDate").val();
	//console.log("searchDate1 : " + searchDate);
	let searchField = document.getElementById("searchField").value; 
	let searchWord = $("#searchWord").val();
	let search_ck = "1";
	let pageNo = document.getElementById("pageNo").value; 
	
	$.ajax({
		type : 'POST',
		url: '/project/projectList',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
		data: {
			"searchField" :  searchField,
		 	"searchWord" : searchWord,
		 	"search_ck" : search_ck,
		 	"pageNo" : pageNo
		 	/* "searchDate" : searchDate */
		},
		success : function(resultMap) { // 결과 성공 콜백함수 
			console.log("success");
			var projectList = resultMap.projectList;
			var pageDto = resultMap.pageDto;
			$("#projectTable tbody").empty();
			
			if (projectList && projectList.length > 0) {
       			for (let i = 0; i < projectList.length; i++) {
                	let newRow = $("<tr>");
                	newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}''/>");
                	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + projectList[i].project_Id + "' data-id='" + projectList[i].project_Id + "'></td>");
                	newRow.append("<td>" + projectList[i].project_Id + "</a></td>");
                	newRow.append("<td><a href='/project/projectRead?project_Id="+ projectList[i].project_Id + "&pageNo="+ pageNo +"'>" + projectList[i].project_Name + "</td>");
                	newRow.append("<td>" + projectList[i].custom_company_id + "</td>");
                	newRow.append("<td>" + projectList[i].project_Skill_Language + "</td>");
                	newRow.append("<td>" + projectList[i].project_Skill_DB + "</td>");
                	newRow.append("<td>" + projectList[i].project_startDate + "</td>");
                	newRow.append("<td>" + (projectList[i].project_endDate === '1900-01-01' ? '미정' : projectList[i].project_endDate) + "</td>");
                	$("#projectTable tbody").append(newRow);
            	}
       			
       			var pagination = $("#pagination ul");
       			console.log("페이징번호 삭제");
       	        pagination.empty();
				//console.log("pageDto.startNo : " + pageDto.startNo);
				//console.log("pageDto.endNo : " + pageDto.endNo);
       	        
				if (pageDto.prev) {
       	            pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
       	         	/* pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>"); */
       	        }

       	        for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
       	            pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
       	        }

       	        if (pageDto.next) {
       	        	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
       	            /* pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>"); */
       	        }
       		}else{
       			console.log("projectList 가 NULL 이에요.")
       			$("#projectTable tbody").empty();
       		    $("#projectTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
       		}
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("조회 실패");
			//return;
		}
	});	//ajax EndPoint
});		//$("#searchButton").click(function(){ EndPoint
	
//★★★★★★★★★데이터 수집 공통
/* var checkList = [];
$('.checkbox:checked').each(function() {
	let row = $(this).closest('tr');
	let member_Idqq = row.find('td:eq(1)').text();
	console.log("member_Idqq : " + member_Idqq);
}); */
//console.log("checkList : " + checkList);	
	/* let data = {
		row.find()			
	} */
	
	
	/* newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + projectList[i].project_Id + "' data-id='" + projectList[i].project_Id + "'></td>");
	newRow.append("<td>" + projectList[i].project_Id + "</a></td>");
	newRow.append("<td><a href='/project/projectRead?project_Id="+ projectList[i].project_Id + "&pageNo="+ pageNo +"'>" + projectList[i].project_Name + "</td>");
	newRow.append("<td>" + projectList[i].custom_company_id + "</td>");
	newRow.append("<td>" + projectList[i].project_Skill_Language + "</td>");
	newRow.append("<td>" + projectList[i].project_Skill_DB + "</td>");
	newRow.append("<td>" + projectList[i].project_startDate + "</td>");
	newRow.append("<td>" + (projectList[i].project_endDate === '1900-01-01' ? '미정' : projectList[i].project_endDate) + "</td>"); */

	
	/* $('.checkbox:checked').each(function() {
		let row = $(this).closest('tr');
		let member_Idqq = row.find('td:eq(1)').text();
		//console.log("member_Idqq : " + member_Idqq);
		checkList.push(member_Idqq);
		console.log("checkList : " + checkList);
	}); */
	/* $(document).on('click', '.checkbox', function() {
		// 클릭된 체크박스가 속한 행(<tr>)을 찾습니다.
		var $row = $(this).closest('tr');

        // 해당 행에서 필요한 데이터를 수집합니다.
        var memberData = {
            //member_Id: $row.find("td a").text(), // member_Id는 링크 텍스트로부터 가져옵니다.
           	project_Id: $row.find("td:nth-child(2)").text(),
            //member_Sex: $row.find("td:nth-child(4)").text(),
            //member_Position: $row.find("td:nth-child(5)").text(),
            //member_Department: $row.find("td:nth-child(6)").text(),
            //member_Tel: $row.find("td:nth-child(7)").text(),
            //member_Skill_Language: $row.find("td:nth-child(8)").text(),
            //member_Skill_DB: $row.find("td:nth-child(9)").text(),
            //member_startDate: $row.find("td:nth-child(10)").text(),
            //member_endDate: $row.find("td:nth-child(11)").text() // '미정' 포함
        };
		
        checkList.push(memberData)
        // 수집된 데이터를 콘솔에 출력합니다. 실제 사용 시에는 이 데이터를 다른 방식으로 사용할 수 있습니다.
        console.log("checkList : " + checkList);
	}); */
	
			
$("#deleteButton").click(function() {
	var checkList = [];
	$('.checkbox:checked').each(function() {
		checkList.push($(this).val());
	});
	
	//alert("checkList : " + checkList);
	$.ajax({
		type : 'POST',
		url: '/project/deleteProject',
		contentType: 'application/json',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
		data: JSON.stringify(checkList),
		success : function(result) { // 결과 성공 콜백함수        
			if(result != null) {
				alert("삭제 성공");
				location.href = "/project/projectList?pageNo=1";
			} else {
				alert("삭제 실패")
			}
		}, 
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("투입된 회원이 있는 프로젝트는 삭제할 수 없어요.");
		}
	}); //ajax EndPoint
});	//#deleteButton EndPoint	
	
/* $("#modifyButton").click(function() {
//console.log("수정 버튼 작동");
var pageNo = $("#pageNo").val();
//console.log("ddd");
//console.log("project_Id : " + project_Id);
$.ajax({
	type : 'get',
	url: '/project/projectModify',
	data: {
		 "project_Id" : project_Id,
		 "pageNo" : pageNo
	},
	success : function(result) { // 결과 성공 콜백함수        
		location.href = "/project/projectModify?project_Id=" + project_Id + "&pageNo=" + pageNo;						
	},    
	error : function(request, status, error) { // 결과 에러 콜백함수        
		//console.log(error);
		//console.log("전송 실패")
	}
});	//ajax EndPoint
});	//#modifyButton EndPoint
});//$(document).on('click', '.radiobox', function() { EndPoint */	
	
function go(pageNo){
	let searchField = document.getElementById("searchField").value; 
	let searchWord = document.getElementById("searchWord").value;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		type : 'POST',
		url: '/project/projectList',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 "searchField" : searchField
		},
		success : function(resultMap) { // 결과 성공 콜백함수    
			if (searchWord.trim() !== "") {
			    //console.log("검색어가 있습니다.");
			    location.href = "/project/projectList?pageNo=" + pageNo + "&searchWord=" + searchWord;
			} else {
			    //console.log("검색어가 없습니다.");
			    location.href = "/project/projectList?pageNo=" + pageNo;
			}
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint

function insertProject(){
	location.href = "/project/projectInsert";
}
</script>
</html>
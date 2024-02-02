<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
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
            text-align: left;
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
<body>
<div>
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" type="hidden"><!-- type="hidden" -->
	사원 아이디 : <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
	<%-- <select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
		<option selected>고객사</option>
    	<option value="D062" ${pageDto.cri.searchField == 'D062' ? 'selected' : ''}>엘지</option>
    	<option value="D065" ${pageDto.cri.searchField == 'D065' ? 'selected' : ''}>아마존</option>
		<option value="D061" ${pageDto.cri.searchField == 'D061' ? 'selected' : ''}>삼성</option>
		<option value="D063" ${pageDto.cri.searchField == 'D063' ? 'selected' : ''}>애플</option>
		<option value="D064" ${pageDto.cri.searchField == 'D064' ? 'selected' : ''}>구글</option>
	</select> --%>
   	<label>시작일</label>
   	<input type="date" name="searchDate" ${pageDto.cri.search_startDate == 'search_startDate' ? 'selected' : ''} id = "search_startDate" onblur="validateDate1()">
	~
	<label>종료일</label>
	<input type="date" name="searchDate" ${pageDto.cri.search_endDate == 'search_endDate' ? 'selected' : ''} id = "search_endDate" onblur="validateDate2()">
	<button id="searchButton">검색</button>
	<button id="insert">추가</button>	
</div>


<input type="text" id="result_project_Id" readonly style="display: none"/>
<input id="project_Name" name="project_Name" value="${project_Name}" style="display: none">

<%-- <input id="project_Name" name="project_Name" value="${project_Data.project_Name}"> 
<c:out value="${project_Name}"></c:out> --%>

<table border="1" id="memberTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<!-- <th style="display: none">번호</th> -->
			<th>아이디</th>
			<th>이름</th>
			<th>직급</th>
			<th>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<!-- <th>투입일</th> -->
			<!-- <th>철수일</th> -->
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>	

<div id="pagination">
	<ul class="pagination" style= "list-style: none;">
	</ul>
</div>	

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
const urlParams = new URLSearchParams(window.location.search);
const project_Id = urlParams.get('project_Id');
$("#result_project_Id").val(project_Id);
let project_Name = $("#project_Name").val();

$("#memberTable tbody").empty();
$("#memberTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
$(document).ready(function() {
	var project_Name = "${project_Name}"; // JSP 템플릿 엔진을 사용한 방식
    console.log("프로젝트 이름: " + project_Name);
	
	$("#searchButton").click(function(){
		let search_startDate = $("#search_startDate").val();
		let search_endDate = $("#search_endDate").val();
		//let searchField = document.getElementById("searchField").value; 
		let searchWord = $("#searchWord").val();
		let pageNo = document.getElementById("pageNo").value; 
		alert("searchButton 버튼이 클릭: " + searchWord, search_startDate, search_endDate);
		$.ajax({
			type : 'POST',
			url: '/popup/popMember',
			data: {
				//"searchField" : searchField,
			 	"searchWord" : searchWord,
			 	"pageNo" : pageNo,
			 	"project_Id" : project_Id,
			 	"project_Name" : project_Name,
			 	"search_startDate" : search_startDate,
			 	"search_endDate" : search_endDate
			},
			success : function(resultMap) { // 결과 성공 콜백함수 
				console.log("success");
				//alert("resultMap : " + resultMap);
				var memberList = resultMap.memberList;
				var pageDto = resultMap.pageDto;
				$("#memberTable tbody").empty();
				
				if (memberList && memberList.length > 0) {
	       			for (let i = 0; i < memberList.length; i++) {
	                	var newRow = $("<tr>");
	                	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	//newRow.append("<td hidden>" + memberList[i].member_No + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Id + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Name + "</td>");
                    	//newRow.append("<td>" + memberList[i].member_Position + "</td>");
                    	newRow.append("<td>" + (memberList[i].member_Position === null ? '미정' : memberList[i].member_Position) + "</td>");
                    	//newRow.append("<td>" + (projectList[i].custom_company_id === null ? '미정' : projectList[i].custom_company_id) + "</td>");
                    	//newRow.append("<td>" + (projectList[i].custom_company_id === null ? '미정' : projectList[i].custom_company_id) + "</td>");
                    	//newRow.append("<td>" + (projectList[i].custom_company_id === null ? '미정' : projectList[i].custom_company_id) + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Tel + "</td>");
                    	//newRow.append("<td>" + memberList[i].member_Skill_Language + "</td>");
                    	newRow.append("<td>" + (memberList[i].member_Skill_Language === null ? '미정' : memberList[i].member_Skill_Language) + "</td>");
                    	//newRow.append("<td>" + memberList[i].member_Skill_DB + "</td>");
                    	newRow.append("<td>" + (memberList[i].member_Skill_DB === null ? '미정' : memberList[i].member_Skill_DB) + "</td>");
                    	//newRow.append("<td><input type='date' name='pushdate')></td>");
                    	//newRow.append("<td><input type='date' name='pulldate')></td>");
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
	       		    $("#memberTable tbody").html("<tr><td colspan='10' style='text-align:center;'>결과가 없어요.</td></tr>");
	       		}
			},
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("조회 실패");
			}
		});	//ajax EndPoint
	});	//$("#searchButton").click(function(){ EndPoint

	$("#insert").click(function() {
		var selectedRowData = [];

	    // 모든 선택된 체크박스를 순회
	    $('.checkbox:checked').each(function() {
			var row = $(this).closest('tr');
			var check = 2;
			let selectedData = {
	        	project_Id : $("#result_project_Id").val()
	        	,project_Name : $("#project_Name").val()
				,member_Id : row.find("td:nth-child(2)").text()
				,member_Name : row.find("td:nth-child(3)").text()
				,pushDate : row.find("td:nth-child(8) input[name='pushdate']").val()
				,pullDate : row.find("td:nth-child(9) input[name='pulldate']").val()
				,check : check
	        }
	        selectedRowData.push(selectedData);
	    });

	    $.ajax({
			type : 'POST',
			url: '/popup/projectDetailInsert',
			//data: selectedRowData,
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify(selectedRowData),
			success : function(result) { // 결과 성공 콜백함수        
				alert("추가 성공");
				window.location.reload();
				//location.href = "/popup/projectInmember?pageNo=1";
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("등록 실패");
			}
		}); //ajax EndPoint
	});	//insertEndPoint
});
	
function go(pageNo){
	//let searchField = document.getElementById("searchField").value; 
	let searchWord = document.getElementById("searchWord").value;
	//var pageNo = document.getElementById("pageNo").value; 
	$.ajax({
		type : 'POST',
		url: '/popup/popMember',
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 //"searchField" : searchField,
		},
		success : function(resultMap) { // 결과 성공 콜백함수    
			if (searchWord.trim() !== "") {
			    //console.log("검색어가 있습니다.");
			    location.href = "/popup/popMember?pageNo=" + pageNo + "&searchWord=" + searchWord;
			} else {
			    //console.log("검색어가 없습니다.");
			    location.href = "/popup/popMember?pageNo=" + pageNo;
			}
			
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint
</script>
</body>
</html>
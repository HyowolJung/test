<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
<div>
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" type="hidden"><!-- type="hidden" -->
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
		<option value="id" <c:if test = "${pageDto.cri.searchField == 'id'}">selected</c:if>>아이디</option>
	  	<option value="name" ${pageDto.cri.searchField == 'name' ? 'selected' : ''}>이름</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>시작일</label>S
	<input type="date" name="searchDate" ${pageDto.cri.searchDate == 'date' ? 'selected' : ''} id = "searchDate" > <!-- ${pageDto.cri.searchField == 'date' ? 'selected' : ''} -->
	<button id="searchButton">검색</button>
	<button id="insert">추가</button>	
</div>

<input type="text" id="result_member_Id" readonly style="display: none"/>

<table border="1" id="projectTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<th style="display: none">번호</th>
			<th style="display: none">아이디</th>
			<th>이름</th>
			<th>고객사</th>
			<!-- <th>언어</th> -->
			<!-- <th>데이터베이스</th> -->
			<th>시작일</th>
			<th>종료일</th>
			<th>투입일</th>
			<th>철수일</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>	

<div id="pagination">
	<ul class="pagination" style= "list-style: none;">
	</ul>
</div>	

</body>
<script>
$(document).ready(function() {
$("#projectTable tbody").empty();
$("#projectTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");

const urlParams = new URLSearchParams(window.location.search);
const member_Id = urlParams.get('member_Id');

// 가져온 member_Id 값을 input 요소에 설정합니다.
$("#result_member_Id").val(member_Id);
//alert("member_Id : " + member_Id);

//alert("result_member_Id : " + $("#result_member_Id").val(member_Id));

//1. 검색 폼
//let newRow = $("<tr>");
$("#searchButton").click(function(){
	let searchDate = $("#searchDate").val();
	let searchField = document.getElementById("searchField").value; 
	let searchWord = $("#searchWord").val();
	let pageNo = document.getElementById("pageNo").value; 
	$.ajax({
		type : 'POST',
		url: '/popup/popProject',
		data: {
			"searchField" : searchField,
		 	"searchWord" : searchWord,
		 	"pageNo" : pageNo,
		 	"searchDate" : searchDate,
		 	"member_Id" : member_Id
		},
		success : function(resultMap) { // 결과 성공 콜백함수 
			console.log("success");
			var projectList = resultMap.projectList;
			var pageDto = resultMap.pageDto;
			$("#projectTable tbody").empty();
			
			if (projectList && projectList.length > 0) {
       			for (let i = 0; i < projectList.length; i++) {
                	var newRow = $("<tr>");
                	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + projectList[i].project_Id + "' data-id='" + projectList[i].project_Id + "'></td>");
                	newRow.append("<td hidden>" + projectList[i].project_No + "</td>");
                	newRow.append("<td hidden>" + projectList[i].project_Id + "</td>");
                	newRow.append("<td>" + projectList[i].project_Name + "</td>");
                	newRow.append("<td>" + projectList[i].custom_company_id + "</td>");
                	//newRow.append("<td>" + projectList[i].project_Skill_Language + "</td>");
                	//newRow.append("<td>" + projectList[i].project_Skill_DB + "</td>");
                	newRow.append("<td>" + projectList[i].project_startDate + "</td>");
                	newRow.append("<td>" + (projectList[i].project_endDate === '1900-01-01' ? '미정' : projectList[i].project_endDate) + "</td>");
                	newRow.append("<td><input type='date' name='pushdate')></td>");
                	newRow.append("<td><input type='date' name='pulldate')></td>");
                	$("#projectTable tbody").append(newRow);
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
       			console.log("projectList 가 NULL 이에요.")
       			$("#projectTable tbody").empty();
       		    $("#projectTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
       		}
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("조회 실패");
		}
	});	//ajax EndPoint
});	//$("#searchButton").click(function(){ EndPoint

var selectedRadio;
$(document).on("change", ".radiobox", function() {
    selectedRadio = $(this);
});

$("#insert").click(function() {
    // 선택된 라디오 버튼이 있는지 확인
    if (selectedRadio) {
        var selectedRow = selectedRadio.closest("tr");

        let selectedRowData = {
	       	member_Id : $("#result_member_Id").val()
	       	,project_No : selectedRow.find("td:nth-child(2)").text()
			,project_Id : selectedRow.find("td:nth-child(3)").text()
			,project_Name : selectedRow.find("td:nth-child(4)").text()
			,pushDate : selectedRow.find("td:nth-child(8) input[name='pushdate']").val()
			,pullDate : selectedRow.find("td:nth-child(9) input[name='pulldate']").val()
			,check : p
        }
        console.log("pushDate : " + selectedRow.find("td:nth-child(8) input[name='pushdate']").val());
        console.log("pullDate : " + selectedRow.find("td:nth-child(9) input[name='pulldate']").val());
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
    } else {
        // 선택된 라디오 버튼이 없는 경우, 알림 표시
        alert("라디오 버튼을 선택하세요.");
    }
});	//$("#insert").click(function() {
});	//$(document).ready(function() {
	
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
			    location.href = "/popup/popProject?pageNo=" + pageNo + "&searchWord=" + searchWord;
			} else {
			    //console.log("검색어가 없습니다.");
			    location.href = "/popup/popProject?pageNo=" + pageNo;
			}
			
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint

</script>
</html>
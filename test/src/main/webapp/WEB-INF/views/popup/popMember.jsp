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
<body>
<div>
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" type="hidden"><!-- type="hidden" -->
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
	  <option value="id" <c:if test = "${pageDto.cri.searchField == 'id'}">selected</c:if>>아이디</option>
	  <option value="name" ${pageDto.cri.searchField == 'name' ? 'selected' : ''}>이름</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>시작일</label>
	<input type="date" name="searchDate" ${pageDto.cri.searchDate == 'date' ? 'selected' : ''} id = "searchDate" > <!-- ${pageDto.cri.searchField == 'date' ? 'selected' : ''} -->
	<button id="searchButton">검색</button>
	<button id="insert">추가</button>	
</div>

<input type="text" id="result_project_Id" readonly style="display: none"/>

<table border="1" id="memberTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<th style="display: none">번호</th>
			<th style="display: none">아이디</th>
			<th>이름</th>
			<th>성별</th>
			<th>직급</th>
			<th>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>입사일</th>
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
$(document).ready(function() {
	$("#searchButton").click(function(){
		let searchDate = $("#searchDate").val();
		let searchField = document.getElementById("searchField").value; 
		let searchWord = $("#searchWord").val();
		let pageNo = document.getElementById("pageNo").value; 
		$.ajax({
			type : 'POST',
			url: '/popup/popMember',
			data: {
				"searchField" : searchField,
			 	"searchWord" : searchWord,
			 	"pageNo" : pageNo,
			 	"searchDate" : searchDate,
			 	"project_Id" : project_Id
			},
			success : function(resultMap) { // 결과 성공 콜백함수 
				console.log("success");
				var memberList = resultMap.memberList;
				var pageDto = resultMap.pageDto;
				$("#memberTable tbody").empty();
				
				if (memberList && memberList.length > 0) {
	       			for (let i = 0; i < memberList.length; i++) {
	                	var newRow = $("<tr>");
	                	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	newRow.append("<td hidden>" + memberList[i].member_No + "</td>");
                    	newRow.append("<td hidden>" + memberList[i].member_Id + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Name + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Sex + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Position + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Tel + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_Language + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_DB + "</td>");
                    	newRow.append("<td>" + memberList[i].member_startDate + "</td>");
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
				alert("조회 실패");
			}
		});	//ajax EndPoint
	});	//$("#searchButton").click(function(){ EndPoint

});
</script>
</body>
</html>
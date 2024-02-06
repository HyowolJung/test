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
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" type="hidden"><!-- type="hidden" -->
	프로젝트명 : <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
		<option selected>고객사</option>
    	<option value="D062" ${pageDto.cri.searchField == 'D062' ? 'selected' : ''}>엘지</option>
    	<option value="D065" ${pageDto.cri.searchField == 'D065' ? 'selected' : ''}>아마존</option>
		<option value="D061" ${pageDto.cri.searchField == 'D061' ? 'selected' : ''}>삼성</option>
		<option value="D063" ${pageDto.cri.searchField == 'D063' ? 'selected' : ''}>애플</option>
		<option value="D064" ${pageDto.cri.searchField == 'D064' ? 'selected' : ''}>구글</option>
	</select>
   	<label>시작일</label>
   	<input type="date" name="searchDate" ${pageDto.cri.search_startDate == 'search_startDate' ? 'selected' : ''} id = "search_startDate" onblur="validateDate1()">
	~
	<label>종료일</label>
	<input type="date" name="searchDate" ${pageDto.cri.search_endDate == 'search_endDate' ? 'selected' : ''} id = "search_endDate" onblur="validateDate2()">
	<button id="searchButton">검색</button>
	<button id="insert">추가</button>	
</div>

<input type="text" id="result_member_Id" readonly  style="display: none" /><!-- style="display: none" -->
<input type="text" id="result_member_Name" readonly style="display: none" /><!-- style="display: none" -->

<table border="1" id="projectTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<!-- <th style="display: none">번호</th> -->
			<th style="display: none">아이디</th>
			<th>이름</th>
			<th>고객사</th>
			<!-- <th>언어</th> -->
			<!-- <th>데이터베이스</th> -->
			<th>시작일</th>
			<th>종료일</th>
			<!-- <th>투입일</th>
			<th>철수일</th> -->
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
var member_Name = localStorage.getItem('member_Name');
//alert("member_Name : " + member_Name);	
$("#projectTable tbody").empty();
$("#projectTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");

const urlParams = new URLSearchParams(window.location.search);
const member_Id = urlParams.get('member_Id');

// 가져온 member_Id 값을 input 요소에 설정합니다.
$("#result_member_Id").val(member_Id);
$("#result_member_Name").val(member_Name);
//alert("member_Id : " + member_Id);

//alert("result_member_Id : " + $("#result_member_Id").val(member_Id));

//1. 검색 폼
//let newRow = $("<tr>");
$("#searchButton").click(function(){
	let searchField = null	
	//let searchDate = $("#searchDate").val();
	/* if(search_startDate != null ||search_endDate != null){
		alert("둘다 NULL이 아니다.")		
		if(search_startDate < search_endDate){
			alert("퇴사일이 입사일보다 빠를 수는 없어요.");
			return;
		}
	} */
	
	searchField = document.getElementById("searchField").value;
	
	if(searchField == '고객사'){
		searchField = null;
	}
	//alert("searchField : " + searchField);
	let searchWord = $("#searchWord").val();
	let search_startDate = $("#search_startDate").val();
	let search_endDate = $("#search_endDate").val();
	let pageNo = document.getElementById("pageNo").value; 
	$.ajax({
		type : 'POST',
		url: '/popup/popProject',
		data: {
			"searchField" : searchField,
		 	"searchWord" : searchWord,
		 	"pageNo" : pageNo,
		 	"search_startDate" : search_startDate,
		 	"search_endDate" : search_endDate,
		 	"member_Id" : member_Id
		},
		success : function(resultMap) { // 결과 성공 콜백함수 
			console.log("success");
			var projectList = resultMap.projectList;
			var pageDto = resultMap.pageDto;
			$("#projectTable tbody").empty();
			alert("조회를 성공했어요.");
			if (projectList && projectList.length > 0) {
       			for (let i = 0; i < projectList.length; i++) {
                	var newRow = $("<tr>");
                	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + projectList[i].project_Id + "' data-id='" + projectList[i].project_Id + "'></td>");
                	newRow.append("<td hidden>" + projectList[i].project_Id + "</td>");
                	newRow.append("<td>" + projectList[i].project_Name + "</td>");
                	//newRow.append("<td>" + projectList[i].custom_company_id + "</td>");
                	newRow.append("<td>" + (projectList[i].custom_company_id === null ? '미정' : projectList[i].custom_company_id) + "</td>");
                	newRow.append("<td>" + projectList[i].project_startDate + "</td>");
                	newRow.append("<td>" + (projectList[i].project_endDate === null ? '미정' : projectList[i].project_endDate) + "</td>");
                	//newRow.append("<td><input type='date' name='pushdate' value='" + projectList[i].pushDate + "')></td>");
                	//newRow.append("<td><input type='date' name='pulldate' value='" + projectList[i].pullDate + "')></td>");
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
       			alert("조회는 성공했는데, 결과값이 없는거 같아요.");       			
       			//console.log("projectList 가 NULL 이에요.")
       			$("#projectTable tbody").empty();
       		    $("#projectTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
       		}
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("조회 실패");
		}
	});	//ajax EndPoint
});	//$("#searchButton").click(function(){ EndPoint

$('#insert').click(function() {
    // 모든 선택된 체크박스의 데이터를 저장할 배열
    var selectedRowData = [];

    // 모든 선택된 체크박스를 순회
    $('.checkbox:checked').each(function() {
        var row = $(this).closest('tr');

        // 행의 각 셀에서 데이터 추출
        var member_Id = $("#result_member_Id").val();
        var member_Name = $("#result_member_Name").val();
        var project_Id = row.find("td:nth-child(2)").text();
        var project_Name = row.find("td:nth-child(3)").text();
        var check = 1;
        // 선택된 행의 데이터를 객체에 저장
       var selectedData = {
    		member_Id : member_Id,
    		member_Name : member_Name,
    		project_Id : project_Id,
    		project_Name : project_Name,
            check : check,
            // pushDate: pushDate, // 필요한 경우 주석 해제하여 사용
            // pullDate: pullDate // 필요한 경우 주석 해제하여 사용
        };
        selectedRowData.push(selectedData);
    });
	//alert("selectedData : " + selectedData);
    $.ajax({
		type : 'POST',
		url: '/popup/projectDetailInsert',
		//data: selectedRowData,
		contentType: 'application/json; charset=utf-8',
		data: JSON.stringify(selectedRowData),
		success : function(result) { // 결과 성공 콜백함수        
			//console.log("추가 성공");
			alert("추가 성공");
			//window.location.reload();
			//location.href = "/popup/projectInmember?pageNo=1";
			if (window.opener) {
            	window.opener.location.reload(); // 부모 창 새로고침
        	}
        	window.close(); // 성공 메시지 후 b.jsp 팝업 창 닫기
		}, 
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("등록 실패");
		}
	}); //ajax EndPoint
});	
	
/* var selectedRadio;
$(document).on("change", ".checkbox", function() {
    selectedRadio = $(this);
}); */

/* $("#insert").click(function() {
	alert("클릭");
	
	
	
	
}); */
	
});	//$(document).ready(function() {
function validateDate1() {
	var search_startDate = document.getElementById("search_startDate").value;
	
    // 입력된 날짜 형식 확인 (YYYY-MM-DD)
    var dateFormat = /^\d{4}-\d{2}-\d{2}$/;
    var startDateInput = document.getElementById("search_startDate");
		
    if (search_startDate && !search_startDate.match(dateFormat)) {
        alert("다시 한번 확인해주세요.");
        startDateInput.value = "";
        return;
    }
    
    var inputDate = search_startDate.split("-");
    var year = parseInt(inputDate[0]);
    var month = parseInt(inputDate[1]);
    var day = parseInt(inputDate[2]);
    
 	// 년도에 대한 최소 및 최대 제한
    if (year < 2000 || year > 2099) {
        alert("년도는 2000부터 2099까지만 가능해요.");
        startDateInput.value = "";
        return;
    }
    
    // 유효한 월과 일인지 확인
    if (month < 1 || month > 12 || day < 1 || day > 31) {
        alert("유효하지 않아요.");
        startDateInput.value = "";
        return;
    }

    // 해당 월의 마지막 일자 확인
    var date = new Date(year, month - 1, day);
    if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day) {
    	startDateInput.value = "";    	
        alert("유효하지 않아요.");
    } else {
        //alert("제대로 입력했어요. 잘했어요.");
        console.log("제대로 입력했어요. 잘했어요.");
    }
}

function validateDate2() {
	var search_endDate = document.getElementById("search_endDate").value;	
	
    // 입력된 날짜 형식 확인 (YYYY-MM-DD)
    var dateFormat = /^\d{4}-\d{2}-\d{2}$/;
    var endDateInput = document.getElementById("search_endDate");
	
    if (search_endDate && !search_endDate.match(dateFormat)) {
        alert("다시 한번 확인해주세요.");
        endDateInput.value = "";
        return;
    }
    
    //alert("search_endDate : " + search_endDate);
    var inputDate = search_endDate.split("-");
    var year = parseInt(inputDate[0]);
    var month = parseInt(inputDate[1]);
    var day = parseInt(inputDate[2]);
    
 	// 년도에 대한 최소 및 최대 제한
    if (year < 2000 || year > 2099) {
        alert("년도는 2000부터 2099까지만 가능해요.");
        endDateInput.value = "";
        return;
    }
    
    // 유효한 월과 일인지 확인
    if (month < 1 || month > 12 || day < 1 || day > 31) {
        alert("유효하지 않아요.");
        endDateInput.value = "";
        return;
    }

    // 해당 월의 마지막 일자 확인
    var date = new Date(year, month - 1, day);
    if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day) {
        alert("유효하지 않아요.");
        endDateInput.value = "";
    } else {
        //alert("제대로 입력했어요. 잘했어요.");
        console.log("제대로 입력했어요. 잘했어요.");
    }
    
}
	
function go(pageNo){
	let searchField = document.getElementById("searchField").value; 
	let searchWord = document.getElementById("searchWord").value;
	let search_startDate = document.getElementById("search_startDate").value;
	let search_endDate = document.getElementById("search_endDate").value;
	//var pageNo = document.getElementById("pageNo").value; 
	alert("search_startDate  : " + search_startDate);
	$.ajax({
		type : 'POST',
		url: '/popup/popProject',
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 "searchField" : searchField,
			 "search_endDate" : search_endDate,
			 "search_startDate" : search_startDate
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
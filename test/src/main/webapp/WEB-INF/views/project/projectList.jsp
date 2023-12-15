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
<table border="1" id="projectTable">
		<thead>
			<tr>
				<th>ㅁ</th>
				<th>번호</th>
				<th>고객사</th>
				<th>이름</th>
				<th>언어</th>
				<th>데이터베이스</th>
				<th>시작일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="projectList" items="${projectList}">
				<tr>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<button type="button" value="delete" id="deleteButton">삭제</button>
	<button type="button" value="modify" id="modifyButton">수정</button>
	<!-- <a href="/member/insertMember">추가</a> -->
	<button onclick="insertProject();">등록</button>
	
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
</body>
<script type="text/javascript">
$("#projectTable tbody").empty();
$("#projectTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
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
			url: '/project/projectList',
			data: {
					"search_ck" : search_ck,
					"pageNo" : pageNo
			},
			success : function(result) { // 결과 성공 콜백함수  
				$("#projectTable tbody").empty();
           		if(result != null){
           			for (let i = 0; i < result.length; i++) {
                    	let newRow = $("<tr>");
                    	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + result[i].project_id + "' data-id='" + result[i].project_id + "'></td>");
                    	newRow.append("<td>" + result[i].project_id + "</td>");
                    	newRow.append("<td>" + result[i].custom_company_id + "</td>");
                    	newRow.append("<td>" + result[i].project_name + "</td>");
                    	newRow.append("<td>" + result[i].project_Skill_Language + "</td>");
                    	newRow.append("<td>" + result[i].project_Skill_DB + "</td>");
                    	newRow.append("<td>" + result[i].project_startdate + "</td>");

                    	$("#projectTable tbody").append(newRow);
                	}
                	return;
           		}
           		if(result == null){
           			$("#projectTable tbody").empty();
           		    $("#projectTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
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
			url: '/project/projectList',
			data: {
			 	"searchField" :  searchField,
			 	"searchWord" : searchWord,
			 	"search_ck" : search_ck,
			 	"pageNo" : pageNo
			},
			success : function(result) { // 결과 성공 콜백함수  
				$("#projectTable tbody").empty();
           		if(result != null){
           			for (let i = 0; i < result.length; i++) {
                    	let newRow = $("<tr>");
                    	newRow.append("<td><input type='radio' class='radiobox' name='radiobox' value='" + result[i].project_id + "' data-id='" + result[i].project_id + "'></td>");
                    	newRow.append("<td>" + result[i].project_id + "</td>");
                    	newRow.append("<td>" + result[i].custom_company_id + "</td>");
                    	newRow.append("<td>" + result[i].project_name + "</td>");
                    	newRow.append("<td>" + result[i].project_Skill_Language + "</td>");
                    	newRow.append("<td>" + result[i].project_Skill_DB + "</td>");
                    	newRow.append("<td>" + result[i].project_startdate + "</td>");

                    	$("#projectTable tbody").append(newRow);
                	}
           			
           			/* newRow.find('td:eq(2)').click(function() {
           			    // 클릭한 열의 member_Name 값을 가져와서 새로운 페이지 URL을 생성
           			    var member_Id = result[i].member_Id;
           			    var newPageURL = '/member/memberRead?member_Id=' + encodeURIComponent(member_Id);

           			    // 새로운 페이지로 이동
           			    window.location.href = newPageURL;
           			}); */
           		}
           		
           		if(result == null){
           			//$("#memberTable tbody").empty();
           		    //$("#memberTable tbody").html("<tr><td colspan='9' style='text-align:center;'>결과가 없어요.</td></tr>");
				}
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("검색 실패");
			}
		});
	}
});	
function go(pageNo){
	let searchField = document.getElementById("searchField").value; 
	let searchWord = document.getElementById("searchWord").value;
	
	$.ajax({
		type : 'POST',
		url: '/project/projectList',
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 "searchField" : searchField
		},
		success : function(result) { // 결과 성공 콜백함수        
			location.href = "/project/projectList?pageNo=" + pageNo + "&searchWord=" + searchWord;
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint

function insertProject(){
	alert("jsp 의 href 경로를 수정해야 해요.");
	location.href = "/project/projectList";
}
</script>
</html>
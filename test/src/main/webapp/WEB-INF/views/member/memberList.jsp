<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>회원 목록 조회</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 20px;
}

/* div {
            margin-bottom: 20px;
        } */
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
<%@include file="/WEB-INF/views/common/WellCome.jsp"%><br><br>
<div>
	
	<input type="text" id="member_Id_SE" value="<s:authentication property="principal.username"/>" style="display: none">
	<%-- <input type="text" id="member_Id_SE" value="${member_Id_SE}" style="display: none"> --%><!-- type="hidden" -->
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" style="display: none"><!-- style="display: none" -->
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
	  <option value="name" <c:if test = "${pageDto.cri.searchField == 'name' }">selected</c:if>>이름</option>
	  <option value="tel" ${pageDto.cri.searchField == 'tel' ? 'selected' : ''}>전화번호</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>입사일</label>
	<input type="date" name="searchDate" value="${pageDto.cri.search_startDate}" id="search_startDate" onblur="validateDate1()">
	~
	<label>퇴사일</label>
	<input type="date" name="searchDate" value="${pageDto.cri.search_endDate}" id="search_endDate" onblur="validateDate2()">
	<%-- <input type="date" name="searchDate" ${pageDto.cri.search_endDate == 'search_endDate' ? 'selected' : ''} id = "search_endDate" onblur="validateDate2()"> --%>
	<button id="searchButton">조회</button>
	<button id="resetButton">초기화</button>
	
</div>
<br><br>
<table border="1" id="memberTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<!-- <th>번호</th> -->
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>직급</th>
			<th>부서</th>
			<th>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>입사일</th>
			<th>퇴사일</th>
			<th style="display: none">프로젝트아이디</th>
			<!-- <th>상태</th> -->
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>

<button type="button" value="delete" id="deleteButton">삭제</button>
<button type="button" value="modify" id="modifyButton">수정</button>
<button id="insertButton" onclick="insertMember();">등록</button>
<button type="button" value="modify" id="m_modifyButton">수정</button>
<button type="button" value="back" id="backButton">뒤로가기</button>
<div id="pagination">
	<ul class="pagination" style= "list-style: none;">
	</ul>
</div>

<br><br><br><br><br><br><br>
</body>
<script type="text/javascript">
$(document).ready(function() {
	//0. 페이지 기본 이벤트
	let member_Id = $("#member_Id_SE").val();
	$("#m_modifyButton").hide();
	$("#backButton").hide();
	$("#memberTable tbody").empty();
	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	//1. 조회(#searchButton)버튼 클릭 했을 때
	$("#searchButton").click(function(){
		var search_startDate = $("#search_startDate").val();
		var search_endDate = $("#search_endDate").val();
		var searchField = document.getElementById("searchField").value; 
		var searchWord = $("#searchWord").val();
		var pageNo = document.getElementById("pageNo").value; 
		
		if (search_startDate && search_endDate && search_startDate > search_endDate) {
		    alert("퇴사일은 입사일보다 빠를 수 없어요.");
		    return;
		}
		
		$.ajax({
			type : 'POST',
			url: '/member/memberList',
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        },
			data: {
			 	"searchField" : searchField,
			 	"searchWord" : searchWord,
			 	"pageNo" : pageNo,
			 	"search_startDate" : search_startDate,
			 	"search_endDate" : search_endDate,
			 	"header" : header,
			 	"token" : token
			},
			success : function(resultMap) { // 결과 성공 콜백함수  
				var memberList = resultMap.memberList;
				var pageDto = resultMap.pageDto;
				$("#memberTable tbody").empty();
				
           		if (memberList && memberList.length > 0) {
					//console.log("memberList가 있어요");     
					alert("조회를 성공했어요.");
           			for (let i = 0; i < memberList.length; i++) {
                    	var newRow = $("<tr>");
                    	newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
                    	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	//newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
                    	newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].member_Id + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].member_Id + "</a></td>");
                    	newRow.append("<td>" + memberList[i].member_Name + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Sex + "</td>");
						//newRow.append("<td>" + memberList[i].member_status + "</td>;")                    	
                    	newRow.append("<td>" + memberList[i].member_Position + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Department + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Tel + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_Language + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_DB + "</td>");
                    	newRow.append("<td>" + memberList[i].member_startDate + "</td>");
                    	newRow.append("<td>" + (memberList[i].member_endDate === null ? '미정' : memberList[i].member_endDate) + "</td>");
                    	//newRow.append("<td>" + memberList[i].project_Id + "</td>");
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
           			
           		} else {
           			alert("조회는 성공했는데, 결과값이 없는거 같아요.");
           			//console.log("memberList 가 NULL 이에요.")
           			$("#memberTable tbody").empty();
           		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
           		}
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("검색 실패");
			}
		}); //$.ajax EndPoint
	});//$("#searchButton").click EndPoint
	
	/* $("#memberTable").on("click", ".member-id", function () {
		var member_Id = $(this).data("memberid");
		window.location.href = "/member/memberRead?member_Id=" + member_Id;
	}); */
	
	//2. 수정(#modifyButton)버튼 클릭했을 때
	$("#modifyButton").click(function() {
		var checkList = [];
		$('.checkbox:checked').each(function() {
			checkList.push($(this).val());
		});
		//console.log("checkList에 담겨 있는 값은 : " + checkList);
		$.ajax({
			type : 'POST',
			url: '/member/memberListM',
			contentType: 'application/json',
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        },
			data: JSON.stringify(checkList),
			success : function(resultMap) { // 결과 성공 콜백함수
				alert("회원정보를 수정합니다.");
				$("#deleteButton").hide();
				$("#modifyButton").hide();
				$("#insertButton").hide();
				$("#m_modifyButton").show();
				$("#backButton").show();
				
				var memberList = resultMap.memberList;
				$("#memberTable tbody").empty();
				
           		if (memberList && memberList.length > 0) {
					console.log("memberList가 있어요");               			
           			for (let i = 0; i < memberList.length; i++) {
							
           				var select_member_Sex = "<select id='member_Sex'>";
           				select_member_Sex += "<option value='null'" + (memberList[i].member_Sex == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Sex += "<option value='D011'" + (memberList[i].member_Sex == '남자' ? 'selected' : '') + ">남자</option>";
        				select_member_Sex += "<option value='D012'" + (memberList[i].member_Sex == '여자' ? " selected" : "") + ">여자</option>";
        				select_member_Sex += "</select>";
        				
        				var select_member_Position = "<select id='member_Position'>";
        				select_member_Position += "<option value='null'" + (memberList[i].member_Position == '미정' ? " selected" : "") + ">선택</option>";
        				select_member_Position += "<option value='D028'" + (memberList[i].member_Position == '사원' ? " selected" : "") + ">사원</option>";
        				select_member_Position += "<option value='D027'" + (memberList[i].member_Position == '대리' ? " selected" : "") + ">대리</option>";
        				select_member_Position += "<option value='D026'" + (memberList[i].member_Position == '과장' ? " selected" : "") + ">과장</option>";
        				select_member_Position += "</select>";
        				
        				var select_member_Department = "<select id='member_Department'>";
        				select_member_Department += "<option value='null'" + (memberList[i].member_Department == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Department += "<option value='A020'" + (memberList[i].member_Department == '경영지원부' ? 'selected' : '') + ">경영지원부</option>";
        				select_member_Department += "<option value='A021'" + (memberList[i].member_Department == '인사부' ? 'selected' : '') + ">인사부</option>";
        				select_member_Department += "<option value='A022'" + (memberList[i].member_Department == 'IT부' ? 'selected' : '') + ">IT부</option>";
        				select_member_Department += "<option value='A023'" + (memberList[i].member_Department == '마케팅부' ? 'selected' : '') + ">마케팅부</option>";
        				select_member_Department += "</select>";
        				
        				var select_member_Skill_Language = "<select id='member_Skill_Language'>";
        				select_member_Skill_Language += "<option value='null'" + (memberList[i].member_Skill_Language == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Skill_Language += "<option value='S010'" + (memberList[i].member_Skill_Language == 'JAVA' ? 'selected' : '') + ">JAVA</option>";
        				select_member_Skill_Language += "<option value='S011'" + (memberList[i].member_Skill_Language == 'PYTHON' ? 'selected' : '') + ">PYTHON</option>";
        				select_member_Skill_Language += "<option value='S012'" + (memberList[i].member_Skill_Language == 'C++' ? 'selected' : '') + ">C++</option>";
        				select_member_Skill_Language += "<option value='S013'" + (memberList[i].member_Skill_Language == 'RUBY' ? 'selected' : '') + ">RUBY</option>";
        				select_member_Skill_Language += "</select>"; 
           				
        				var select_member_Skill_DB = "<select id='member_Skill_DB'>";
        				select_member_Skill_DB += "<option value='null'" + (memberList[i].member_Skill_DB == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Skill_DB += "<option value='S020'" + (memberList[i].member_Skill_DB == 'ORACLE' ? 'selected' : '') + ">ORACLE</option>";
        				select_member_Skill_DB += "<option value='S021'" + (memberList[i].member_Skill_DB == 'MSSQL' ? 'selected' : '') + ">MSSQL</option>";
        				select_member_Skill_DB += "<option value='S022'" + (memberList[i].member_Skill_DB == 'MYSQL++' ? 'selected' : '') + ">MYSQL</option>";
        				select_member_Skill_DB += "<option value='S023'" + (memberList[i].member_Skill_DB == 'POSTGRESQL' ? 'selected' : '') + ">POSTGRESQL</option>";
        				select_member_Skill_DB += "</select>"; 
        				
           				let newRow = $("<tr>");
           				newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}''/>");
                    	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	//newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
                    	newRow.append("<td>" + memberList[i].member_Id + "</td>");
                    	newRow.append("<td><input type='text' style='width: 60px' value='" + memberList[i].member_Name + "'></td>");
                    	newRow.append("<td>" + select_member_Sex + "</td>");
                    	newRow.append("<td>" + select_member_Position + "</td>");
                    	newRow.append("<td>" + select_member_Department + "</td>");
                    	newRow.append("<td><input type='text' id='member_Tel' style='width: 90px' value='" + memberList[i].member_Tel + "'></td>");
                    	newRow.append("<td>" + select_member_Skill_Language + "</td>");
                    	newRow.append("<td>" + select_member_Skill_DB + "</td>");
                    	newRow.append("<td><input type='date' id='member_startDate' value='" + memberList[i].member_startDate + "'></td>");
                    	newRow.append("<td><input type='date' id='member_endDate' value='" + memberList[i].member_endDate + "'></td>");
                    	//newRow.append("<td>" + (memberList[i].member_endDate === null ? '미정' : memberList[i].member_endDate) + "</td>");
                    	
                    	$("#memberTable tbody").append(newRow);
           			}
           			         			
           		}else{
           			console.log("memberList 가 NULL 이에요.")
           			$("#memberTable tbody").empty();
           		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
           		}	
			},    
			error : function(request, status, error) { // 결과 에러 콜백함수        
				//console.log("전송 실패")
			}
		});	//ajax EndPoint */
	}); //#modifyButton EndPoint
	

	//2-2. 다중 수정(#m_modifyButton)버튼 클릭했을 때
	$("#m_modifyButton").click(function() {
		let member_Tel = $("#member_Tel").val();//입력한 전화번호
		let member_Tel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		let member_startDate = $("#member_startDate").val();
		let member_endDate = $("#member_endDate").val();
		if(!member_endDate.length == 0){
			if (member_endDate < member_startDate) {
		        alert("퇴사날짜는 입사날짜보다 이전일 수 없습니다.");
		        return;
			}
	    }
			
		//2-1. 전화번호 유효성 체크(비어있는지)
		if(member_Tel.length == 0){
			alert("전화번호는 반드시 입력해야 합니다.");
			return;
		}else if(member_Tel.length != 0){
			//2-2. 전화번호 유효성체크(적절한 조합인지)
			if (member_Tel_Check.test(member_Tel) != true){
				alert("적절한 형식이 아닙니다.")
				return;
			}else if(member_Tel_Check.test(member_Tel) == true){	//유효성 통과하면
				if(member_endDate.length == 0){
					console.log("퇴사일이 없어요.");
					var modifyDatas = [];
					$('.checkbox:checked').each(function() {
			    		// 현재 체크박스를 포함하는 행(tr)을 가져옵니다.
			    		let row = $(this).closest('tr');

			    		// 행에서 필요한 데이터를 추출합니다.
			    		let data = {
								member_Id: row.find('td:eq(1)').text(), // 첫 번째 <td>의 <a> 태그 내용
				        		member_Name: row.find('td:eq(2) input').val(), // 두 번째 <td>의 <input> 값
				        		member_Sex: row.find('td:eq(3) select').val(), // 세 번째 <td>의 텍스트
				        		member_Position: row.find('td:eq(4) select').val(), // ...
				        		member_Department: row.find('td:eq(5) select').val(),
				        		member_Tel: row.find('td:eq(6) input').val(),
				        		member_Skill_Language: row.find('td:eq(7) select').val(),
				        		member_Skill_DB: row.find('td:eq(8) select').val(),
				        		member_startDate: row.find('td:eq(9) input').val(),
				        		member_endDate: row.find('td:eq(10) input').val()
			    		};
						//alert("data : " + data);
			    		// 추출한 데이터를 배열에 추가합니다.
			    		modifyDatas.push(data);
					});
					
					$.ajax({
						type : 'POST',
						url: '/member/memberModifyM',
						contentType : 'application/json; charset=utf-8',
						beforeSend: function(xhr) {
				            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
				        },
						data: JSON.stringify(modifyDatas),
						success : function(result) { // 결과 성공 콜백함수        
							if(result == true){
								alert("수정 성공");
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberList";
								//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
							}else if(result == false){
								//alert("수정하려는 번호는 현재 존재하는 번호입니다.");
								alert("수정 성공");
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberList";
							}				
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							alert("수정 실패");
						}
					}); //ajax EndPoint
				}else if(!member_endDate.length == 0){
					console.log("퇴사일이 있어요.");
					var modifyDatas = [];
					$('.checkbox:checked').each(function() {
			    		// 현재 체크박스를 포함하는 행(tr)을 가져옵니다.
			    		let row = $(this).closest('tr');

			    		// 행에서 필요한 데이터를 추출합니다.
			    		let data = {
								member_Id: row.find('td:eq(1)').text(), // 첫 번째 <td>의 <a> 태그 내용
				        		member_Name: row.find('td:eq(2) input').val(), // 두 번째 <td>의 <input> 값
				        		member_Sex: row.find('td:eq(3) select').val(), // 세 번째 <td>의 텍스트
				        		member_Position: row.find('td:eq(4) select').val(), // ...
				        		member_Department: row.find('td:eq(5) select').val(),
				        		member_Tel: row.find('td:eq(6) input').val(),
				        		member_Skill_Language: row.find('td:eq(7) select').val(),
				        		member_Skill_DB: row.find('td:eq(8) select').val(),
				        		member_startDate: row.find('td:eq(9) input').val(),
				        		member_endDate: row.find('td:eq(10) input').val()
			    		};
			    		//alert("data : " + data);
			    		// 추출한 데이터를 배열에 추가합니다.
			    		modifyDatas.push(data);
			    		
					});
					//console.log("modifyDatas : " + modifyDatas);
					$.ajax({
						type : 'POST',
						url: '/member/memberModifyM',
						contentType : 'application/json; charset=utf-8',
						beforeSend: function(xhr) {
				            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
				        },
						data: JSON.stringify(modifyDatas),
						success : function(result) { // 결과 성공 콜백함수        
							if(result == true){
								alert("수정을 성공했어요");
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberList";
								//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
							}else if(result == false){
								//alert("수정하려는 번호는 현재 존재하는 번호입니다.");
								alert("수정을 성공했어요");
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberList";
							}				
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							alert("수정을 실패했어요");
						}
					}); //ajax EndPoint
				}// elseIf EndPoint
			}// elseIf EndPoint
		}// elseIf EndPoint
	});//$("#modifyButton").click(function() {
		
    //3. 삭제(#deleteButton)버튼 클릭했을 때(+ 다중)
    $("#deleteButton").click(function() {
    	var checkList = [];
		$('.checkbox:checked').each(function() {
			checkList.push($(this).val());
		});
		$.ajax({
			type : 'POST',
			url: '/member/memberDeleteM',
			contentType: 'application/json',
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        },
			data: JSON.stringify(checkList),
			success : function(result) { // 결과 성공 콜백함수        
				alert("삭제를 성공했어요.");
				location.href = "/member/memberList";
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("투입 이력이 있는 회원은 삭제할 수 없어요.");
			}
		}); //ajax EndPoint
	});	//#deleteButton EndPoint
	
	
	$("#resetButton").click(function() {
		var selectElement = document.getElementById("searchField");
		selectElement.selectedIndex = 0; // 첫 번째 옵션을 선택하도록 설정

		// text input 초기화
		var textInput = document.getElementById("searchWord");
		textInput.value = "";

		// date input 초기화
		var startDateInput = document.getElementById("search_startDate");
		var endDateInput = document.getElementById("search_endDate");
		startDateInput.value = "";
		endDateInput.value = "";
	});//$("#resetButton").click(function() { EndPoint
		
	$("#backButton").click(function() {
		location.href="/member/memberList";
	});
	
	//var pageNo = $("#pageNo").val();
});//document EndPoint

function submitPost(member_Id, pageNo) {
	//alert("pageNo : " + pageNo);
	//alert("member_Id : " + member_Id);
    // 폼 생성
    var form = $('<form></form>', {
        method: 'POST',
        action: '/member/memberRead'
    });

    // memberId와 pageNo 값을 input으로 추가
    form.append($('<input>', {
        type: 'hidden',
        name: 'member_Id',
        value: member_Id
    }));
    form.append($('<input>', {
        type: 'hidden',
        name: 'pageNo',
        value: pageNo
    }));
	
    form.append($('<input>', {
        type: 'hidden',
        name: '${_csrf.parameterName}',
        value: '${_csrf.token}'
    }));
    
    // 폼을 body에 추가하고 제출
    $('body').append(form);
    form.submit();
}
//체크데이터 수집 공통 모듈(미완성)
/* var checkList1 = [];
$(document).on('click', '.checkbox', function() {
    $('.checkbox:checked').each(function() {
		console.log("fffffffffff");        	
    	//var member_Id = $(this).val();
    	var row = $(this).closest('tr');
    	var member_Id = $(this).val();
    	var member_Name = row.find('td:nth-child(3)').val(); // 멤버 이름 가져오기
    	var member_Sex = row.find('td:nth-child(4)').val(); // 멤버 성별 가져오기
    	var member_Position = row.find('td:nth-child(5)').val(); // 멤버 직급 가져오기
    	var member_Department = row.find('td:nth-child(6)').val(); // 멤버 부서 가져오기
    	var member_Tel = row.find('td:nth-child(7)').val(); // 멤버 전화번호 가져오기
    	var member_Skill_Language = row.find('td:nth-child(8)').val(); // 멤버 언어 스킬 가져오기
    	var member_Skill_DB = row.find('td:nth-child(9)').val(); // 멤버 데이터베이스 스킬 가져오기
    	var member_startDate = row.find('td:nth-child(10)').val(); // 멤버 입사일 가져오기
    	var member_endDate = row.find('td:nth-child(11)').val(); // 멤버 퇴사일 가져오기
    	
    	var memberInfo = {
    			member_Id: member_Id,
    			member_Name: member_Name,
    			member_Sex: member_Sex,
    			member_Position: member_Position,
    			member_Department: member_Department,
    			member_Tel: member_Tel,
    			member_Skill_Language: member_Skill_Language,
    			member_Skill_DB: member_Skill_DB,
    			member_startDate: member_startDate,
    			member_endDate: member_endDate,
        };
        checkList1.push(memberInfo);
    });
    //console.log("선택된 값들!! : " + checkList);    	
});//$(document).on('click', '.checkbox', function() { */


function validateDate1() {
	var search_startDate = document.getElementById("search_startDate").value;
	
    // 입력된 날짜 형식 확인 (YYYY-MM-DD)
    var dateFormat = /^\d{4}-\d{2}-\d{2}$/;
    var startDateInput = document.getElementById("search_startDate");
    
    if (!search_startDate) {
		alert("유효하지 않은 입력입니다.");
		startDateInput.value = "";
        return;
    }
    
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
        alert("년도는 2000부터 2099까지만 가능합니다.");
        startDateInput.value = "";
        return;
    }
    
    // 유효한 월과 일인지 확인
    if (month < 1 || month > 12 || day < 1 || day > 31) {
        alert("유효하지 않아요1-1.");
        startDateInput.value = "";
        return;
    }

    // 해당 월의 마지막 일자 확인
    var date = new Date(year, month - 1, day);
    if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day) {
    	startDateInput.value = "";    	
        alert("유효하지 않아요1-2.");
    } else {
        console.log("유효한 입력입니다.");
    }
}

function validateDate2() {
	var search_endDate = document.getElementById("search_endDate").value;	
	
    // 입력된 날짜 형식 확인 (YYYY-MM-DD)
    var dateFormat = /^\d{4}-\d{2}-\d{2}$/;
    var endDateInput = document.getElementById("search_endDate");
    
    if (!search_endDate) {
    	alert("유효하지 않은 입력입니다.");
    	endDateInput.value = "";
    	return;
    }
    
    if (search_endDate && !search_endDate.match(dateFormat)) {
        alert("다시 한번 확인해주세요.");
        endDateInput.value = "";
        return;
    }

    var inputDate = search_endDate.split("-");
    var year = parseInt(inputDate[0]);
    var month = parseInt(inputDate[1]);
    var day = parseInt(inputDate[2]);
    
 	// 년도에 대한 최소 및 최대 제한
    if (year < 2000 || year > 2099) {
        alert("년도는 2000부터 2099까지만 가능합니다.");
        endDateInput.value = "";
        return;
    }
    
    // 유효한 월과 일인지 확인
    if (month < 1 || month > 12 || day < 1 || day > 31) {
        alert("유효하지 않아요2-1.");
        endDateInput.value = "";
        return;
    }

    // 해당 월의 마지막 일자 확인
    var date = new Date(year, month - 1, day);
    if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day) {
        alert("유효하지 않아요2-2.");
        endDateInput.value = "";
    } else {
        //alert("제대로 입력했어요. 잘했어요.");
        console.log("유효한 입력입니다");
    }
    
}

function go(pageNo){
	//alert("페이지 버튼 클릭");
	var searchField = document.getElementById("searchField").value;
	var searchWord = document.getElementById("searchWord").value;
	var search_startDate = document.getElementById("search_startDate").value;
	var search_endDate = document.getElementById("search_endDate").value;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	//var pageNoPost1 = $("pageNoPost");
	//var pageNoPost = document.getElementById("pageNoPost").value;
	
	/* $.ajax({
		type : 'POST',
		url: '/member/memberListInfo',
		data: {
			 "pageNo" : pageNo
		},
		success : function(resultMap) {
			pageNoPost1.val(mav.pageNoPost);
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	}); */
	$.ajax({
		type : 'POST',
		url: '/member/memberList',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 "searchField" : searchField,
			 "search_startDate" : search_startDate,
			 "search_endDate" : search_endDate
		},
		success : function(resultMap) { // 결과 성공 콜백함수
			//location.href = "/member/memberList?pageNo=" + pageNo;
			//location.reload(true);
			$("#searchField").val(searchField);
			$("#searchWord").val(searchWord);
			$("#search_startDate").val(search_startDate);
			$("#search_endDate").val(search_endDate);
			
			var pageNoPost = resultMap.pageNoPost;
			$("#pageNoPost").val(pageNoPost);
			
			var memberList = resultMap.memberList;
			var pageDto = resultMap.pageDto;
			$("#memberTable tbody").empty();
			
       		if (memberList && memberList.length > 0) {
				//console.log("memberList가 있어요");     
				//alert("조회를 성공했어요.");
       			for (let i = 0; i < memberList.length; i++) {
                	var newRow = $("<tr>");
                	newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}''/>");
                	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                	newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].member_Id + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].member_Id + "</a></td>");
                	//newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
                	newRow.append("<td>" + memberList[i].member_Name + "</td>");
                	newRow.append("<td>" + memberList[i].member_Sex + "</td>");
                	newRow.append("<td>" + memberList[i].member_Position + "</td>");
                	newRow.append("<td>" + memberList[i].member_Department + "</td>");
                	newRow.append("<td>" + memberList[i].member_Tel + "</td>");
                	newRow.append("<td>" + memberList[i].member_Skill_Language + "</td>");
                	newRow.append("<td>" + memberList[i].member_Skill_DB + "</td>");
                	newRow.append("<td>" + memberList[i].member_startDate + "</td>");
                	newRow.append("<td>" + (memberList[i].member_endDate === null ? '미정' : memberList[i].member_endDate) + "</td>");
                	//newRow.append("<td>" + memberList[i].project_Id + "</td>");
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
       			alert("조회는 성공했는데, 결과값이 없는거 같아요.");
       			//console.log("memberList 가 NULL 이에요.")
       			$("#memberTable tbody").empty();
       		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
       		}
       		
			/* if (searchWord.trim() !== "") {
				location.href = "/member/memberList?pageNo=" + pageNo + "&searchWord=" + searchWord;
				if(search_startDate != null){
					location.href = "/member/memberList?pageNo=" + pageNo + "&searchWord=" + searchWord + "&search_startDate" + search_startDate;
				}
				
				//console.log("검색어가 있습니다.");
			    //location.href = "/member/memberList?pageNo=" + pageNo + "&searchWord=" + searchWord;
				//location.href = "/member/memberList?pageNo=" + pageNo;
			} else {
			    //console.log("검색어가 없습니다.");
			    //location.href = "/member/memberList?pageNo=" + pageNo;
			} */
			
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
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
.total-div{
	margin-top: 10px;
	margin-left: 230px; 
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
.DetailedSearchForm {
	display: none;
}

.total-div {
	margin-top: 20px;
}

.choiceSort, .selectSort {
	display: inline-block; /* 요소들을 인라인 블록으로 만들어 한 줄에 배치 */
    
}

.choiceSort button {
	background: none;
  	border: none;
  	padding: 0;
  	cursor: pointer;
}

.selectSort {
	margin-left: 100px; /* choiceSort와 selectSort 사이 간격 */
	/* //margin-left: 50%; */
}

.choiceSort button:hover {
  text-decoration: underline;
}

.choiceSort button, .selectSort select {
    font-size: 16px; /* 글자 크기 */
    margin: 5px; /* 버튼과 셀렉트 박스 주변 여백 */
}

</style>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%@include file="/WEB-INF/views/common/sideBar.jsp" %>
<div class="total-div" style="text-align: center;">

<div>
<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" disabled="disabled" style="display: none"><!--  -->
<input id="choiceValue" name="choiceValue" value="${choiceValue }"  disabled="disabled" style="display: none">

<div class="choiceSort" >
<button id="IdUp" onclick="getMemberList(this)" value="IdUp">사번 높은 순</button> | <button id="IdDown" onclick="getMemberList(this)" value="IdDown">사번 낮은 순</button> | <button id="DeptUp" onclick="getMemberList(this)" value="DeptUp">직급 높은 순</button> | <button id="DeptDown" onclick="getMemberList(this)" value="DeptDown">직급 낮은 순</button> | <button id="RecentStDay" onclick="getMemberList(this)" value="RecentStDay">최근 입사 순</button>
</div>

<div class="selectSort">
<select id="memberStatus" name="memberStatus" style="height: 30px;">
	<option value="ALL">상태</option>
	<option value="D401">재직</option>
	<option value="D403">휴가</option>
	<option value="D405">퇴직</option>
</select>
<select id="searchCnt" name="searchCnt" style="height: 30px;">
	<option value="5">5명</option>
	<option value="10">10명</option>
	<option value="20">20명</option>
</select>
</div>

</div>

<br><br>
<table border="1" id="memberTable">
	<thead>
		<tr>
			<th><input type="checkbox" id="checkboxAll"></th>
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>부서</th>
			<th>직책</th>
			<th>직급</th>
			<th>전화번호</th>
			<th>입사일</th>
			<th>퇴사일</th>
			<th>상태</th>
			<th style="display: none">프로젝트아이디</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>

<button type="button" value="delete" id="deleteButton" >삭제</button>
<button type="button" value="modify" id="selectButton">수정</button>
<!-- <button id="insertButton" onclick="insertMember();">등록</button> -->
<button type="button" value="back" id="backButton">뒤로가기</button>
<button type="button" value="modify" id="modifyButton">수정</button>
<div id="pagination">
	<ul class="pagination" style="list-style: none;"></ul>
</div>

<br><br><br>
</div>


</body>
<!-- <script src="/common/commonsMember.js"></script> -->
<script type="text/javascript">
$(document).ready(function() {
	$('.choiceSort a').click(function(event) {
	    event.preventDefault(); // 링크의 기본 동작 방지

	    // 모든 링크에서 'selected' 클래스 제거
	    $('.choiceSort a').removeClass('selected');

	    // 클릭된 링크에 'selected' 클래스 추가
	    $(this).addClass('selected');
	});	
	
	$('#memberStatus').on('change', function() {
	    var memberST = $(this).val();
	    var pageNo = $("#pageNo").val();
		var memberStatus = $("#memberStatus").val();
		var choiceValue = $("#choiceValue").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var data = {
		    	"choiceValue" : choiceValue,
		        "pageNo" : pageNo,
		        "searchCnt" : searchCnt,
				"memberStatus" : memberStatus    		
		    }
		    
			$.ajax({
				type : 'POST',
				url : '/member/memberList',
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
		        },
		        contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(data),
		        success : function(resultMap) {
		        	var memberList = resultMap.memberList;
					var pageDto = resultMap.pageDto;
					$("#pageNo").val(pageNo);
					$("#choiceValue").val(choiceValue);
					$("#memberTable tbody").empty();
				
		   			if (memberList && memberList.length > 0) {
		   				for (let i = 0; i < memberList.length; i++) {
		            		var newRow = $("<tr>");
		            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
		            		newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
		            		newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
		            		newRow.append("<td>" + memberList[i].memberName + "</td>");
		            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
		            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
		            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
		            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
		            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
		            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
		            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
		            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
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
		   				$("#memberTable tbody").empty();
		   		    	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
		   			}
		     	},
		     	error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("정렬 실패");
				}
			});
	});

	// 'searchCount' select 요소에 대한 change 이벤트 리스너 추가
	$('#searchCnt').on('change', function() {
	    var searchCnt = $(this).val();
	    var pageNo = $("#pageNo").val();
		var memberStatus = $("#memberStatus").val();
		var choiceValue = $("#choiceValue").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var data = {
		    	"choiceValue" : choiceValue,
		        "pageNo" : pageNo,
		        "searchCnt" : searchCnt,
				"memberStatus" : memberStatus    		
		    }
		    
			$.ajax({
				type : 'POST',
				url : '/member/memberList',
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
		        },
		        contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(data),
		        success : function(resultMap) {
		        	var memberList = resultMap.memberList;
					var pageDto = resultMap.pageDto;
					$("#pageNo").val(pageNo);
					$("#choiceValue").val(choiceValue);
					$("#memberTable tbody").empty();
				
		   			if (memberList && memberList.length > 0) {
		   				for (let i = 0; i < memberList.length; i++) {
		            		var newRow = $("<tr>");
		            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
		            		newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
		            		newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
		            		newRow.append("<td>" + memberList[i].memberName + "</td>");
		            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
		            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
		            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
		            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
		            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
		            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
		            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
		            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
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
		   				$("#memberTable tbody").empty();
		   		    	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
		   			}
		     	},
		     	error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("정렬 실패");
				}
			});
	});	
	
	//0. 페이지 기본 이벤트
	let member_Id = $("#member_Id_SE").val();
	$("#modifyButton").hide();
	$("#backButton").hide();
	$("#memberTable tbody").empty();
	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$('#checkboxAll').click(function() {
        if (this.checked) {
            // 'selectAll' 체크박스가 선택된 경우, 모든 'checkbox' 클래스 체크박스를 선택합니다.
            $('.checkbox').each(function() {
                this.checked = true;
            });
        } else {
            // 'selectAll' 체크박스가 선택 해제된 경우, 모든 'checkbox' 클래스 체크박스를 선택 해제합니다.
            $('.checkbox').each(function() {
                this.checked = false;
            });
        }
    });
	
	
	//2. 체크박스 클릭했을 때
	var editableRowList = [];
	$('#selectButton').click(function() {
		if ($('input[type="checkbox"].checkbox:checked').length === 0) {
	        alert("수정할 항목을 선택해주세요.");
	        return;
	    }	
		
        // 체크된 체크박스를 순회하면서 데이터 처리
        $('input[type="checkbox"].checkbox:checked').each(function() {
            var memberId = $(this).val();
            var memberRow = $(this).closest('tr');
            var memberData = {
                memberId: memberId,
                memberName: memberRow.find('td:nth-child(4)').text(),
                memberGn: memberRow.find('td:nth-child(5)').text(),
                memberDept: memberRow.find('td:nth-child(6)').text(),
                memberRo: memberRow.find('td:nth-child(7)').text(),
                memberPos: memberRow.find('td:nth-child(8)').text(),
                memberTel: memberRow.find('td:nth-child(9)').text(),
                memberStDay: memberRow.find('td:nth-child(10)').text(),
                memberLaDay: memberRow.find('td:nth-child(11)').text(),
                memberSt: memberRow.find('td:nth-child(12)').text()
            };
			
            // 로컬 스토리지에 데이터 저장
            localStorage.setItem(memberId, JSON.stringify(memberData));
            
            $("#deleteButton").hide();
       		$("#selectButton").hide();
       		$("#insertButton").hide();
       		$("#modifyButton").show();
       		$("#backButton").show();     
            
            // 해당 행 숨기기 (또는 삭제)
            memberRow.empty();

            //select박스 만들기
            var select_memberGN = "<select id='memberGn'>";
            select_memberGN += "<option value=''" + (memberData.memberGn == '(미정)' ? 'selected' : '') + ">선택</option>";
            select_memberGN += "<option value='D101'" + (memberData.memberGn == '남성' ? 'selected' : '') + ">남성</option>";
			select_memberGN += "<option value='D102'" + (memberData.memberGn == '여성' ? " selected" : '') + ">여성</option>";
			select_memberGN += "</select>";

			var positions = {
				    'D201': '회장',
				    'D202': '부회장',
				    'D203': '사장',
				    'D204': '부사장',
				    'D205': '전무',
				    'D206': '상무',
				    'D207': '본부장',
				    'D208': '실장',
				    'D209': '팀장',
				    'D210': '부장',
				    'D211': '차장',
				    'D212': '과장',
				    'D213': '대리',
				    'D214': '주임',
				    'D215': '사원',
				    'D216': '인턴'
			};
			
			var select_memberPos = "<select id='memberPos'><option value='' " + (memberData.memberPos == '(미정)' ? 'selected' : '') + ">선택</option>";

			for (var key in positions) {
			    select_memberPos += "<option value='" + key + "'" + (memberData.memberPos == positions[key] ? " selected" : '') + ">" + positions[key] + "</option>";
			}

			select_memberPos += "</select>";
			
			//document.getElementById('memberPos').innerHTML = generatePositionSelect('(미정)');
			
			var select_memberDept = "<select id='memberDept'>";
			select_memberDept += "<option value=''" + (memberData.memberDept == '(미정)' ? 'selected' : '') + ">선택</option>";
			select_memberDept += "<option value='D301'" + (memberData.memberDept == '경영지원부' ? 'selected' : '') + ">경영지원부</option>";
			select_memberDept += "<option value='D302'" + (memberData.memberDept == '인사부' ? 'selected' : '') + ">인사부</option>";
			select_memberDept += "<option value='D303'" + (memberData.memberDept == 'IT부' ? 'selected' : '') + ">IT부</option>";
			select_memberDept += "<option value='D304'" + (memberData.memberDept == '재무부' ? 'selected' : '') + ">재무부</option>";
			select_memberDept += "<option value='D305'" + (memberData.memberDept == '회계부' ? 'selected' : '') + ">회계부</option>";
			select_memberDept += "<option value='D306'" + (memberData.memberDept == '마케팅부' ? 'selected' : '') + ">마케팅부</option>";
			select_memberDept += "</select>";
			
			var select_memberSt = "<select id='memberSt'>";
			select_memberSt += "<option value=''" + (memberData.memberSt == '(미정)' ? 'selected' : '') + ">선택</option>";
			select_memberSt += "<option value='D401'" + (memberData.memberSt == '재직' ? 'selected' : '') + ">재직</option>";
			select_memberSt += "<option value='D402'" + (memberData.memberSt == '파견' ? 'selected' : '') + ">파견</option>";
			select_memberSt += "<option value='D403'" + (memberData.memberSt == '휴가' ? 'selected' : '') + ">휴가</option>";
			select_memberSt += "<option value='D404'" + (memberData.memberSt == '병가' ? 'selected' : '') + ">병가</option>";
			select_memberSt += "<option value='D405'" + (memberData.memberSt == '퇴사' ? 'selected' : '') + ">퇴사</option>";
			select_memberSt += "</select>";
			
			var select_memberRo = "<select id='memberRo'>";
			select_memberRo += "<option value=''" + (memberData.memberRo == '(미정)' ? 'selected' : '') + ">선택</option>";
			select_memberRo += "<option value='D501'" + (memberData.memberRo == 'PM' ? 'selected' : '') + ">PM</option>";
			select_memberRo += "<option value='D502'" + (memberData.memberRo == 'PO' ? 'selected' : '') + ">PO</option>";
			select_memberRo += "<option value='D503'" + (memberData.memberRo == 'PL' ? 'selected' : '') + ">PL</option>";
			select_memberRo += "<option value='D504'" + (memberData.memberRo == 'PA' ? 'selected' : '') + ">PA</option>";
			select_memberRo += "<option value='D505'" + (memberData.memberRo == 'SA' ? 'selected' : '') + ">SA</option>";
			select_memberRo += "<option value='D506'" + (memberData.memberRo == 'DBA' ? 'selected' : '') + ">DBA</option>";
			select_memberRo += "</select>";
			
			
            // 입력 요소로 변환하여 다시 출력
            var editableRow = $('<tr>').append(
            	$('<td>').append($('<input type="checkBox" class="checkbox">').val(memberData.memberId)),
                $('<td>').append($('<input type="text" disabled="disabled" style="width: 60px;">').val(memberData.memberId)),
                $('<td>').append($('<input type="text" style="width: 40px;">').val(memberData.memberName)),
                $('<td>').append(select_memberGN).val(select_memberGN),
                $('<td>').append(select_memberDept).val(select_memberDept),
                $('<td>').append(select_memberRo).val(select_memberRo),
                //$('<td>').append(select_memberPos.attr('id', 'memberPos')).val(select_memberPos),
                $('<td>').append(select_memberPos).val(select_memberPos),
                $('<td>').append($('<input type="text" style="width: 90px;" id="memberTel">').val(memberData.memberTel)),
                $('<td>').append($('<input type="date" style="width: 100px;" id="memberStDay">').val(memberData.memberStDay)),
                $('<td>').append($('<input type="date" style="width: 100px;" id="memberLaDay">').val(memberData.memberLaDay)),
                $('<td>').append(select_memberSt).val(select_memberSt) 
            );
            $('#memberTable tbody').append(editableRow);
            editableRowList.push(editableRow);
        });
    });
	
	//2-2. 다중 수정(#m_modifyButton)버튼 클릭했을 때
	$("#modifyButton").click(function() {
		//let member_Tel = $("#member_Tel").val();//입력한 전화번호
		//let member_Tel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		let memberStDay = $("#memberStDay").val();
		let memberLaDay = $("#memberLaDay").val();
		
		if(!memberLaDay.length == 0){
			if (memberLaDay < memberStDay) {
		        alert("퇴사날짜는 입사날짜보다 이전일 수 없습니다.");
		        return;
			}
	    }
		
		var modifyList = [];
		editableRowList.forEach(function(row) {
	        // row는 jQuery 객체이므로, 각 input/select 태그의 값을 추출합니다.
	        var rowObj = {
	            memberId: row.find('input[type="text"][disabled="disabled"]').val(),
	            memberName: row.find('input[type="text"]:not([disabled])').val(),
	            memberGn: row.find('#memberGn').val(),
	            memberDept: row.find('#memberDept').val(),
	            memberRo: row.find('#memberRo').val(),
	            memberPos: row.find('#memberPos').val(),
	            memberTel: row.find('#memberTel').val(),
	            memberStDay: row.find('#memberStDay').val(),
	            memberLaDay: row.find('#memberLaDay').val(),
	            memberSt: row.find('#memberSt').val()
	        };

	        // 수집된 데이터를 dataToSend 배열에 추가
	        modifyList.push(rowObj);
	    });
		
	   /*  var modifyList = {};
	    $('input[type="checkbox"].checkbox:checked').each(function() {
	        var memberRow = $(this).closest('tr');

	        var modifyList = {
	            memberId: memberRow.find('input[type="text"][disabled="disabled"]').val(),
	            memberName: memberRow.find('input[type="text"]:not([disabled])').val(),
	            memberGn: memberRow.find('#memberGn').val(),
	            memberDept: memberRow.find('#memberDept').val(),
	            memberRo: memberRow.find('#memberRo').val(),
	            memberPos: memberRow.find('#memberPos').val(),
	            memberTel: memberRow.find('input[type="text"][disabled="disabled"]').val()
	        };
	    });
		
	    console.log("modifyList : " + modifyList); */
	    
		$.ajax({
			type : 'POST',
			url: '/member/memberModify',
			contentType : 'application/json; charset=utf-8',
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        },
			data: JSON.stringify(modifyList),
			success : function(result) { // 결과 성공 콜백함수        
				if(result == true){
					alert("수정 성공");
					var pageNo = $("#pageNo").val();
					location.href = "/member/memberList";
					//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
				}else if(result == false){
					//alert("수정하려는 번호는 현재 존재하는 번호입니다.");
					alert("수정 실패");
					var pageNo = $("#pageNo").val();
					location.href = "/member/memberList";
				}				
			},    
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("수정 실패");
			}
		}); //ajax EndPoint
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
});//document EndPoint

function submitPost(memberId, pageNo) {
	//alert("pageNo : " + pageNo);
	//alert("member_Id : " + member_Id);
    // 폼 생성
    var selectedList = [];
    selectedList.push(memberId);
    alert("selectedListselectedList : " + selectedList);
    
    var form = $('<form></form>', {
        method: 'POST',
        action: '/member/memberRead'
    });

    // memberId와 pageNo 값을 input으로 추가
    selectedList.forEach(function(item) {
        form.append($('<input>', {
            type: 'hidden',
            name: 'selectedList[]', // 서버에서 배열로 인식할 수 있도록 이름에 대괄호를 추가
            value: memberId
        }));
    });

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

function getMemberList(element){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var choiceValue = element.value;
	var pageNo = document.getElementById("pageNo").value; 		
	var searchCnt = $("#searchCnt").val();
	var memberStatus = $("#memberStatus").val();
	
	var buttons = document.querySelectorAll('.choiceSort button');

    // 모든 버튼의 굵기를 초기화합니다.
    buttons.forEach(function(button) {
        button.style.fontWeight = 'normal';
    });

    // 클릭된 버튼만 굵게 표시합니다.
    element.style.fontWeight = 'bold';
	
    var data = {
    	"choiceValue" : choiceValue,
        "pageNo" : pageNo,
        "searchCnt" : searchCnt,
		"memberStatus" : memberStatus    		
    }
    
	$.ajax({
		type : 'POST',
		url : '/member/memberList',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data),
        success : function(resultMap) {
        	var memberList = resultMap.memberList;
			var pageDto = resultMap.pageDto;
			$("#choiceValue").val(choiceValue);
			$("#memberTable tbody").empty();
		
   			if (memberList && memberList.length > 0) {
   				for (let i = 0; i < memberList.length; i++) {
            		var newRow = $("<tr>");
            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
            		newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
            		newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
            		newRow.append("<td>" + memberList[i].memberName + "</td>");
            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
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
   				$("#memberTable tbody").empty();
   		    	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
   			}
     	},
     	error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("정렬 실패");
		}
	});	
}

function go(pageNo){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var choiceValue = $("#choiceValue").val();
	var searchCnt = $("#searchCnt").val();
	var memberStatus = $("#memberStatus").val();
	$("#pageNo").val(pageNo);
	
	var data = {
    	"choiceValue" : choiceValue,
        "pageNo" : pageNo,
        "searchCnt" : searchCnt,
		"memberStatus" : memberStatus    		
    }
	
	$.ajax({
		type : 'POST',
		url: '/member/memberList',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data),
		/* data: {
			 "pageNo" : pageNo,
			 "choiceValue" : choiceValue,
			 "searchCnt" : searchCnt,
			 "memberStatus" : memberStatus
		}, */
		success : function(resultMap) { // 결과 성공 콜백함수
			//var pageNoPost = resultMap.pageNoPost;
			$("#choiceValue").val(choiceValue);
			//$("#pageNoPost").val(pageNoPost);
			
			var memberList = resultMap.memberList;
			var pageDto = resultMap.pageDto;
			$("#memberTable tbody").empty();
			
       		if (memberList && memberList.length > 0) {
       			for (let i = 0; i < memberList.length; i++) {
       				var newRow = $("<tr>");
            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
            		newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
            		newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
            		newRow.append("<td>" + memberList[i].memberName + "</td>");
            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
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
       			$("#memberTable tbody").empty();
       		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
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

function downloadButton(){
	window.location.href ="/member/download";
}
</script>
</html>
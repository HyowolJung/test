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
/* body {
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
} */
/* .DetailedSearchForm {
	display: none;
} */

</style>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%@include file="/WEB-INF/views/common/sideBar.jsp" %>
<div class="total-div">
<div ><!-- style="display: none;" -->
	<input id="pageNo" name="pageNo" value="${empty pageDto.cri.pageNo ? 1 : pageDto.cri.pageNo}" disabled="disabled" style="display: none"><!--  -->
	<input type="text" id="member_Id_SE" value="<s:authentication property="principal.username"/>" disabled="disabled" style="display: none">
	<%-- <input type="text" id="member_Id_SE" value="${member_Id_SE}" style="display: none"> --%><!-- type="hidden" -->
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
	  <option value="name" <c:if test = "${pageDto.cri.searchField == 'name' }">selected</c:if>>이름</option>
	  <option value="tel" ${pageDto.cri.searchField == 'tel' ? 'selected' : ''}>전화번호</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>입사일</label>
	<input type="date" name="searchDate" value="${pageDto.cri.searchStDay}" id="searchStDay" onblur="validateDate()">
	~
	<label>퇴사일</label>
	<input type="date" name="searchDate" value="${pageDto.cri.searchLaDay}" id="searchLaDay" onblur="validateDate()">
	<%-- <input type="date" name="searchDate" ${pageDto.cri.search_endDate == 'search_endDate' ? 'selected' : ''} id = "search_endDate" onblur="validateDate2()"> --%>
	
	<button id="searchButton">조회</button>
	<button id="resetButton">초기화</button>
	<button id="downloadButton" onclick="downloadButton()">다운로드</button>
</div>

<div>
<br><br>
<table border="1" id="memberTable">
	<thead>
		<tr>
			<th><input type="checkbox" id="checkboxAll"></th>
			<!-- <th>번호</th> -->
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
			<!-- <th>상태</th> -->
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
</div>

</body>
<script type="text/javascript">
$(document).ready(function() {
	$('.choiceSort a').click(function(event) {
	    event.preventDefault(); // 링크의 기본 동작 방지

	    // 모든 링크에서 'selected' 클래스 제거
	    $('.choiceSort a').removeClass('selected');

	    // 클릭된 링크에 'selected' 클래스 추가
	    $(this).addClass('selected');
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
	
	//1. 조회(#searchButton)버튼 클릭 했을 때
	$("#searchButton").click(function(){
		var searchStDay = $("#searchStDay").val();
		var searchLaDay = $("#searchLaDay").val();
		var searchField = $("#searchField").val(); 
		var searchWord = $("#searchWord").val();
		var pageNo = $("#pageNo").val(); 
		
		if (searchStDay && searchLaDay && searchStDay > searchLaDay) {
		    alert("퇴사일은 입사일보다 빠를 수 없어요.");
		    return;
		}
		
		var cri = {
				"searchStDay" : searchStDay,
				"searchLaDay" : searchLaDay,
				"searchField" : searchField,
				"searchWord" : searchWord,
		        "pageNo" : pageNo
		}
		
		$.ajax({
			type : 'POST',
			url: '/member/search',
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        },
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(cri),
			success : function(resultMap) { // 결과 성공 콜백함수
				$("#deleteButton").show();
	       		$("#selectButton").show();
	       		$("#modifyButton").hide();
	       		$("#backButton").hide();
	       		
				var memberList = resultMap.memberList;
				var pageDto = resultMap.pageDto;
				$("#memberTable tbody").empty();
				
           		if (memberList && memberList.length > 0) {
					//console.log("memberList가 있어요");     
					alert("조회를 성공했어요.");
           			for (let i = 0; i < memberList.length; i++) {
                    	var newRow = $("<tr>");
                    	newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
                    	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
                    	//newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
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
			/* var editableRow = $('<tr>').append(
				    $('<td>').append($('<input type="checkbox" class="checkbox">').val(memberData.memberId)),
				    $('<td>').append($('<input type="text" disabled="disabled" style="width: 60px;">').val(memberData.memberId).attr('id', 'memberId-' + memberData.memberId)),
				    $('<td>').append($('<input type="text" style="width: 40px;">').val(memberData.memberName).attr('id', 'memberName-' + memberData.memberId)),
				    $('<td>').append(select_memberGN.attr('id', 'memberGn-' + memberData.memberId)),
				    $('<td>').append(select_memberDept.attr('id', 'memberDept-' + memberData.memberId)),
				    $('<td>').append(select_memberRo.attr('id', 'memberRo-' + memberData.memberId)),
				    $('<td>').append(select_memberPos.attr('id', 'memberPos-' + memberData.memberId)),
				    $('<td>').append($('<input type="text" style="width: 90px;" disabled="disabled">').val(memberData.memberTel).attr('id', 'memberTel-' + memberData.memberId)),
				    $('<td>').append($('<input type="date" style="width: 100px;">').val(memberData.memberStDay).attr('id', 'memberStDay-' + memberData.memberId)),
				    $('<td>').append($('<input type="date" style="width: 100px;">').val(memberData.memberLaDay).attr('id', 'memberLaDay-' + memberData.memberId)),
				    $('<td>').append(select_memberSt.attr('id', 'memberSt-' + memberData.memberId))
				);

				$('#memberTable tbody').append(editableRow);
				editableRowList.push(editableRow); */
        });
    });
	
	//2-2. 수정버튼 클릭했을 때
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
				alert("수정 성공");
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
		var startDateInput =$("#searchStDay");
		var endDateInput = $("#searchLaDay");
		startDateInput.value = "";
		endDateInput.value = "";
	});//$("#resetButton").click(function() { EndPoint
		
	$("#backButton").click(function() {
		location.href="/member/search";
	});
	
	//var pageNo = $("#pageNo").val();
});//document EndPoint

function submitPost(memberId, pageNo) {
	//alert("pageNo : " + pageNo);
	//alert("member_Id : " + member_Id);
    // 폼 생성
    var selectedList = [];
    selectedList.push(memberId);
    //alert("selectedListselectedList : " + selectedList);
    
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

function validateDate() {
	var searchStDay = $("#searchStDay").val();
	
    // 입력된 날짜 형식 확인 (YYYY-MM-DD)
    var dateFormat = /^\d{4}-\d{2}-\d{2}$/;
    var startDateInput = $("#searchStDay");
    
    /* if (!search_startDate) {
		alert("유효하지 않은 입력입니다1.");
		startDateInput.value = "";
        return;
    } */
    if (!searchStDay) {
        setTimeout(function() {
            alert("유효하지 않은 입력입니다1.");
        }, 0);
        startDateInput.value = "";
        href.location = "/member/memberList";
        return;
    }
    
   if (searchStDay && !searchStDay.match(dateFormat)) {
       alert("다시 한번 확인해주세요.");
       startDateInput.value = "";
       return;
   }
   
    var inputDate = searchStDay.split("-");
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
    
 // 입력된 날짜 형식 확인 (YYYY-MM-DD)
    var dateFormat = /^\d{4}-\d{2}-\d{2}$/;
    var endDateInput = $("#searchLaDay");
    
    /* if (!search_endDate) {
    	alert("유효하지 않은 입력입니다2.");
    	endDateInput.value = "";
    	return;
    } */
    
    if (!searchLaDay) {
        setTimeout(function() {
            alert("유효하지 않은 입력입니다1.");
        }, 0);
        endDateInput.value = "";
        href.location = "/member/memberList";
        return;
    }
    
    if (searchLaDay && !searchLaDay.match(dateFormat)) {
        alert("다시 한번 확인해주세요.");
        endDateInput.value = "";
        return;
    }

    var inputDate = searchLaDay.split("-");
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
	var searchStDay = $("#searchStDay").val();
	var searchLaDay = $("#searchLaDay").val();
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	var cri = {
			"searchStDay" : searchStDay,
			"searchLaDay" : searchLaDay,
			"searchField" : searchField,
			"searchWord" : searchWord,
	        "pageNo" : pageNo
	}
	
	$.ajax({
		type : 'POST',
		url: '/member/search',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(cri),
		success : function(resultMap) { // 결과 성공 콜백함수
			//location.href = "/member/memberList?pageNo=" + pageNo;
			//location.reload(true);
			$("#searchField").val(searchField);
			$("#searchWord").val(searchWord);
			$("#searchStDay").val(searchStDay);
			$("#searchLaDay").val(searchLaDay);
			
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
            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
            		newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
            		//newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
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
                /* 	var newRow = $("<tr>");
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
                	$("#memberTable tbody").append(newRow); */
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
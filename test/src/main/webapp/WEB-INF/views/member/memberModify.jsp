<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>회원 수정</title>
<style>
table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 20px;
	text-align: center;
}

table, th, td {
	border: 1px solid #ddd;
}

th, td {
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

button {
	padding: 10px;
	cursor: pointer;
	margin-bottom: 10px;
}

input[type="radio"] {
	margin-left: 5px;
}

.centered {
	text-align: center;
}
</style>
</head>
<body>
<%-- <%@include file="/WEB-INF/views/common/header.jsp" %><br><br> --%>
<%@include file="/WEB-INF/views/common/header.jsp"%><br>
<div class="centered">
멤버 수정화면
<br><br>
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"><!--  type="hidden" --> 
<table border="1" id="membersTable">
	<thead>
		<tr>
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>이메일</th>
			<th>직급</th>
			<th>부서</th>
			<th>전화번호</th>
			<th>상태</th>
			<th>팀</th>
			<th>권한</th>
			<th>직과</th>
			<th>입사일</th>
			<th>퇴사일</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>	
</table>
<button type="button" id="modifyButton">수정하기</button>
<button type="button" id="back1" onclick="back()">뒤로 가기</button>
</div>

<br><br>
<div class="centered">
참여중인 프로젝트 <button type="button" id="push">추가</button><button type="button" id="removeButton2">삭제</button>
<table border="1" id="mem_pro_List">
<thead>
	<tr>
		<th>ㅁ</th>
		<th>번호(프로젝트)</th> <!-- style="display: none" -->
		<th>이름(프로젝트)</th>
		<th>투입일</th>
		<th>철수일</th>
	</tr>
</thead>
<tbody>
	<c:choose>
    <c:when test="${empty memberprojectList}">
      <tr>
        <td colspan="5" style="text-align: center;">참여중인 프로젝트가 없습니다</td>
      </tr>
    </c:when>
    <c:otherwise>
      <c:forEach var="memberproject" items="${memberprojectList}">
        <tr>
          <td><input type="checkbox"></td>
          <td>${memberproject['PROJECT_ID']}</td> <!-- style="display: none" -->
          <td>${memberproject['PROJECT_NAME']}</td>
          <td><input type="date" value="${memberproject['PUSHDATE']}"></td>
          <td><input type="date" value="${memberproject['PULLDATE']}"></td>
        </tr>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</tbody>
</table>
<button type="button" id="modifyButton2">수정</button>
<button type="button" id="back2" onclick="back()">뒤로 가기</button>
</div>	
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var memberData = JSON.parse(localStorage.getItem('members'));

if (memberData) {
    // 각 멤버에 대해 테이블 행 생성
    
    $.each(memberData, function(index, memberData) {
       /* var row = '<tr>' +
            '<td>' + member.memberId + '</td>' +
            '<td>' + member.memberName + '</td>' +
            '<td>' + member.memberGn + '</td>' +
            '<td>' + member.memberEmail + '</td>' +
            '<td>' + member.memberPos + '</td>' +
            '<td>' + member.memberDept + '</td>' +
            '<td>' + member.memberTel + '</td>' +
            '<td>' + member.memberSt + '</td>' +
            '<td>' + member.memberTeam + '</td>' +
            '<td>' + member.memberAuth + '</td>' +
            '<td>' + member.memberStDay + '</td>' +
            '<td>' + (member.memberLaDay || '(미정)') + '</td>' +
            '</tr>';*/
    
            var select_memberGn = "<select id='memberGn'>";
            select_memberGn += "<option value=''" + (memberData.memberGn == '(미정)' ? 'selected' : '') + ">선택</option>";
            select_memberGn += "<option value='D101'" + (memberData.memberGn == '남성' ? 'selected' : '') + ">남성</option>";
            select_memberGn += "<option value='D102'" + (memberData.memberGn == '여성' ? " selected" : '') + ">여성</option>";
            select_memberGn += "</select>";

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
            
			var row = '<tr>' +
		    '<td><input type="text" id="memberId" value="' + memberData.memberId + '" disabled="disabled" style="width: 70px;"></td>' +
		    '<td><input type="text" id="memberName" value="' + memberData.memberName + '" style="width: 50px;"></td>' +
		    '<td>' + select_memberGn + '</td>' +
		    '<td><input type="email" id="memberEmail" value="' + memberData.memberEmail + '" style="width: 90px;"></td>' +
		    '<td>' + select_memberPos + '</td>' +
		    '<td>' + select_memberDept + '</td>' +
		    '<td><input type="tel" id="memberTel" value="' + memberData.memberTel + '" style="width: 100px;"></td>' +
		    '<td>' + select_memberSt + '</td>' +
		    '<td>' + memberData.memberTeam + '</td>' +
		    '<td>' + memberData.memberAuth + '</td>' +
		    '<td>' + select_memberRo + '</td>' +
		    '<td><input type="date" id="memberStDay" value="' + memberData.memberStDay + '" style="width: 100px;"></td>' +
		    '<td><input type="date" id="memberLaDay" value="' + memberData.memberLaDay + '" style="width: 100px;"></td>' +
		    '</tr>';
        
     	// 생성된 행을 테이블의 tbody에 추가
		$('#membersTable tbody').append(row);
    });
}

function back() {
	var memberId = $("#memberId").val();
	var pageNo = $("#pageNo").val();
	alert("member_Id : " + member_Id + " / pageNo : " + pageNo);	
	
	var form = $('<form></form>', {
        method: 'POST',
        action: '/member/memberRead'
    });
	
	// memberId와 pageNo 값을 input으로 추가
    form.append($('<input>', {
        type: 'hidden',
        name: 'memberId',
        value: memberId
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
    
    $('body').append(form);
	form.submit();
}


$(document).ready(function() {
//1. 수정버튼 클릭
$("#modifyButton").click(function() {
	let memberTel = $("#memberTel").val();//입력한 전화번호
	let memberTel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	let memberId = $("#memberId").val();
	let memberStDay = $("#memberStDay").val();
	let memberLaDay = $("#memberLaDay").val();
	let memberDept = $("#memberDept").val();
	
	if(!memberLaDay.length == 0){
		if (memberLaDay < memberStDay) {
	        alert("퇴사날짜는 입사날짜보다 이전일 수 없습니다.");
	        return;
		}
    }
		
	//2-1. 전화번호 유효성 체크(비어있는지)
	if(memberTel.length == 0){
		alert("전화번호는 반드시 입력해야 합니다.");
		return;
	}else if(memberTel.length != 0){
		//2-2. 전화번호 유효성체크(적절한 조합인지)
		if (memberTel_Check.test(memberTel) != true){
			alert("적절한 형식이 아닙니다.");
			return;
		}else if(memberTel_Check.test(memberTel) == true){	//유효성 통과하면
			if(memberLaDay.length == 0){
				//console.log("퇴사일이 없어요.");
				//var member_Department = $("#member_Department").val();
				let modifyData = {
					memberId : $("#memberId").val()
					,memberName : $("#memberName").val()
					,memberEmail : $("#memberEmail").val()
					,memberPos : $("#memberPos").val()
					,memberDept : $("#memberDept").val()
					,memberGn : $("#memberGn").val()
					,memberTel : $("#memberTel").val()
					,memberRo : $("memberRo").val()
					,memberSt : $("memberSt").val()
					,memberStDay : $("#memberStDay").val()
				}
				
				let modifyDataArray = [modifyData];
				let modifyList = JSON.stringify(modifyDataArray);
				//,member_Skill_DB : $("#member_Skill_DB").val()
				//,member_Skill_Language : $("#member_Skill_Language").val()
				//console.log("member_Department : " , member_Department);	
				$.ajax({
					type : 'POST',
					url: '/member/memberModify',
					contentType : 'application/json; charset=utf-8',
					beforeSend: function(xhr) {
	            		xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        		},
					//data: JSON.stringify(modifyList),
					data: modifyList,
					success : function(result) { // 결과 성공 콜백함수        
						if(result == true){
							alert("수정 성공");
							var pageNo = $("#pageNo").val();
							//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
						}else if(result == false){
							alert("수정하려는 번호는 현재 존재하는 번호입니다.");
						}				
					},    
					error : function(request, status, error) { // 결과 에러 콜백함수        
						alert("수정 실패");
					}
				}); //ajax EndPoint
			}else if(!memberLaDay.length == 0){
				console.log("퇴사일이 있어요.");
				//let member_endDate_ck = 1;
				let modifyData = {
					memberId : $("#memberId").val()
					,memberName : $("#memberName").val()
					,memberPos : $("#memberPos").val()
					,memberDept : $("#memberDept").val()
					,memberGn : $("#memberGn").val()
					,memberTel : $("#memberTel").val()
					,memberRo : $("memberRo").val()
					,memberSt : $("memberSt").val()
					,memberStDay : $("#memberStDay").val()
					,memberLaDay : $("#memberLaDay").val()
				}	
		
				$.ajax({
					type : 'POST',
					url: '/member/memberModify',
					beforeSend: function(xhr) {
	            		xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        		},
	        		contentType : 'application/json; charset=utf-8',
					data: JSON.stringify(modifyData),
					success : function(result) { // 결과 성공 콜백함수        
						if(result == true){
							alert("수정 성공");
							var pageNo = $("#pageNo").val();
							//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
						}else if(result == false){
							alert("수정하려는 번호는 현재 존재하는 번호입니다.");
						}				
					},    
					error : function(request, status, error) { // 결과 에러 콜백함수        
						alert("수정 실패");
					}
				}); //ajax EndPoint
			}// elseIf EndPoint
		}// elseIf EndPoint
	}// elseIf EndPoint
});//$("#modifyButton").click(function() {
	
$("#push").click(function() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	//alert("token : " + token + " /header : " + header);
	
    var member_Id = $("#member_Id").val();
    var member_Name = $("#member_Name").val();
    localStorage.setItem('member_Id', member_Id);
    localStorage.setItem('member_Name', member_Name);
    
    //var csrfTokenName = $("meta[name='_csrf_header']").attr("content"); // CSRF 토큰의 이름을 가져옵니다.
    //var csrfTokenValue = $("meta[name='_csrf']").attr("content"); // CSRF 토큰의 값을 가져옵니다.
    
    // 팝업 옵션 설정
    let popOption = "width=1150, height=650, top=200, left=300, scrollbars=yes";

    // 미리 팝업 창을 열어 둡니다.
    var popup = window.open('', 'pop', popOption);
    if (!popup) return; // 팝업 차단 여부 확인

    // 임시 폼 생성 및 속성 설정
    var form = document.createElement("form");
    form.target = "pop";
    form.method = "POST";
    form.action = "/popup/popProject";

    // member_Id 필드 추가
    var idInput = document.createElement("input");
    idInput.type = "hidden";
    idInput.name = "member_Id";
    idInput.value = member_Id;
    form.appendChild(idInput);

    // member_Name 필드 추가
    var nameInput = document.createElement("input");
    nameInput.type = "hidden";
    nameInput.name = "member_Name";
    nameInput.value = member_Name;
    form.appendChild(nameInput);
	
    /* var csrfInput = document.createElement("input");
    csrfInput.type = "hidden";
    csrfInput.name = header; // 서버에서 요구하는 CSRF 토큰의 이름을 입력 필드의 이름으로 설정합니다.
    csrfInput.value = token; // CSRF 토큰의 값을 입력 필드의 값으로 설정합니다.
    form.appendChild(csrfInput); */
    
 	// CSRF 토큰 필드 추가
    /* var csrfToken = document.createElement("input");
    csrfToken.type = "hidden";
    csrfToken.name = $("meta[name='_csrf_header']").attr("content"); // 토큰 이름 동적으로 가져오기
    csrfToken.value = $("meta[name='_csrf']").attr("content"); // 토큰 값 동적으로 가져오기
    form.appendChild(csrfToken); */
    
    /* <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" /> */
    
    var csrfInput = document.createElement("input");
    csrfInput.type = "hidden";
    csrfInput.name = '${_csrf.parameterName}'; // 서버에서 이 헤더 이름을 기대합니다.
    csrfInput.value = '${_csrf.token}';
    form.appendChild(csrfInput);
    
    /* form.append($('<input>', {
		type : 'hidden',
		name : '${_csrf.parameterName}',
		value : '${_csrf.token}'
	})); */
    
    
    // 폼을 문서에 추가하지 않고 직접 팝업의 문서에 폼을 추가
    popup.document.body.appendChild(form);

    // 폼 제출
    form.submit();
});
	
	
/* $("#push").click(function() {
    var member_Id = $("#member_Id").val();
    var member_Name = $("#member_Name").val();
    localStorage.setItem('member_Id', member_Id);
    localStorage.setItem('member_Name', member_Name);
    // 팝업 옵션 설정
    let popOption = "width=1150, height=650, top=200, left=300, scrollbars=yes";

    // 미리 팝업 창을 열어 둡니다.
    var popup = window.open('', 'pop', popOption);
    if (!popup) return; // 팝업 차단 여부 확인

    // 임시 폼 생성 및 속성 설정
    var form = document.createElement("form");
    form.target = "pop";
    form.method = "POST";
    form.action = "/popup/popProject";

    // member_Id 필드 추가
    var idInput = document.createElement("input");
    idInput.type = "hidden";
    idInput.name = "member_Id";
    idInput.value = member_Id;
    form.appendChild(idInput);

    // member_Name 필드 추가
    var nameInput = document.createElement("input");
    nameInput.type = "hidden";
    nameInput.name = "member_Name";
    nameInput.value = member_Name;
    form.appendChild(nameInput);

    // 폼을 문서에 추가하지 않고 직접 팝업의 문서에 폼을 추가
    popup.document.body.appendChild(form);

    // 폼 제출
    form.submit();
}); */
	
	
	
	
	
	
	//2. 프로젝츠 추가 버튼 클릭
	/* $("#push").click(function() {
		var member_Id = $("#member_Id").val();
		var member_Name = $("#member_Name").val();
		localStorage.setItem('member_Name', member_Name);
		let popOption = "width = 1150px, height = 650px, top = 200px, left = 300px, scrollbars = yes";
		let openURL = '/popup/popProject?pageNo=1&member_Id='+member_Id;
		var popup = window.open(openURL, 'pop', popOption);
		$.ajax({
			type : 'GET',
			url: '/popup/popProject',
			data: {
				 "member_Id" : member_Id,
				 "member_Name" : member_Name
			},
			success: function(response) {
		        if (response === "Success") {
					//window.location.reload();
		        }
		    },
		}); //ajax EndPoint
	});//$("#push").click(function() { */

	var checkClicked = false; // 라디오 버튼 클릭 상태 추적 변수
	
	/* var selectedProjectData = [];
    // 라디오 버튼 클릭 이벤트 핸들러
    $("#mem_pro_List tbody input[type='checkbox']:checked").each(function() {
		console.log("선택되었다.");
        	
		var tr = $(this).closest("tr");

        	// 행의 데이터 추출
        	var member_Id = $("#member_Id").val();
        	var project_Id = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
        	// var projectName = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 이름
        	var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
        	var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
        
        	console.log("선택된 프로젝트: " + project_Id, pushDate, pullDate);
        
        	data = {
    			member_Id : $("#member_Id").val(),        		
            	project_Id: tr.find("td:nth-child(2)").text().trim(),
            	//projectName: tr.find("td:nth-child(3)").text().trim(),
            	pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
            	pullDate: tr.find("td:nth-child(5) input[type='date']").val()
        	};
        	
        	selectedProjectData.push(data);
    }); */
    
    $("#removeButton2").click(function() {
    	var selectedProjectData = [];
        // 라디오 버튼 클릭 이벤트 핸들러
        $("#mem_pro_List tbody input[type='checkbox']:checked").each(function() {
    		console.log("선택되었다.");
            	
    		var tr = $(this).closest("tr");

            // 행의 데이터 추출
            var member_Id = $("#member_Id").val();
            var project_Id = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
            //alert("선택된 프로젝트: " + project_Id, member_Id);
            data = {
        		member_Id : $("#member_Id").val(),        		
                project_Id: tr.find("td:nth-child(2)").text().trim()
                //projectName: tr.find("td:nth-child(3)").text().trim(),
                //pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
                //pullDate: tr.find("td:nth-child(5) input[type='date']").val()
            };
            	
            selectedProjectData.push(data);
        });   
        
    	$.ajax({
			type : 'POST',
			url: '/member/memberDelete2',
			contentType : 'application/json; charset=utf-8',
			beforeSend: function(xhr) {
        		xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
    		},
			data: JSON.stringify(selectedProjectData),
			success: function(result) {
				if(result = true){
					alert("삭제 성공");
					window.location.reload();
				}
				if(result = false){
					alert("삭제 실패");
				}
		        
		    },
		    error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("문제가 발생했어요");
			}
        });	//ajax EndPoint
    });
    
    $("#modifyButton2").click(function() {
    	var selectedProjectData = [];    	
		$("#mem_pro_List tbody input[type='checkbox']:checked").each(function() {
    		var tr = $(this).closest("tr");
   	        var member_Id = $("#member_Id").val();
   	        var project_Id = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
   	        // var projectName = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 이름
   	        var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
   	        var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
   	        var member_startDate = $("#member_startDate").val();
   	     	var member_endDate = $("#member_endDate").val();
   	        //console.log("선택된 프로젝트: " + project_Id, pushDate, pullDate);
   	        
   	        // 5. NULL 값 처리
    pushDate = pushDate || '9999-12-31'; // NULL 이면 최대 날짜로 설정
    pullDate = pullDate || '9999-12-31'; // NULL 이면 최대 날짜로 설정
    member_endDate = member_endDate || '9999-12-31'; // NULL 이면 최대 날짜로 설정

    // 1. 입사일은 퇴사일, 투입일, 철수일 보다 앞서야 한다.
    if ((member_startDate >= member_endDate && member_endDate !== '9999-12-31') || 
        (member_startDate >= pushDate && pushDate !== '9999-12-31') || 
        (member_startDate >= pullDate && pullDate !== '9999-12-31')) {
        alert("다시 한번 확인해주세요. 입사일은 퇴사일, 투입일, 철수일 보다 앞서야 합니다.");
        return false;
    }

    // 2. 퇴사일은 퇴사일, 투입일, 철수일 보다 늦어야 한다.
    if (member_endDate <= member_startDate || 
        (member_endDate <= pushDate && pushDate !== '9999-12-31') || 
        (member_endDate <= pullDate && pullDate !== '9999-12-31')) {
        alert("다시 한번 확인해주세요. 퇴사일은 입사일, 투입일, 철수일 보다 늦어야 합니다.");
        return false;
    }

    // 3. 투입일은 입사일 보다 늦고, 퇴사일, 철수일 보다 앞서야 한다.
    if ((pushDate <= member_startDate || pushDate >= member_endDate) && pushDate !== '9999-12-31') {
        alert("다시 한번 확인해주세요. 투입일은 입사일 보다 늦고, 퇴사일 보다 앞서야 합니다.");
        return false;
    }

    // 4. 철수일은 입사일, 투입일 보다 늦고, 퇴사일 보다 앞서야 한다.
    if ((pullDate <= member_startDate || pullDate <= pushDate || pullDate >= member_endDate) && pullDate !== '9999-12-31') {
        alert("다시 한번 확인해주세요. 철수일은 입사일, 투입일 보다 늦고, 퇴사일 보다 앞서야 합니다.");
        return false;
    }
   	     	
   	        data = {
   	    		member_Id : $("#member_Id").val(),        		
   	           	project_Id: tr.find("td:nth-child(2)").text().trim(),
   	           	//projectName: tr.find("td:nth-child(3)").text().trim(),
   	           	pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
   	           	pullDate: tr.find("td:nth-child(5) input[type='date']").val()
   	        };
   	        
   	        selectedProjectData.push(data);
   	    });    	
    	
        //console.log("여기서부터 해야함 : " + selectedProjectData);
        $.ajax({
    			type : 'POST',
    			url: '/member/memberModify2',
    			contentType : 'application/json; charset=utf-8',
    			beforeSend: function(xhr) {
            		xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        		},
				data: JSON.stringify(selectedProjectData),
    			success: function(result) {
					if(result = true){
						alert("수정 성공ㅇ");
						window.location.reload();
					}
					if(result = false){
						alert("수정 실패");
					}
    		        
    		    },
    		    error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("문제가 발생했어요");
				}
		});	//ajax EndPoint
    }); //$("#modifyButton2").click(function() EndPoint
});
</script>
	
	
<!-- 
if (!checkClicked) { // 라디오 버튼이 클릭되지 않았다면
            alert("수정할 데이터를 체크해주세욧");
        } else { // 라디오 버튼이 클릭되었다면
        	/* $('.checkbox:checked').each(function() {
        		let row = $(this).closest('tr');
        		 var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
                 var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
        	}; */
        	/* var tr = $(this).closest("tr");

            // 행의 데이터 추출
            var member_Id = $("#member_Id").val();
            var projectId = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
            var projectName = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 이름
            var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
            var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
            
            console.log("선택된 프로젝트: ", projectId, projectName, pushDate, pullDate);
            
            selectedProjectData = {
    			member_Id : $("#member_Id").val(),        		
            	projectId: tr.find("td:nth-child(2)").text().trim(),
                projectName: tr.find("td:nth-child(3)").text().trim(),
                pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
                pullDate: tr.find("td:nth-child(5) input[type='date']").val()
            }; */
}//else EndPoint
 -->	
</body>
</html>
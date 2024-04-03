<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>회원 상세정보</title>
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

    .center {
        text-align: center;
    }
</style>
</head>
<body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@include file="/WEB-INF/views/common/header.jsp"%><br>
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden">
<div class="center">
멤버 상세정보
<br>
<br>
 <!--  -->
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
		<c:forEach var="memberList" items="${memberList}">
			<tr>
				<td id="td_Id">${memberList.memberId }</td>
				<td>${memberList.memberName }</td>
				<td>${memberList.memberGn}</td>
				<td>${memberList.memberEmail}</td>
				<td>${memberList.memberPos}</td>
				<td>${memberList.memberDept}</td>
				<td>${memberList.memberTel }</td>
				<td>${memberList.memberSt }</td>
				<td>${memberList.memberTeam }</td>
				<td>${memberList.memberAuth }</td>
				<td>${memberList.memberRo }</td>
				<td>${memberList.memberStDay }</td>
				<%-- <td>${memberList.memberLaDay == '1900-01-01' ? '(미정)' :  memberList.memberLaDay}</td> --%>
				<td>${memberList.memberLaDay == null ? '(미정)' :  memberList.memberLaDay}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<button type="button" id="modify" onclick="submitPost()">수정</button>
<button type="button" id="back">뒤로 가기</button>
</div>
<br><br>
<div class="center">
참여중인 프로젝트
<br>
<br>
<table border="1">
<thead>
	<tr>
		<!-- <th>ㅁ</th> -->
		<th>번호(프로젝트)</th> <!-- style="display: none" -->
		<th>이름(프로젝트)</th>
		<!-- <th>언어</th>
		<th>데이터베이스</th> -->
		<th>투입일</th>
		<th>철수일</th>
	</tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${empty projectList}">
      <tr>
        <td colspan="4" style="text-align: center;">참여중인 프로젝트가 없습니다</td>
      </tr>
    </c:when>
    <c:otherwise>
		<c:forEach var="project" items="${projectList}">
    		<tr>
        		<!-- <td><input type="radio"></td> -->
        		<td>${project['PROJECT_ID']}</td> <!-- style="display: none" -->
        		<td>${project['PROJECT_NAME']}</td>
        		<td>${project['PUSHDATE'] == null ? '미정' : project['PUSHDATE']}</td>
        		<td>${project['PULLDATE'] == null ? '미정' : project['PULLDATE']}</td>
    			<%-- <td><fmt:formatDate value="${project['PUSHDATE']}" pattern="yyyy-MM-dd" /></td>
    			<td><fmt:formatDate value="${project['PULLDATE']}" pattern="yyyy-MM-dd" /></td> --%>
        		<%-- <td><fmt:formatDate value="${project['PULLDATE']}" pattern="yyyy-MM-dd" /></td> --%>
    		</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
</tbody>
</table>
</div>		
<script type="text/javascript">
//var member_Id = document.getElementById("td_Id").innerText;
//var pageNo = $("#pageNo").val();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function submitPost() {
	var members = [];

    $('#membersTable tr').each(function() {
        if (!this.rowIndex) return; // 첫 번째 행(헤더) 건너뛰기
        var member = {
        		memberId: $(this).find('td:nth-child(1)').text().trim(),
                memberName: $(this).find('td:nth-child(2)').text().trim(),
                memberGn: $(this).find('td:nth-child(3)').text().trim(),
                memberEmail: $(this).find('td:nth-child(4)').text().trim(),
                memberPos: $(this).find('td:nth-child(5)').text().trim(),
                memberDept: $(this).find('td:nth-child(6)').text().trim(),
                memberTel: $(this).find('td:nth-child(7)').text().trim(),
                memberSt: $(this).find('td:nth-child(8)').text().trim(),
                memberTeam: $(this).find('td:nth-child(9)').text().trim(),
                memberAuth: $(this).find('td:nth-child(10)').text().trim(),
                memberRo: $(this).find('td:nth-child(11)').text().trim(),
                memberStDay: $(this).find('td:nth-child(12)').text().trim(),
                memberLaDay: $(this).find('td:nth-child(13)').text().trim() === '(미정)' ? null : $(this).find('td:nth-child(12)').text().trim(),
        };
        members.push(member);
    });
	
    localStorage.setItem('members', JSON.stringify(members));
    window.location.href = "/member/memberModify";
    
   /*  var form = $('<form></form>', {
        method: 'POST',
        action: '/member/memberModify'
    });
    
    form.append($('<input>', {
        type: 'hidden',
        name: '${_csrf.parameterName}',
        value: '${_csrf.token}'
    }));
    
    $('body').append(form);
    form.submit(); */
}
/* function submitPost() {
    var memberId = document.getElementById("td_Id").innerText;
	var pageNo = $("#pageNo").val();
	
	var modifyList = [];
	modifyList.push(memberId);
	alert("memberId : " + memberId);
	alert("pageNo : " + pageNo);
	
    var form = $('<form></form>', {
        method: 'POST',
        action: '/member/memberModify'
    });

    modifyList.forEach(function(item) {
        form.append($('<input>', {
            type: 'hidden',
            name: 'modifyList[]',
            value: memberId
        }));
    });
    
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
} */

$("#back").click(function(){
	//location.href = "/member/memberList?pageNo=" + pageNo;
	location.href = "/member/search";
});
</script>
</body>
</html>
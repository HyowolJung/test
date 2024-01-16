<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
        text-align: left;
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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div class="centered">
멤버 상세정보
<br>
<br>
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"> <!--  -->
<table border="1">
	<thead>
		<tr>
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>직급</th>
			<th>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>입사일</th>
			<th>퇴사일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="memberList" items="${memberList}">
			<tr>
				<td id="td_Id">${memberList.member_Id }</td>
				<td>${memberList.member_Name }</td>
				<td>${memberList.member_Position}</td>
				<td>${memberList.member_Sex}</td>
				<td>${memberList.member_Tel }</td>
				<td>${memberList.member_Skill_Language}</td>
				<td>${memberList.member_Skill_DB}</td>
				<td>${memberList.member_startDate }</td>
				<%-- <td>${memberList.member_endDate == '1900-01-01' ? '미정' :  memberList.member_endDate}</td> --%>
				<td>${memberList.member_endDate == null ? '미정' :  memberList.member_endDate}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<button type="button" id="modify">수정</button>
<button type="button" id="back">뒤로 가기</button>
</div>
<br><br>
<div class="centered">
참여중인 프로젝트
<br>
<br>
<table border="1">
<thead>
	<tr>
		<!-- <th>ㅁ</th> -->
		<th style="display: none">번호(프로젝트)</th>
		<th>이름(프로젝트)</th>
		<!-- <th>언어</th>
		<th>데이터베이스</th> -->
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
		<c:forEach var="memberprojectList" items="${memberprojectList}">
			<tr>
				<!-- <td><input type="radio"></td> -->
				<td style="display: none">${memberprojectList.project_Id }</td>
				<td>${memberprojectList.project_Name }</td>
				<td>${memberprojectList.pushDate}</td>
				<td>${memberprojectList.pullDate} </td>
			</tr>
		</c:forEach>
	</c:otherwise>
	</c:choose>
</tbody>
</table>
</div>		
<script type="text/javascript">
var member_Id = document.getElementById("td_Id").innerText;
var pageNo = $("#pageNo").val();
//console.log("member_Id : " + member_Id);

$("#modify").click(function(){
	location.href = "/member/memberModify?member_Id=" + member_Id + "&pageNo=" + pageNo;
});

$("#back").click(function(){
	location.href = "/member/memberList?pageNo=" + pageNo;
});
</script>
</body>
</html>
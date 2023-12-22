<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 상세정보</title>
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
상세정보
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"> <!--  -->
<table border="1">
	<thead>
		<tr>
			<th>번호(회원)</th>
			<th>이름(회원)</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>투입일</th>
			<th>철수일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="projectList" items="${projectList}">
			<tr>
				<td id="td_Id">${projectList.project_Name }</td>
				<td>${projectList.custom_company_id }</td>
				<td>${projectList.project_Skill_Language}</td>
				<td>${projectList.project_Skill_DB} </td>
				<td>${projectList.project_startDate }</td>
				<td>${projectList.project_endDate}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<button type="button" id="modify">수정</button>
<button type="button" id="back">뒤로 가기</button>
<br><br>
참여중인 회원
<table border="1">
<thead>
	<tr>
		<th>아이디</th>
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
	<c:forEach var="projectmemberList" items="${projectmemberList}">
		<tr>
			<td><input type="radio"></td>
			<td>${projectmemberList.member_Id}</td>
			<td>${projectmemberList.member_Name}</td>
			<td>${projectmemberList.member_Skill_Language}</td>
			<td>${projectmemberList.member_Skill_DB} </td>
			<td>${projectmemberList.member_startDate}</td>
			<td>${projectmemberList.member_endDate}</td> 
		</tr>
	</c:forEach>
</tbody>
</table>
</div>		
<script type="text/javascript">
var project_Id = document.getElementById("td_Id").innerText;
var pageNo = $("#pageNo").val();
console.log("project_Id : " + project_Id);

$("#modify").click(function(){
	location.href = "/project/projectModify?project_Id=" + project_Id + "&pageNo=" + pageNo;
});

$("#back").click(function(){
	location.href = "/project/projectList?pageNo=" + pageNo;
});
</script>
</body>
</html>
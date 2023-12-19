<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
상세정보
<table border="1">
			<thead>
				<tr>
					<th>번호</th>
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
						<td>${memberList.member_Sex} </td>
						<td>${memberList.member_Tel }</td>
						<td>${memberList.member_Skill_Language}</td>
						<td>${memberList.member_Skill_DB}</td>
						<td>${memberList.member_startDate }</td>
						<td>${memberList.member_endDate }</td>
					</tr>
				</c:forEach>
			</tbody>
</table>
<button type="button" id="modify">수정</button>
<br><br>
참여중인 프로젝트
<table border="1">
<thead>
	<tr>
		<th>ㅁ</th>
		<th>번호(프로젝트)</th>
		<th>이름(프로젝트)</th>
		<th>언어</th>
		<th>데이터베이스</th>
		<th>투입일</th>
		<th>철수일</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="memberprojectList" items="${memberprojectList}">
		<tr>
			<td><input type="radio"></td>
        	<%-- <td>${memberprojectList.value.member_Id}</td> --%>
        	<%-- <td>${memberprojectList.value.project_Id}</td>
        	<td>${memberprojectList.value.project_Name}</td>
        	<td>${memberprojectList.value.project_Skill_Language}</td>
        	<td>${memberprojectList.value.project_Skill_DB}</td>
        	<td>${memberprojectList.value.project_startDate}</td>
        	<td>${memberprojectList.value.project_endDate}</td> --%>
			<td>${memberprojectList.project_Id }</td>
			<td>${memberprojectList.project_Name }</td>
			<td>${memberprojectList.project_Skill_Language}</td>
			<td>${memberprojectList.project_Skill_DB} </td>
			<td>${memberprojectList.project_startDate }</td>
			<td>${memberprojectList.project_endDate}</td> 
		</tr>
	</c:forEach>
</tbody>
</table>
		
		<script type="text/javascript">
			//let member_Id = $("#td_Id").val();
			var member_Id = document.getElementById("td_Id").innerText;
			console.log("member_Id : " + member_Id);
			$("#modify").click(function(){
				location.href = "/member/memberModify?member_Id=" + member_Id;
			});
		</script>
</body>
</html>

			<%-- <td>${member_projectList[member_Id] }</td>
			<td>${member_projectList.project_Id }</td>
			<td>${member_projectList.project_Name }</td>
			<td>${member_projectList.project_Skill_Language}</td>
			<td>${member_projectList.project_Skill_DB} </td>
			<td>${member_projectList.project_startDate }</td>
			<td>${member_projectList.project_endDate}</td> --%>
			<%-- <td>${memberprojectList['member_Id']}</td>
        	<td>${memberprojectList['project_Id']}</td>
        	<td>${memberprojectList['project_Name']}</td>
        	<td>${memberprojectList['project_Skill_Language']}</td>
        	<td>${memberprojectList['project_Skill_DB']}</td>
        	<td>${memberprojectList['project_startDate']}</td>
        	<td>${memberprojectList['project_endDate']}</td> --%>
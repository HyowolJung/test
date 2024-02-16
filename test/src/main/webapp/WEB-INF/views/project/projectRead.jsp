<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<div class="centered">
프로젝트 상세정보
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"> <!--  -->
<table border="1">
	<thead>
		<tr>
			<th>아이디(프로젝트)</th>
			<th>이름(프로젝트)</th>
			<th>고객사</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>투입일</th>
			<th>철수일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="projectList" items="${projectList}">
			<tr>
				<td id="td_Id">${projectList.project_Id }</td>
				<td>${projectList.project_Name }</td>
				<td>${projectList.custom_company_id == null ? '미정' : projectList.custom_company_id}</td>
				<td>${projectList.project_Skill_Language == null ? '미정' : projectList.project_Skill_Language}</td>
				<td>${projectList.project_Skill_DB == null ? '미정' : projectList.project_Skill_DB} </td>
				<%-- <td>${projectList.project_startDate }</td> --%>
				<td>${projectList.project_startDate == null ? '미정' : projectList.project_startDate}</td>
				<td>${projectList.project_endDate == null ? '미정' : projectList.project_endDate}</td>
				<%-- <td>${memberprojectList.pushDate == null ? '미정' : memberprojectList.pushDate}</td> --%>
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
		<th>사번</th>
		<th>이름</th>
		<!-- <th>성별</th> -->
		<th>직급</th>
		<th>전화번호</th>
		<th>언어</th>
		<th>데이터베이스</th>
		<th>투입일</th>
		<th>철수일</th>
	</tr>
</thead>
<tbody>
	<c:choose>
    <c:when test="${empty projectmemberList}">
      <tr>
        <td colspan="8" style="text-align: center;">참여중인 프로젝트가 없습니다</td>
      </tr>
    </c:when>
    <c:otherwise>
      <c:forEach var="projectmember" items="${projectmemberList}">
      	<tr>
        	<td>${projectmember['MEMBER_ID']}</td>
        	<td>${projectmember['MEMBER_NAME']}</td>
        	<td>${projectmember['MEMBER_POSITION'] == null ? '미정' : projectmember['MEMBER_POSITION']}</td>
        	<td>${projectmember['MEMBER_TEL']}</td>
        	<td>${projectmember['MEMBER_SKILL_LANGUAGE'] == null ? '미정' : projectmember['MEMBER_SKILL_LANGUAGE']}</td>
        	<td>${projectmember['MEMBER_SKILL_DB'] == null ? '미정' : projectmember['MEMBER_SKILL_DB']}</td>
        	<%-- <td><fmt:formatDate value="${projectmember['PUSHDATE']}" pattern="yyyy-MM-dd" /></td>
        	<td><fmt:formatDate value="${projectmember['PULLDATE']}" pattern="yyyy-MM-dd" /></td> --%>
        	<td>${projectmember['PUSHDATE'] == null ? '미정' : projectmember['PUSHDATE']}</td>
        	<td>${projectmember['PULLDATE'] == null ? '미정' : projectmember['PULLDATE']}</td>
        	<!-- 기타 필요한 데이터 필드 -->
    	</tr>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</tbody>
</table>
</div>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>		
<script type="text/javascript">
//const urlParams = new URLSearchParams(window.location.search);
//const member_Id = urlParams.get('member_Id');
var project_Id = document.getElementById("td_Id").innerText;
var pageNo = $("#pageNo").val();
console.log("project_Id : " + project_Id);

$("#modify").click(function(){
	location.href = "/project/projectModify?project_Id=" + project_Id + "&pageNo=" + pageNo;
	//location.href = "/project/projectModify";
});

$("#back").click(function(){
	location.href = "/project/projectList?pageNo=" + pageNo;
	//location.href = "/project/projectList";
});
</script>
</body>
</html>
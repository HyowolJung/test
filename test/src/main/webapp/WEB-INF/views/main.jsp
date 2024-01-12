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

메인페이지
<%@include file="/WEB-INF/views/common/WellCome.jsp" %><br><br>
<c:forEach var="loginCk" items="${loginCk }"> 
	${loginCk.member_Department }
	${loginCk.member_Id }
</c:forEach>
<div id="welcomeMessage" style="text-align: center">
	
	<%-- <%@include file="/WEB-INF/views/common/WellCome.jsp" %><br><br> --%>
   	<%-- <%@include file="/WEB-INF/views/common/WellCome.jsp" %><br><br> --%>
	<%-- <c:forEach var="loginCk" items="${loginCk}"> 
		<p>${loginCk.member_Id }</p> 
		<p id="result_member_Id" style="display: inline;">${loginCk.member_Id}</p>님 환영합니다.&nbsp;&nbsp;
		<a href="/logout" id="Logout" class="logout-button" style="display: inline;">로그아웃</a><br>
		
		<c:if test="${loginCk.member_Department == '인사부'}">
        	<a href="/member/memberList?pageNo=1" style="display: inline;">회원 관리</a>
    	</c:if>

    	<c:if test="${loginCk.member_Department == 'IT부'}">
        	<a href="/project/projectList?pageNo=1" style="display: inline;">프로젝트 관리</a>
    	</c:if>
	</c:forEach> --%>
</div>    
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"></script>
</html>
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
<a href="/board/boardList?pageNo=1" style="display: inline;">자유 게시판</a>
<c:if test="${member_Department == '인사부'}">
	<a href="/member/memberList?pageNo=1" style="display: inline;">회원 관리</a>
</c:if>
<c:if test="${member_Department == 'IT부'}">
 	<a href="/project/projectList?pageNo=1" style="display: inline;">프로젝트 관리</a>
</c:if>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"></script>
</html>
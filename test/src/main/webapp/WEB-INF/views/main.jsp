<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	font-family: Arial, sans-serif;
}

.main-content {
	display: flex;
	justify-content: space-around;
	margin: 20px;
}

.dashboard, .notifications, .quick-links {
	width: 30%;
	padding: 10px;
	background-color: #e9ecef;
	border-radius: 5px;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>
    <div class="main-content">
        <div class="dashboard">
            <h3>해야할 거</h3>
            <p>1. 3월 13일까지 거래서 제출</p>
            <p>2. 일일결산 밀린거 다하기</p>
        </div>
        <div class="notifications">
            <h3>공지사항</h3>
            <p>사장님의 말씀</p>
            <p>명현이가 전하는 회사소식</p>
        </div>
        <div class="quick-links">
            <h3>바로가기</h3>
            <a href="#">링크 1</a>
            <a href="#">링크 2</a>
            <a href="#">링크 3</a>
        </div>
    </div>
    <div class="footer">
        <p>회사명 | 연락처 정보 | 지원</p>
    </div>
</body>
<%--
<c:if test="${member_Department == '인사부'}">
	<a href="/member/memberList" style="display: inline;">회원 관리</a>
</c:if>
<c:if test="${member_Department == 'IT부'}">
 	<a href="/project/projectList?pageNo=1" style="display: inline;">프로젝트 관리</a>
</c:if>

</body> --%>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

</script>
</html>
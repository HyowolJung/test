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
도착.
<c:forEach var="selectFreeBoardList" items="${selectFreeBoardList}">
	<div class="board-item">${selectFreeBoardList.board_Title}</div>
	<div class="board-item">${selectFreeBoardList.board_Content}</div>
</c:forEach>
</body>
</html>
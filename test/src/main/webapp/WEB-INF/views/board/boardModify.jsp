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
	도착했어요.
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>글 타입</th>
					<th>글 제목</th>
					<th>글 내용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardList" items="${boardList}">
				<tr>
					<td><input type="text" name="BNO" id="BNO" VALUE="${boardList.BNO }" disabled="disabled" /></td>
					<td><input type="text" name="BType" id="BType" VALUE="${boardList.BType }" /></td>
					<td><input type="text" name="BTitle" id="BTitle" VALUE="${boardList.BTitle }" /></td>
					<td><input type="text" name="BContent" id="BContent" VALUE="${boardList.BContent }" /></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>



	</div>
</body>
</html>
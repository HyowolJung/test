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
					<td><input type="text" name="member_Id" id="member_Id" disabled="disabled" value ="${memberList.member_Id }"/></td>
					<td><input type="text" name="member_Name" id="member_Name" value ="${memberList.member_Name }"/></td>
					<%-- <td><input type="text" name="member_Position" id="member_Position" value ="${memberList.member_Position }"/></td> --%>
					<td>
						<select id="member_Position">
		  					<option value="D028" selected="selected">사원</option>
		  					<option value="D027">대리</option>
		  					<option value="D026">과장</option>
						</select>
					</td>
					<%-- <td><input type="text" name="member_Sex" id="member_Sex" value ="${memberList.member_Sex }"/></td> --%>
					<td>
						<select id="member_Sex">
		  					<option value="D011" selected="selected">남자</option>
		  					<option value="D012">여자</option>
						</select>
					</td><br>
					<td><input type="text" name="member_Tel" id="member_Tel" value ="${memberList.member_Tel }"/></td>
					<%-- <td><input type="text" name="member_Skill_DB" id="member_Skill_DB" value ="${memberList.member_Skill_DB }"/></td> --%>
					<td>
						<select id="member_Skill_Language">
		  					<option value="S010">JAVA</option>
		  					<option value="S011">PYTHON</option>
		  					<option value="S012">C++</option>
		  					<option value="S013">RUBY</option>
						</select>
					</td><br>
					<%-- <td><input type="text" name="member_Skill_Language" id="member_Skill_Language" value ="${memberList.member_Skill_Language }"/></td> --%>
					<td>
						<select id="member_Skill_DB">
		  					<option value="S020">ORACLE</option>
		 		 			<option value="S021">MSSQL</option>
		  					<option value="S022">MYSQL</option>
		  					<option value="S023">POSTGRESQL</option>
						</select>
					</td><br>
					<td><input type="date" name="member_startDate" id="member_startDate" value ="${memberList.member_startDate }"/></td>
					<td><input type="date" name="member_endDate" id="member_endDate" value ="${memberList.member_endDate }"/></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<button type="button" id="modify">수정</button>
		<script type="text/javascript">
			$("#modify").click(function{
				
			});
		</script>
</body>
</html>
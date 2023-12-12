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

		<button type="button" id="modifyButton">수정하기</button>
		


	</div>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#modifyButton").click(function() {
			console.log("수정버튼 클릭됨");
			
			let member_Tel = $("#member_Tel").val();//입력한 전화번호
			let member_Tel_Check = /^01([0|1|6|7|8|9])?([0-9]{3,4})?([0-9]{4})$/;
			
			//2-1. 전화번호 유효성 체크(비어있는지)
			if(member_Tel.length == 0){
				alert("전화번호는 반드시 입력해야 합니다.")
				return;
			}else if(member_Tel.length != 0){
				//2-2. 전화번호 유효성체크(적절한 조합인지)
				if (member_Tel_Check.test(member_Tel) != true){
					alert("적절한 형식이 아닙니다.")
					return;
				}else if(member_Tel_Check.test(member_Tel) == true){	//유효성 통과하면
					let modifyDatas = {
						member_Id : $("#member_Id").val()
						,member_Name : $("#member_Name").val()
						,member_Position : $("#member_Position").val()
						,member_Sex : $("#member_Sex").val()
						,member_Tel : $("#member_Tel").val()
						,member_Skill_DB : $("#member_Skill_DB").val()
						,member_Skill_Language : $("#member_Skill_Language").val()
						,member_startDate : $("#member_startDate").val()
						,member_endDate : $("#member_endDate").val()
					}	
				
					console.log("member_Name : " , member_Name);	
					$.ajax({
						type : 'POST',
						url: '/member/memberModify',
						contentType : 'application/json; charset=utf-8',
						data: JSON.stringify(modifyDatas),
						success : function(result) { // 결과 성공 콜백함수        
							if(result == true){
								alert("수정 성공");
								location.href = "/member/memberList";
							}else if(result == false){
								alert("수정하려는 번호는 현재 존재하는 번호입니다.");
							}				
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							alert("수정 실패");
						}
					}); //ajax EndPoint
				}// elseIf EndPoint
			}// elseIf EndPoint
		});
	});
	</script>
</body>
</html>
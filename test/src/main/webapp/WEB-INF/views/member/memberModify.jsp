<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
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
<div class="centered">
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"><!--  type="hidden" --> 
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
		<c:forEach var="memberList" items="${memberList}">
			<tr>
				<td><input type="text" name="member_Id" id="member_Id" disabled="disabled" value ="${memberList.member_Id }" style="width: 80px"/></td>
				<td><input type="text" name="member_Name" id="member_Name" value ="${memberList.member_Name }" style="width: 120px"/></td>
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
	  					<option value="D011" ${memberList.member_Sex == '남자' ? 'selected' : ''}>남자</option>
	  					<option value="D012" ${memberList.member_Sex == '여자' ? 'selected' : ''}>여자</option>
					</select>
				</td><br>
				<td><input type="text" name="member_Tel" id="member_Tel" value ="${memberList.member_Tel }"/></td>
				<%-- <td><input type="text" name="member_Skill_DB" id="member_Skill_DB" value ="${memberList.member_Skill_DB }"/></td> --%>
				<td>
					<select id="member_Skill_Language">
	  					<option value="S010" ${memberList.member_Skill_Language == 'JAVA' ? 'selected' : ''}>JAVA</option>
	  					<option value="S011" ${memberList.member_Skill_Language == 'PYTHON' ? 'selected' : ''}>PYTHON</option>
	  					<option value="S012" ${memberList.member_Skill_Language == 'C++' ? 'selected' : ''}>C++</option>
	  					<option value="S013" ${memberList.member_Skill_Language == 'RUBY' ? 'selected' : ''}>RUBY</option>
					</select>
				</td><br>
				<%-- <td><input type="text" name="member_Skill_Language" id="member_Skill_Language" value ="${memberList.member_Skill_Language }"/></td> --%>
				<td>
					<select id="member_Skill_DB">
	  					<option value="S020" ${memberList.member_Skill_DB == 'ORACLE' ? 'selected' : ''}>ORACLE</option>
	 		 			<option value="S021" ${memberList.member_Skill_DB == 'MSSQL' ? 'selected' : ''}>MSSQL</option>
	  					<option value="S022" ${memberList.member_Skill_DB == 'MYSQL' ? 'selected' : ''}>MYSQL</option>
	  					<option value="S023" ${memberList.member_Skill_DB == 'POSTGRESQL' ? 'selected' : ''}>POSTGRESQL</option>
					</select>
				</td><br>
				<td><input type="date" name="member_startDate" id="member_startDate" value ="${memberList.member_startDate }"/></td>
				<td><input type="date" name="member_endDate" id="member_endDate" value ="${memberList.member_endDate }"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<br><br>
참여중인 프로젝트 <button id="push">투입</button><button id="pull">철수</button>
<table border="1">
<thead>
	<tr>
		<!-- <th>ㅁ</th> -->
		<th>번호(프로젝트)</th>
		<th>이름(프로젝트)</th>
		<th>투입일</th>
		<th>철수일</th>
	</tr>
</thead>
<tbody>
	<c:forEach var="memberprojectList" items="${memberprojectList}">
		<tr>
			<!-- <td><input type="radio"></td> -->
			<td>${memberprojectList.project_Id }</td>
			<td>${memberprojectList.project_Name }</td>
			<td>${memberprojectList.pushDate}</td>
			<td>${memberprojectList.pullDate} </td>
		</tr>
	</c:forEach>
</tbody>
</table>

<button type="button" id="modifyButton">수정하기</button>
<button type="button" id="back">뒤로 가기</button>
	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		
		//1. 수정버튼 클릭
		$("#modifyButton").click(function() {
			console.log("수정버튼 클릭됨");
			
			let member_Tel = $("#member_Tel").val();//입력한 전화번호
			let member_Tel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			let member_Id = $("#member_Id").val();
			let member_startDate = $("#member_startDate").val();
			let member_endDate = $("#member_endDate").val();
			
			if(!member_endDate.length == 0){
				if (member_endDate < member_startDate) {
			        alert("퇴사날짜는 입사날짜보다 이전일 수 없습니다.");
			        return;
				}
		    }
			
			//2-1. 전화번호 유효성 체크(비어있는지)
			if(member_Tel.length == 0){
				alert("전화번호는 반드시 입력해야 합니다.");
				return;
			}else if(member_Tel.length != 0){
				//2-2. 전화번호 유효성체크(적절한 조합인지)
				if (member_Tel_Check.test(member_Tel) != true){
					alert("적절한 형식이 아닙니다.")
					return;
				}else if(member_Tel_Check.test(member_Tel) == true){	//유효성 통과하면
					if(member_endDate.length == 0){
						console.log("퇴사일이 없어요.");
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
									var pageNo = $("#pageNo").val();
									location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
								}else if(result == false){
									alert("수정하려는 번호는 현재 존재하는 번호입니다.");
								}				
							},    
							error : function(request, status, error) { // 결과 에러 콜백함수        
								alert("수정 실패");
							}
						}); //ajax EndPoint
				}else if(!member_endDate.length == 0){
					console.log("퇴사일이 있어요.");
					let member_endDate_ck = 1;
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
						,member_endDate_ck : member_endDate_ck
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
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
							}else if(result == false){
								alert("수정하려는 번호는 현재 존재하는 번호입니다.");
							}				
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							alert("수정 실패");
						}
					}); //ajax EndPoint
			}
			
			
		}// elseIf EndPoint
	}// elseIf EndPoint
});
	
	$("#back").click(function() {
		console.log("뒤로가기 클릭")
		var member_Id = $("#member_Id").val();
		var pageNo = $("#pageNo").val();
		location.href = "/member/memberRead?member_Id=" + member_Id +"&pageNo=" + pageNo;
	});
	
	//2. 프로젝츠 추가 버튼 클릭
	$("#push").click(function() {
		var member_Id = $("#member_Id").val();
		let popOption = "width = 1050xp, height = 650px, top = 200px, left = 300px, scrollbars = yes";
		//let openURL = '/popup/popProject';
		let openURL = '/popup/popProject?pageNo=1&member_Id='+member_Id;
		window.open(openURL, 'pop', popOption);
		$.ajax({
			type : 'POST',
			url: '/popup/popProject',
			data: {
				 "member_Id" : member_Id
			},
			success: function(response) {
		        if (response === "Success") {
		        } else {
		        }
		    },
		}); //ajax EndPoint
	});//$("#insert").click(function() { EndPoint
		
});
	</script>
</body>
</html>
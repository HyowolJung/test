<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 수정</title>
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
프로젝트 수정화면
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"><!--  type="hidden" --> 
<table border="1">
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>고객사</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>시작일</th>
			<th>종료일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="projectList" items="${projectList}">
			<tr>
				<td><input type="text" name="project_Id" id="project_Id" disabled="disabled" value ="${projectList.project_Id }" style="width: 80px"/></td>
				<td><input type="text" name="project_Name" id="project_Name" value ="${projectList.project_Name }" style="width: 120px"/></td>
				<td>
	    			<select id="custom_company_id">
				        <option value="D061" ${projectList.custom_company_id == '삼성' ? 'selected' : ''}>삼성</option>
        				<option value="D062" ${projectList.custom_company_id == '엘지' ? 'selected' : ''}>엘지</option>
        				<option value="D063" ${projectList.custom_company_id == '애플' ? 'selected' : ''}>애플</option>
       				 	<option value="D064" ${projectList.custom_company_id == '구글' ? 'selected' : ''}>구글</option>
        				<option value="D065" ${projectList.custom_company_id == '아마존' ? 'selected' : ''}>아마존</option>
    				</select>
				</td>
				<td>
					<select id="project_Skill_Language">
	  					<option value="S010" ${projectList.project_Skill_Language == 'JAVA' ? 'selected' : ''}>JAVA</option>
	  					<option value="S011" ${projectList.project_Skill_Language == 'PYTHON' ? 'selected' : ''}>PYTHON</option>
	  					<option value="S012" ${projectList.project_Skill_Language == 'C++' ? 'selected' : ''}>C++</option>
	  					<option value="S013" ${projectList.project_Skill_Language == 'RUBY' ? 'selected' : ''}>RUBY</option>
					</select>
				</td><br>
				<td>
					<select id="project_Skill_DB">
	  					<option value="S020" ${projectList.project_Skill_DB == 'ORACLE' ? 'selected' : ''}>ORACLE</option>
	 		 			<option value="S021" ${projectList.project_Skill_DB == 'MSSQL' ? 'selected' : ''}>MSSQL</option>
	  					<option value="S022" ${projectList.project_Skill_DB == 'MYSQL' ? 'selected' : ''}>MYSQL</option>
	  					<option value="S023" ${projectList.project_Skill_DB == 'POSTGRESQL' ? 'selected' : ''}>POSTGRESQL</option>
					</select>
				</td><br>
				<td><input type="date" name="project_startDate" id="project_startDate" value = "${projectList.project_startDate }"/></td>
				<td><input type="date" name="project_endDate" id="project_endDate" value = "${projectList.project_endDate }"/></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
	<button type="button" id="modifyButton">수정하기</button>
	<button type="button" id="back">뒤로 가기</button>
</div>
참여중인 회원 <button type="button" id="push">추가</button><button type="button" id="removeButton2">삭제</button>
<table border="1">
<thead>
	<tr>
		<th>ㅁ</th>
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
	<c:forEach var="projectmember" items="${projectmemberList}">
		<tr>
			<td><input type="radio"></td>
        	<td>${projectmember['MEMBER_ID']}</td>
        	<td>${projectmember['MEMBER_NAME']}</td>
        	<td>${projectmember['MEMBER_POSITION']}</td>
        	<td>${projectmember['MEMBER_TEL']}</td>
        	<td>${projectmember['MEMBER_SKILL_LANGUAGE']}</td>
        	<td>${projectmember['MEMBER_SKILL_DB']}</td>
        	<td><input type="date" value="<fmt:formatDate value="${projectmember['PUSHDATE']}" pattern = "yyyy-MM-dd"/>"></td>
        	<td><input type="date" value="<fmt:formatDate value="${projectmember['PULLDATE']}" pattern = "yyyy-MM-dd"/>"></td>
    	</tr>
	</c:forEach>
</tbody>
</table>
	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#modifyButton").click(function() {
			console.log("수정버튼 클릭됨");
			
			let project_Id = $("#project_Id").val();
			let project_startDate = $("#project_startDate").val();
			let project_endDate = $("#project_endDate").val();
			
			//1. 종료일이 있을 때
			if(!project_endDate.length == 0){
				console.log("종료일이 있어요.")				
				if (project_endDate < project_startDate) {
			        alert("종료일은 시작일보다 이전일 수 없습니다.");
			        return;
				}
				if(project_endDate > project_startDate){
					let modifyDatas = {
						project_Id : $("#project_Id").val()
						,project_Name : $("#project_Name").val()
						,custom_company_id : $("#custom_company_id").val()
						,project_Skill_DB : $("#project_Skill_DB").val()
						,project_Skill_Language : $("#project_Skill_Language").val()
						,project_startDate : $("#project_startDate").val()
						,project_endDate : $("#project_endDate").val()
					}	
						
					console.log("project_Name : " , project_Name);	
					$.ajax({
						type : 'POST',
						url: '/project/projectModify',
						contentType : 'application/json; charset=utf-8',
						data: JSON.stringify(modifyDatas),
						success : function(result) { // 결과 성공 콜백함수        
							if(result == true){
								alert("수정 성공");
								var pageNo = $("#pageNo").val();
								location.href = "/project/projectRead?project_Id=" + project_Id + "&pageNo=" + pageNo;
							}				
						},    
						error : function(request, status, error) { // 결과 에러 콜백함수        
							alert("수정 실패");
						}
					}); //ajax EndPoint
				}//if(project_endDate > project_startDate) //EndPoint
			}//if(!project_endDate.length == 0){
			
			//2. 종료일이 없을 때
			if(project_endDate.length == 0){
				console.log("종료일이 없어요.");
				let modifyDatas = {
					project_Id : $("#project_Id").val()
					,project_Name : $("#project_Name").val()
					,custom_company_id : $("#custom_company_id").val()
					,project_Skill_DB : $("#project_Skill_DB").val()
					,project_Skill_Language : $("#project_Skill_Language").val()
					,project_startDate : $("#project_startDate").val()
					,project_endDate : $("#project_endDate").val()
				}	
				console.log("project_Name : " , project_Name);	
				$.ajax({
					type : 'POST',
					url: '/project/projectModify',
					contentType : 'application/json; charset=utf-8',
					data: JSON.stringify(modifyDatas),
					success : function(result) { // 결과 성공 콜백함수        
						if(result == true){
							alert("수정 성공");
							var pageNo = $("#pageNo").val();
							location.href = "/project/projectRead?project_Id=" + project_Id + "&pageNo=" + pageNo;
						}			
					},    
					error : function(request, status, error) { // 결과 에러 콜백함수        
						alert("수정 실패");
					}
				}); //ajax EndPoint
			}
	    });//$("#modifyButton").click(function() { EndPoint
		
		$("#back").click(function() {
			console.log("뒤로가기 클릭")
			let project_Id = $("#project_Id").val();
			var pageNo = $("#pageNo").val();
			location.href = "/project/projectRead?project_Id=" + project_Id +"&pageNo=" + pageNo;
		});
	    
		$("#push").click(function() {
			var project_Id = $("#project_Id").val();
			let popOption = "width = 1050xp, height = 650px, top = 200px, left = 300px, scrollbars = yes";
			//let openURL = '/popup/popProject';
			let openURL = '/popup/popMember?pageNo=1&project_Id=' + project_Id;
			window.open(openURL, 'pop', popOption);
			$.ajax({
				type : 'GET',
				url: '/popup/popMember',
				data: {
					 "project_Id" : project_Id
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
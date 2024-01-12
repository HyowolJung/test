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
<table border="1" id="pro_mem_List">
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
<button type="button" id="modifyButton2">수정</button>
<button type="button" id="back2">뒤로 가기</button>	
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
		
	    $("#back2").click(function() {
			console.log("뒤로가기 클릭")
			var project_Id = $("#project_Id").val();
			var pageNo = $("#pageNo").val();
			location.href = "/project/projectRead?project_Id=" + project_Id +"&pageNo=" + pageNo;
		});
	    	
		$("#back").click(function() {
			console.log("뒤로가기 클릭")
			let project_Id = $("#project_Id").val();
			var pageNo = $("#pageNo").val();
			location.href = "/project/projectRead?project_Id=" + project_Id +"&pageNo=" + pageNo;
		});
		
		var radioClicked = false; // 라디오 버튼 클릭 상태 추적 변수
		var selectedMemberData = {};
		
		 $("#pro_mem_List tbody").on("click", "input[type='radio']", function() {
		        radioClicked = true; // 라디오 버튼이 클릭되었다고 표시
		      	console.log("선택되었다.");
		        var tr = $(this).closest("tr");
				
		        // 행의 데이터 추출
		        var project_Id = $("#project_Id").val();
		        var project_Name = $("#project_Name").val();
		        var member_Id = tr.find("td:nth-child(2)").text().trim();//$("#member_Id").val();
		        var member_Name = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 번호
		        var pushDate = tr.find("td:nth-child(8) input[type='date']").val(); // 투입일
		        var pullDate = tr.find("td:nth-child(9) input[type='date']").val(); // 철수일
		        
		        console.log("선택된 pushDate 1 : " + pushDate);
		        console.log("선택된 pullDate 1 : " + pullDate);
		        
		        selectedMemberData = {
		            project_Id : $("#project_Id").val(),
		            project_Name : $("#project_Name").val(),
		            member_Id : tr.find("td:nth-child(2)").text().trim(),
		            member_Name : tr.find("td:nth-child(3)").text().trim(),
		            pushDate : tr.find("td:nth-child(8) input[type='date']").val(),
		            pullDate : tr.find("td:nth-child(9) input[type='date']").val()
		        };
		    });
		
		$("#modifyButton2").click(function() {
			alert("클릭이 됬습니다.")			
			//console.log("선택된 pushDate 2 : " + pushDate);
		    //console.log("선택된 pullDate 2 : " + pullDate);
	        if (!radioClicked) { // 라디오 버튼이 클릭되지 않았다면
	            alert("수정할 데이터를 체크해주세욧");
	        } else { // 라디오 버튼이 클릭되었다면
	            $.ajax({
	    			type : 'POST',
	    			url: '/project/projectModify2',
	    			contentType : 'application/json; charset=utf-8',
					data: JSON.stringify(selectedMemberData),
	    			success: function(result) {
						if(result = true){
							alert("수정 성공ㅇ");
							window.location.reload();
						}
						if(result = false){
							alert("수정 실패");
						}
	    		        
	    		    }
	            });	//ajax EndPoint
	        }//else EndPoint
	    }); //$("#modifyButton2").click(function() EndPoint
	    
	    $("#removeButton2").click(function() {
	    	$.ajax({
				type : 'POST',
				url: '/project/projectDelete2',
				contentType : 'application/json; charset=utf-8',
				data: JSON.stringify(selectedMemberData),
				success: function(result) {
					if(result = true){
						alert("삭제 성공");
						window.location.reload();
					}
					if(result = false){
						alert("삭제 실패");
					}
			        
			    }
	        });	//ajax EndPoint
	    });		
	    		
		/* $("#push").click(function() {	//1
			var project_Id = $("#project_Id").val();
			var project_Name = $("#project_Name").val();
			$.ajax({
				type : 'GET',
				url: '/popup/popMember',
				data: {
					"project_Id" : project_Id,
					"project_Name" : project_Name
				},
				success: function(response) {
					let popOption = "width = 1050px, height = 650px, top = 200px, left = 300px, scrollbars = yes";
					//let openURL = '/popup/popMember?pageNo=1&project_Id=' + project_Id;
					let openURL = '/popup/popMember?pageNo=1&project_Id=' + project_Id + '&project_Name=' + encodeURIComponent(project_Name);
					window.open(openURL, 'pop', popOption);
			    },
			}); //ajax EndPoint
		});//$("#push").click(function() { */
			
		/* $("#push").click(function() {
		    var project_Id = $("#project_Id").val();
		    var project_Name = $("#project_Name").val();
		    $.ajax({
		        type: 'GET',
		        url: '/popup/popMember',
		        data: {
		            "project_Id": project_Id,
		            "project_Name": project_Name
		        },
		        success: function(response) {
		            // 필요한 처리 수행
		        },
		    });
		}); */
		
		$("#push").click(function() {
		    var project_Id = $("#project_Id").val();
		    var project_Name = $("#project_Name").val();
		    let popOption = "width = 1050px, height = 650px, top = 200px, left = 300px, scrollbars = yes";
		    let openURL = '/popup/popMember?pageNo=1&project_Id=' + project_Id + '&project_Name=' + project_Name;
		    window.open(openURL, 'pop', popOption);
		});
});
</script>
</body>
</html>
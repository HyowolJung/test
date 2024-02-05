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
        text-align: center;
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
<%-- <%@include file="/WEB-INF/views/common/WellCome.jsp" %><br><br> --%>
<div class="centered">
멤버 수정화면
<br><br>
<input id="pageNo" name="pageNo" value="${pageNo}" type="hidden"><!--  type="hidden" --> 
<table border="1">
	<thead>
		<tr>
			<th style="display: none">사번</th>
			<th style='width: 30px'>이름</th>
			<th>성별</th>
			<th>직급</th>
			<th>부서</th>
			<th style='width: 50px'>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>입사일</th>
			<th>퇴사일</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${memberList != null}">
		<c:forEach var="memberList" items="${memberList}">
			<tr>
				<td style="display: none"><input type="text" name="member_Id" id="member_Id" disabled="disabled" value ="${memberList.member_Id }"/></td>
				<td><input type="text" name="member_Name" id="member_Name" value ="${memberList.member_Name }" style="width: 120px"/></td>
				<td>
					<select id="member_Sex">
						<option value="" ${memberList.member_Sex == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="D011" ${memberList.member_Sex == '남자' ? 'selected' : ''}>남자</option>
	  					<option value="D012" ${memberList.member_Sex == '여자' ? 'selected' : ''}>여자</option>
					</select>
				</td>
				<td>
					<select id="member_Position">
						<option value="" ${memberList.member_Position == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="D028" ${memberList.member_Position == '사원' ? 'selected' : ''}>사원</option>
	  					<option value="D027" ${memberList.member_Position == '대리' ? 'selected' : ''}>대리</option>
	  					<option value="D026" ${memberList.member_Position == '과장' ? 'selected' : ''}>과장</option>
					</select>
				</td>
				<td>
					<select id="member_Department">
						<option value="" ${memberList.member_Department == '미정' ? 'selected' : ''}>선택</option>
						<option value="A020" ${memberList.member_Department == '경영지원부' ? 'selected' : ''}>경영지원부</option>
						<option value="A021" ${memberList.member_Department == 'IT부' ? 'selected' : ''}>IT부</option>
						<option value="A022" ${memberList.member_Department == '인사부' ? 'selected' : ''}>인사부</option>
						<option value="A023" ${memberList.member_Department == '마케팅부' ? 'selected' : ''}>마케팅부</option>
					</select>
				</td>
				<td><input type="text" name="member_Tel" id="member_Tel" value ="${memberList.member_Tel }"/></td>
				<td>
					<select id="member_Skill_Language">
						<option value="" ${memberList.member_Skill_Language == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="S010" ${memberList.member_Skill_Language == 'JAVA' ? 'selected' : ''}>JAVA</option>
	  					<option value="S011" ${memberList.member_Skill_Language == 'PYTHON' ? 'selected' : ''}>PYTHON</option>
	  					<option value="S012" ${memberList.member_Skill_Language == 'C++' ? 'selected' : ''}>C++</option>
	  					<option value="S013" ${memberList.member_Skill_Language == 'RUBY' ? 'selected' : ''}>RUBY</option>
					</select>
				</td>
				<td>
					<select id="member_Skill_DB">
						<option value="" ${memberList.member_Skill_DB == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="S020" ${memberList.member_Skill_DB == 'ORACLE' ? 'selected' : ''}>ORACLE</option>
	 		 			<option value="S021" ${memberList.member_Skill_DB == 'MSSQL' ? 'selected' : ''}>MSSQL</option>
	  					<option value="S022" ${memberList.member_Skill_DB == 'MYSQL' ? 'selected' : ''}>MYSQL</option>
	  					<option value="S023" ${memberList.member_Skill_DB == 'POSTGRESQL' ? 'selected' : ''}>POSTGRESQL</option>
					</select>
				</td>
				<td><input type="date" name="member_startDate" id="member_startDate" value ="${memberList.member_startDate }"/></td>
				<td><input type="date" name="member_endDate" id="member_endDate" value ="${memberList.member_endDate }"/></td>
			</tr>
			</c:forEach>
			</c:if>
			
			<c:if test="${memberListM != null}">
			<c:forEach var="memberList" items="${memberListM}">
			<tr>
				<td style="display: none"><input type="text" name="member_Id" id="member_Id" disabled="disabled" value ="${memberList.member_Id }"/></td>
				<td><input type="text" name="member_Name" id="member_Name" value ="${memberList.member_Name }" style="width: 120px"/></td>
				<td>
					<select id="member_Sex">
						<option value="" ${memberList.member_Sex == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="D011" ${memberList.member_Sex == '남자' ? 'selected' : ''}>남자</option>
	  					<option value="D012" ${memberList.member_Sex == '여자' ? 'selected' : ''}>여자</option>
					</select>
				</td>
				<td>
					<select id="member_Position">
						<option value="" ${memberList.member_Position == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="D028" ${memberList.member_Position == '사원' ? 'selected' : ''}>사원</option>
	  					<option value="D027" ${memberList.member_Position == '대리' ? 'selected' : ''}>대리</option>
	  					<option value="D026" ${memberList.member_Position == '과장' ? 'selected' : ''}>과장</option>
					</select>
				</td>
				<td>
					<select id="member_Department">
						<option value="" ${memberList.member_Department == '미정' ? 'selected' : ''}>선택</option>
						<option value="A020" ${memberList.member_Department == '경영지원부' ? 'selected' : ''}>경영지원부</option>
						<option value="A021" ${memberList.member_Department == 'IT부' ? 'selected' : ''}>IT부</option>
						<option value="A022" ${memberList.member_Department == '인사부' ? 'selected' : ''}>인사부</option>
						<option value="A023" ${memberList.member_Department == '마케팅부' ? 'selected' : ''}>마케팅부</option>
					</select>
				</td>
				<td><input type="text" name="member_Tel" id="member_Tel" value ="${memberList.member_Tel }"/></td>
				<td>
					<select id="member_Skill_Language">
						<option value="" ${memberList.member_Skill_Language == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="S010" ${memberList.member_Skill_Language == 'JAVA' ? 'selected' : ''}>JAVA</option>
	  					<option value="S011" ${memberList.member_Skill_Language == 'PYTHON' ? 'selected' : ''}>PYTHON</option>
	  					<option value="S012" ${memberList.member_Skill_Language == 'C++' ? 'selected' : ''}>C++</option>
	  					<option value="S013" ${memberList.member_Skill_Language == 'RUBY' ? 'selected' : ''}>RUBY</option>
					</select>
				</td>
				<td>
					<select id="member_Skill_DB">
						<option value="" ${memberList.member_Skill_DB == '미정' ? 'selected' : ''}>선택</option>
	  					<option value="S020" ${memberList.member_Skill_DB == 'ORACLE' ? 'selected' : ''}>ORACLE</option>
	 		 			<option value="S021" ${memberList.member_Skill_DB == 'MSSQL' ? 'selected' : ''}>MSSQL</option>
	  					<option value="S022" ${memberList.member_Skill_DB == 'MYSQL' ? 'selected' : ''}>MYSQL</option>
	  					<option value="S023" ${memberList.member_Skill_DB == 'POSTGRESQL' ? 'selected' : ''}>POSTGRESQL</option>
					</select>
				</td>
				<td><input type="date" name="member_startDate" id="member_startDate" value ="${memberList.member_startDate }"/></td>
				<td><input type="date" name="member_endDate" id="member_endDate" value ="${memberList.member_endDate }"/></td>
			</tr>
			</c:forEach>
			</c:if>
		</tbody>
		
	</table>
<button type="button" id="modifyButton">수정하기</button>
<button type="button" id="back1" >뒤로 가기</button>
</div>

<br><br>
<div class="centered">
참여중인 프로젝트 <button type="button" id="push">추가</button><button type="button" id="removeButton2">삭제</button>
<table border="1" id="mem_pro_List">
<thead>
	<tr>
		<th>ㅁ</th>
		<th>번호(프로젝트)</th> <!-- style="display: none" -->
		<th>이름(프로젝트)</th>
		<th>투입일</th>
		<th>철수일</th>
	</tr>
</thead>
<tbody>
	<c:choose>
    <c:when test="${empty memberprojectList}">
      <tr>
        <td colspan="4" style="text-align: center;">참여중인 프로젝트가 없습니다</td>
      </tr>
    </c:when>
    <c:otherwise>
      <c:forEach var="memberproject" items="${memberprojectList}">
        <tr>
          <td><input type="checkbox"></td>
          <td>${memberproject['PROJECT_ID']}</td> <!-- style="display: none" -->
          <td>${memberproject['PROJECT_NAME']}</td>
          <td><input type="date" value="${memberproject['PUSHDATE']}"></td>
          <td><input type="date" value="${memberproject['PULLDATE']}"></td>
        </tr>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</tbody>
</table>
<button type="button" id="modifyButton2">수정</button>
<button type="button" id="back2">뒤로 가기</button>
</div>	
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
//1. 수정버튼 클릭
$("#modifyButton").click(function() {
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
				var member_Department = $("#member_Department").val();
				let modifyDatas = {
					member_Id : $("#member_Id").val()
					,member_Name : $("#member_Name").val()
					,member_Position : $("#member_Position").val()
					,member_Department : $("#member_Department").val()
					,member_Sex : $("#member_Sex").val()
					,member_Tel : $("#member_Tel").val()
					,member_Skill_DB : $("#member_Skill_DB").val()
					,member_Skill_Language : $("#member_Skill_Language").val()
					,member_startDate : $("#member_startDate").val()
				}	
				
				//console.log("member_Department : " , member_Department);	
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
				//let member_endDate_ck = 1;
				let modifyDatas = {
					member_Id : $("#member_Id").val()
					,member_Name : $("#member_Name").val()
					,member_Position : $("#member_Position").val()
					,member_Department : $("#member_Department").val()
					,member_Sex : $("#member_Sex").val()
					,member_Tel : $("#member_Tel").val()
					,member_Skill_DB : $("#member_Skill_DB").val()
					,member_Skill_Language : $("#member_Skill_Language").val()
					,member_startDate : $("#member_startDate").val()
					,member_endDate : $("#member_endDate").val()
					//,member_endDate_ck : member_endDate_ck
				}	
		
				console.log("member_Department : " , member_Department);	
				$.ajax({
					type : 'POST',
					url: '/member/memberModify',
					contentType : 'application/json; charset=utf-8',
					data: JSON.stringify(modifyDatas),
					success : function(result) { // 결과 성공 콜백함수        
						if(result == true){
							alert("수정 성공");
							var pageNo = $("#pageNo").val();
							//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
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
	}// elseIf EndPoint
});//$("#modifyButton").click(function() {
	
	$("#back1").click(function() {
		console.log("뒤로가기 클릭")
		var member_Id = $("#member_Id").val();
		var pageNo = $("#pageNo").val();
		location.href = "/member/memberRead?member_Id=" + member_Id +"&pageNo=" + pageNo;
	});
	
	$("#back2").click(function() {
		console.log("뒤로가기 클릭")
		var member_Id = $("#member_Id").val();
		var pageNo = $("#pageNo").val();
		location.href = "/member/memberRead?member_Id=" + member_Id +"&pageNo=" + pageNo;
	});
	
	//2. 프로젝츠 추가 버튼 클릭
	$("#push").click(function() {
		var member_Id = $("#member_Id").val();
		var member_Name = $("#member_Name").val();
		localStorage.setItem('member_Name', member_Name);
		let popOption = "width = 1150px, height = 650px, top = 200px, left = 300px, scrollbars = yes";
		let openURL = '/popup/popProject?pageNo=1&member_Id='+member_Id;
		var popup = window.open(openURL, 'pop', popOption);
		$.ajax({
			type : 'GET',
			url: '/popup/popProject',
			data: {
				 "member_Id" : member_Id,
				 "member_Name" : member_Name
			},
			success: function(response) {
		        if (response === "Success") {
					//window.location.reload();
		        }
		    },
		}); //ajax EndPoint
	});//$("#insert").click(function() { EndPoint

	var checkClicked = false; // 라디오 버튼 클릭 상태 추적 변수
	
	/* var selectedProjectData = [];
    // 라디오 버튼 클릭 이벤트 핸들러
    $("#mem_pro_List tbody input[type='checkbox']:checked").each(function() {
		console.log("선택되었다.");
        	
		var tr = $(this).closest("tr");

        	// 행의 데이터 추출
        	var member_Id = $("#member_Id").val();
        	var project_Id = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
        	// var projectName = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 이름
        	var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
        	var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
        
        	console.log("선택된 프로젝트: " + project_Id, pushDate, pullDate);
        
        	data = {
    			member_Id : $("#member_Id").val(),        		
            	project_Id: tr.find("td:nth-child(2)").text().trim(),
            	//projectName: tr.find("td:nth-child(3)").text().trim(),
            	pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
            	pullDate: tr.find("td:nth-child(5) input[type='date']").val()
        	};
        	
        	selectedProjectData.push(data);
    }); */
    
    $("#removeButton2").click(function() {
    	var selectedProjectData = [];
        // 라디오 버튼 클릭 이벤트 핸들러
        $("#mem_pro_List tbody input[type='checkbox']:checked").each(function() {
    		console.log("선택되었다.");
            	
    		var tr = $(this).closest("tr");

            	// 행의 데이터 추출
            	var member_Id = $("#member_Id").val();
            	var project_Id = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
            
            	alert("선택된 프로젝트: " + project_Id, member_Id);
            
            	data = {
        			member_Id : $("#member_Id").val(),        		
                	project_Id: tr.find("td:nth-child(2)").text().trim()
                	//projectName: tr.find("td:nth-child(3)").text().trim(),
                	//pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
                	//pullDate: tr.find("td:nth-child(5) input[type='date']").val()
            	};
            	
            	selectedProjectData.push(data);
        });    	
    	$.ajax({
			type : 'POST',
			url: '/member/memberDelete2',
			contentType : 'application/json; charset=utf-8',
			data: JSON.stringify(selectedProjectData),
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
    
    $("#modifyButton2").click(function() {
    	var selectedProjectData = [];    	
    	 $("#mem_pro_List tbody input[type='checkbox']:checked").each(function() {
			//console.log("선택되었다.");
    			
    		var tr = $(this).closest("tr");
    	    // 행의 데이터 추출
   	        var member_Id = $("#member_Id").val();
   	        var project_Id = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
   	        // var projectName = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 이름
   	        var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
   	        var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
   	        console.log("선택된 프로젝트: " + project_Id, pushDate, pullDate);
   	       	//alert("member_startDate : " + $("#member_startDate").val());
   	        
   	     	if(!pullDate.length == 0){
   				if (pullDate < pushDate) {
   		        	alert("투입일자는 철수일자보다 이전일 수 없습니다.");
   		        	return;
   				}
   				
   				if($("#member_startDate").val() > pullDate) {
					alert("철수일은 회원 입사일보다 먼저일 수 없습니다.");
					return;
   				}
   				
   				if($("#member_startDate").val() > pushDate) {
					alert("투입일은 회원 입사일보다 먼저일 수 없습니다.");
					return;
				}
   				
   				if($("#member_endDate").val() > pushDate) {
					alert("투입일은 회원 퇴사일보다 먼저일 수 없습니다.");
					return;
				}
   				
   	    	}
   	        
   	     	if(!pushDate.length == 0){
   	     		if (pullDate < pushDate) {
		        	alert("투입일자는 철수일자보다 이전일 수 없습니다.");
		        	return;
				}
   	     		
   	     		if($("#member_startDate").val() > pushDate) {
					alert("투입일은 회원 입사일보다 먼저일 수 없습니다.");
					return;
				}
   	     		
   	     		if($("#member_startDate").val() > pullDate) {
					alert("철수일은 회원 입사일보다 먼저일 수 없습니다.");
					return;
				}
   	     	}
   	     	
   	     	if(!$("#member_startDate").val().length == 0){
	     		if (pullDate < pushDate) {
		        	alert("투입일자는 철수일자보다 이전일 수 없습니다.");
		        	return;
				}
	     		
	     		if($("#member_startDate").val() > pushDate) {
					alert("투입일은 회원 입사일보다 먼저일 수 없습니다.");
					return;
				}
	     		
	     		if($("#member_startDate").val() > pullDate) {
					alert("철수일은 회원 입사일보다 먼저일 수 없습니다.");
					return;
				}
	     	}
   	     	
   	        data = {
   	    		member_Id : $("#member_Id").val(),        		
   	           	project_Id: tr.find("td:nth-child(2)").text().trim(),
   	           	//projectName: tr.find("td:nth-child(3)").text().trim(),
   	           	pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
   	           	pullDate: tr.find("td:nth-child(5) input[type='date']").val()
   	        };
   	        
   	        selectedProjectData.push(data);
   	    });    	
    	
        //console.log("여기서부터 해야함 : " + selectedProjectData);
        $.ajax({
    			type : 'POST',
    			url: '/member/memberModify2',
    			contentType : 'application/json; charset=utf-8',
				data: JSON.stringify(selectedProjectData),
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
    }); //$("#modifyButton2").click(function() EndPoint
});
	</script>
	
	
<!-- 
if (!checkClicked) { // 라디오 버튼이 클릭되지 않았다면
            alert("수정할 데이터를 체크해주세욧");
        } else { // 라디오 버튼이 클릭되었다면
        	/* $('.checkbox:checked').each(function() {
        		let row = $(this).closest('tr');
        		 var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
                 var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
        	}; */
        	/* var tr = $(this).closest("tr");

            // 행의 데이터 추출
            var member_Id = $("#member_Id").val();
            var projectId = tr.find("td:nth-child(2)").text().trim(); // 프로젝트 번호
            var projectName = tr.find("td:nth-child(3)").text().trim(); // 프로젝트 이름
            var pushDate = tr.find("td:nth-child(4) input[type='date']").val(); // 투입일
            var pullDate = tr.find("td:nth-child(5) input[type='date']").val(); // 철수일
            
            console.log("선택된 프로젝트: ", projectId, projectName, pushDate, pullDate);
            
            selectedProjectData = {
    			member_Id : $("#member_Id").val(),        		
            	projectId: tr.find("td:nth-child(2)").text().trim(),
                projectName: tr.find("td:nth-child(3)").text().trim(),
                pushDate: tr.find("td:nth-child(4) input[type='date']").val(),
                pullDate: tr.find("td:nth-child(5) input[type='date']").val()
            }; */
}//else EndPoint
 -->	
</body>
</html>
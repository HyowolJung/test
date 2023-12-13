<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<label>이름</label>
	<input type="text" id="member_Name" value="안녕"/><br>
	<div id="result_Name"></div>
	
	<label>직급</label>
	<select id="member_Position">
		  <option value="D028" selected="selected">사원</option>
		  <option value="D027">대리</option>
		  <option value="D026">과장</option>
	</select><br>
	
	<label>성별</label>
	<select id="member_Sex">
		  <option value="D011" selected="selected">남자</option>
		  <option value="D012">여자</option>
	</select><br>
	
	<label>전화번호("-" 포함)</label>
	<input type="text" id="member_Tel"/><button id="check_Tel">중복체크</button><br>
	<div id="result_Tel"></div>
	
	<label>언어</label>
	<select id="member_Skill_Language">
		  <option value="S010" selected="selected">JAVA</option>
		  <option value="S011">PYTHON</option>
		  <option value="S012">C++</option>
		  <option value="S013">RUBY</option>
	</select><br>
	
	<label>데이터베이스</label>
	<select id="member_Skill_DB">
		  <option value="S020" selected="selected">ORACLE</option>
		  <option value="S021">MSSQL</option>
		  <option value="S022">MYSQL</option>
		  <option value="S023">POSTGRESQL</option>
	</select><br>
	
	<label>입사일</label>
	<input type="date" id="member_startDate" name="member_startDate"/>
	<div id="result_Date"></div>
</div>
<button type="button" value="insert" id="insert" disabled="disabled">추가</button>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	//1. 중복체크 버튼 클릭
	$('#check_Tel').click(function() {
		let result_Tel = $("#result_Tel");		//결과를 출력할 공간(div)
		let member_Tel = $("#member_Tel").val();//입력한 전화번호
		let member_Tel_Check = /^01([0|1|6|7|8|9])?([0-9]{3,4})?([0-9]{4})$/;
		
		//2-1. 전화번호 유효성 체크(비어있는지)
		if(member_Tel.length == 0){
			result_Tel.css("color","red").html("전화번호칸이 비어있어요");
			return;
		
		}else if(member_Tel.length != 0){
			result_Tel.css("color","green").html("");
		}
		
		//2-2. 전화번호 유효성체크(적절한 조합인지)
		if (member_Tel_Check.test(member_Tel) != true){
			result_Tel.css("color","red").html("적절한 형식이 아닙니다.");
			return;
		}else if(member_Tel_Check.test(member_Tel) == true){	//유효성 통과하면
			result_Tel.css("color","green").html("");
		}//else if EndPoint
		
		$.ajax({
			type : 'GET',
			url : '/member/memberInsert_ck',
			data : {
				"member_Tel" : member_Tel	
			},
			success : 	
				function(result) {			
					if(result == true){
						console.log("result : " + result);
						result_Tel.css("color","red").html("중복된 번호입니다.");
						insert.disabled = true;
					}else if(result == false){
						result_Tel.css("color","green").html("");
						insert.disabled = false;
					}
				}
			/* function(result) { */
			/* } */
		}); //ajax EndPoint	
	});	//#check_Tel Click EndPoint
	
	//2. 추가 버튼 클릭
	$("#insert").click(function() {
		let insert = document.getElementById("insert");
		let member_Name = $("#member_Name").val();	//입력받은 이름
		let result_Name = $("#result_Name");		//결과를 출력할 공간(div)
		
		let member_Name_Check1 = /([^가-힣\x20])/i;	//정규식1(자음 모음 불가능)
		let member_Name_Check2 = /^[가-힣]{2,4}$/;	//정규식2(2~4자 글자만 가능)
		//let member_Name_Check3 = /^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\x20]*$/gi;	//특수문자 및 이모티콘 불가능
		
		//console.log("member_Name : " + member_Name);
		//값이 null 인 경우도 있지만, undefined 인 경우도 있으니까 null만 체크하지말고 다른 것도 생각해야해.
		//1-1. 이름 유효성 세크(비어있는지)
		if(member_Name.length == 0){
			result_Name.css("color","red").html("이름칸이 비어있어요");
			return;
		
		}else if(member_Name.length != 0){
			//1-2. 이름 유효성 체크(자음 모음 불가능)
			if(member_Name_Check1.test(member_Name) != true){	//자음, 모음만으로 이루어지지 않았을 때
				result_Name.css("color","green").html("");
			}else if(member_Name_Check1.test(member_Name) == true){ //자음, 모음만으로 이루어졌을 때
				result_Name.css("color","red").html("적절한 형식이 아닙니다.");
				return;
			}
		}
		
		
		//3-1. 
		let member_startDate = $("#member_startDate").val();
		let result_Date = $("#result_Date");
		
		if(member_startDate == 0){
			result_Date.css("color","red").html("날짜가 비어있어요");
			return;
		}else if(member_startDate != 0){
			result_Date.css("color","green").html("");
		}
		
		let insertDatas = {
			member_Name : $("#member_Name").val()
			,member_Position : $("#member_Position").val()
			,member_Sex : $("#member_Sex").val()
			,member_Tel : $("#member_Tel").val()
			,member_Skill_Language : $("#member_Skill_Language").val()
			,member_Skill_DB : $("#member_Skill_DB").val()
			,member_startDate: $("#member_startDate").val()
		}
			
		$.ajax({
			type : 'POST',
			url : '/member/memberInsert',
			contentType : 'application/json; charset=utf-8',
			/* data : insertDatas, */
			data: JSON.stringify(insertDatas),
			success : function(result) { // 결과 성공 콜백함수        
				alert("등록 성공");
				location.href = "/member/memberList";
			},
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("다시 한번 확인해주세요.");
			}
		});
	});
});
</script>
</body>
</html>
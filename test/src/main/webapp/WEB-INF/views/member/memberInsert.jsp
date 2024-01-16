<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록</title>
    <style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 20px;
        background-color: #f4f4f4;
        text-align: center;
    }

    .column {
        display: inline-block;
        vertical-align: top;
        width: 45%;
    }

    .buttons {
        text-align: center;
    }

    label {
        display: inline-block;
        width: 120px;
        font-weight: bold;
        text-align: right;
    }

    input, select {
        width: 200px;
        padding: 8px;
        margin-bottom: 10px;
        box-sizing: border-box;
    }

    #result_Id, #result_Name, #result_Tel, #result_Date {
        color: red;
        margin-bottom: 10px;
        margin-left: 125px;
    }

    button {
        padding: 10px;
        cursor: pointer;
    }
</style>
</head>
<body>
<div class="column" style="text-align: left;">
	<p style="color: red; text-align: center;" >필수 입력</p>

	<label style="color: red">사번</label>
	<input type="text" id="member_Id"/><br>
	<div id="result_Id"></div>
	
	<label style="color: red">이름</label>
	<input type="text" id="member_Name" value="안녕"/><br>
	<div id="result_Name"></div>
	
	<label style="color: red">전화번호<br>
	("-"포함)</label>
	<input type="text" id="member_Tel"><br>
	<div id="result_Tel"></div><br>
	
	<label style="color: red">입사(예정)일</label>
	<input type="date" id="member_startDate" name="member_startDate"/><br>
	<div id="result_Date"></div>
</div>

<div class="column" style="text-align: left;">
	<p style="text-align: center;">선택 입력</p>

	<label>부서</label>
	<select id="member_Department">
		<option value="S000" selected="selected">선택</option>
		<option value="A020">경영지원부</option>
		<option value="A021">인사부</option>
		<option value="A022">IT부</option>
		<option value="A023">마케팅부</option>
	</select><br><br>
	
	<label>직급</label>
	<select id="member_Position">
		<option value="S000" selected="selected">선택</option>
		<option value="D028" >사원</option>
		<option value="D027">대리</option>
		<option value="D026">과장</option>
	</select><br><br>
	
	<label>성별</label>
	<select id="member_Gender">
		<option value="S000" selected="selected">선택</option>
		<option value="D011" >남자</option>
		<option value="D012">여자</option>
	</select><br><br>
	<label>언어</label>
	<select id="member_Skill_Language">
		<option value="S000" selected="selected">선택</option>
		<option value="S010">JAVA</option>
		<option value="S011">PYTHON</option>
		<option value="S012">C++</option>
		<option value="S013">RUBY</option>
	</select><br><br>
	
	<label>데이터베이스</label>
	<select id="member_Skill_DB">
		<option value="S000" selected="selected">선택</option>
		<option value="S020">ORACLE</option>
		<option value="S021">MSSQL</option>
		<option value="S022">MYSQL</option>
		<option value="S023">POSTGRESQL</option>
	</select><br><br>
</div>

<div class="buttons">
	<button type="button" value="insert" id="insert">추가</button>
	<button type="button" value="back" id="back">뒤로 가기</button>
</div>

</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//1. 아이디 체크
	let result_Id = $("#result_Id"); // 결과를 출력할 공간
    let member_Id = $("#member_Id"); // 아이디 입력창
	member_Id.on('blur', function() {
		let member_Id_Check = /^\d{8}$/;
	    //console.log("member_Tel : " + member_Tel.val());
	    // 아이디 유효성 체크(비어있는지)
	    if (member_Id.val().length == 0) {
	    	result_Id.css("color", "red").html("아이디가 비어있어요");
	        return;
	    } else {
	    	result_Id.css("color", "green").html("");
	     	// 아이디 유효성체크(적절한 조합인지)
	        if (!member_Id_Check.test(member_Id.val())) {
	        	result_Id.css("color", "red").html("적절한 형식이 아닙니다.");
	            return;
	        } else {
	        	result_Id.css("color", "green").html("");
	        	//result_Id.css("color", "green").html("");
	          	$.ajax({
	       			type : 'GET',
	       			url : '/member/memberInsert_ck',
	       			data : {
	       				"member_Id" : member_Id.val()
	       		},
	       		success : 	
	       			function(result) {			
	       				if(result == false){
	       					console.log("result : " + result);
	       					result_Id.css("color","red").html("중복된 아이디입니다.");
	       				}else if(result == true){
	       					result_Id.css("color", "green").html("");
	       				}
	       			}
	       		}); //ajax EndPoint	
	         }
	    } 
	}); //member_Tel.on('blur', function EndPoint
	
	//2. 이름 체크
	let insert = document.getElementById("insert");
	let member_Name = $("#member_Name");	//입력받은 이름
	let result_Name = $("#result_Name");		//결과를 출력할 공간(div)
	   		
	member_Name.on('blur', function() { 		
		let member_Name_Check1 = /([^가-힣\x20])/i;	//정규식1(자음 모음 불가능)
		let member_Name_Check2 = /^[가-힣]{2,4}$/;	//정규식2(2~4자 글자만 가능)
		//let member_Name_Check3 = /^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\x20]*$/gi;	//특수문자 및 이모티콘 불가능
			
		//console.log("member_Name : " + member_Name);
		//값이 null 인 경우도 있지만, undefined 인 경우도 있으니까 null만 체크하지말고 다른 것도 생각해야해.
		//1-1. 이름 유효성 세크(비어있는지)
		if(member_Name.val().length == 0){
			result_Name.css("color","red").html("이름칸이 비어있어요");
			return;
		
		}else if(member_Name.val().length != 0){
			//1-2. 이름 유효성 체크(자음 모음 불가능)
			if(member_Name_Check1.test(member_Name.val()) != true){	//자음, 모음만으로 이루어지지 않았을 때
				result_Name.css("color", "green").html("");
			}else if(member_Name_Check1.test(member_Name.val()) == true){ //자음, 모음만으로 이루어졌을 때
				result_Name.css("color","red").html("적절한 형식이 아닙니다.");
				return;
			}
		}
	});			   
		   
	//3. 전화번호 체크	   
	let result_Tel = $("#result_Tel"); // 결과를 출력할 공간(div)
    let member_Tel = $("#member_Tel"); // 입력한 전화번호 입력창
    
    //전화번호 유효성 체크
    member_Tel.on('blur', function() {
    	let member_Tel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        console.log("member_Tel : " + member_Tel.val());
        // 전화번호 유효성 체크(비어있는지)
        if (member_Tel.val().length == 0) {
            result_Tel.css("color", "red").html("전화번호가 비어있어요");
            return;
        } else {
            result_Tel.css("color", "green").html("");
         	// 전화번호 유효성체크(적절한 조합인지)
            if (!member_Tel_Check.test(member_Tel.val())) {
                result_Tel.css("color", "red").html("적절한 형식이 아닙니다.");
                return;
            } else {
                result_Tel.css("color", "green").html("");
                $.ajax({
        			type : 'GET',
        			url : '/member/memberInsert_ck',
        			data : {
        				"member_Tel" : member_Tel.val()
        			},
        			success : 	
        				function(result) {			
        					if(result == false){
        						console.log("result : " + result);
        						result_Tel.css("color","red").html("중복된 번호입니다.");
        						//insert.disabled = false;
        					}else if(result == true){
        						result_Tel.css("color", "green").html("");
        						//insert.disabled = true;
        					}
        				}
        		}); //ajax EndPoint	
            }
        } 
    }); //member_Tel.on('blur', function EndPoint
	
    //4. 입사일 체크
    let member_startDate = $("#member_startDate");
	let result_Date = $("#result_Date");
    member_startDate.on('blur', function() {
		if(member_startDate.val() == 0){
			result_Date.css("color","red").html("날짜가 비어있어요");
			return;
		}else if(member_startDate.val() != 0){
			result_Date.css("color", "green").html("");
		}
    });
    		
	//2. 추가 버튼 클릭
	$("#insert").click(function() {
		if (result_Date.html().trim().length > 0 || result_Id.html().trim().length > 0 || result_Tel.html().trim().length > 0 || result_Name.html().trim().length > 0) {
			alert("다시 한번 확인해주세요");
			return;
		}
		
		if(!result_Date.html().trim().length > 0 || !result_Id.html().trim().length > 0 || !result_Tel.html().trim().length > 0 || !result_Name.html().trim().length > 0){
			
			if(!member_Tel.val().length == 0 || !member_Id.val().length == 0 || !member_startDate.val().length == 0 || !member_Name.val().length == 0){
				let insertDatas = {
					member_Id : $("#member_Id").val()	
					,member_Name : $("#member_Name").val()
					,member_Position : $("#member_Position").val()
					,member_Department : $("#member_Department").val()
					,member_Sex : $("#member_Gender").val()
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
						location.href = "/member/memberList?pageNo=1";
					},
					error : function(request, status, error) { // 결과 에러 콜백함수        
						alert("등록 실패");
					}
				}); //ajax EndPoint
			}
			
			if(member_Tel.val().length == 0 || member_Id.val().length == 0 || member_startDate.val().length == 0 || member_Name.val().length == 0){
				alert("아직 입력하지 않은 부분이 있어요.");
				return;
			}
		}
	}); //#insert EndPoint
	
	$("#back").click(function() {
		location.href = "/member/memberList?pageNo=1";
	});
});
</script>
</html>
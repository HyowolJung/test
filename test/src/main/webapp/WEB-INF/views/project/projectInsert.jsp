<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 등록</title>
<style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            text-align: center; /* 가운데 정렬을 위한 추가된 속성 */
        }

        div {
            margin-bottom: 20px;
            display: inline-block; /* 가운데 정렬을 위한 추가된 속성 */
            text-align: center; /* 내용은 왼쪽 정렬 유지 */
        }

        label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
            text-align: right; /* 라벨을 오른쪽 정렬 */
            /* margin-right: 10px; */
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
            margin-left: 80px;
        }

        button {
            padding: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div>
	<label>아이디</label>
	<input type="text" id="project_Id"/><br>
	<div id="result_Id"></div><br>
	
	<label>이름</label>
	<input type="text" id="project_Name" value="안녕"/><br>
	<div id="result_Name"></div><br>
	
	<label>고객사</label>
	<select id="custom_company_id">
		  <option value="D061" selected="selected">삼성</option>
		  <option value="D062">엘지</option>
		  <option value="D063">애플</option>
		  <option value="D064">구글</option>
		  <option value="D065">아마존</option>
	</select><br>
	
	<label>언어</label>
	<select id="project_Skill_Language">
		  <option value="S010" selected="selected">JAVA</option>
		  <option value="S011">PYTHON</option>
		  <option value="S012">C++</option>
		  <option value="S013">RUBY</option>
	</select><br>
	
	<label>데이터베이스</label>
	<select id="project_Skill_DB">
		  <option value="S020" selected="selected">ORACLE</option>
		  <option value="S021">MSSQL</option>
		  <option value="S022">MYSQL</option>
		  <option value="S023">POSTGRESQL</option>
	</select><br>
	
	<label>시작(예정)일</label>
	<input type="date" id="project_startDate" name="project_startDate"/><br>
	<div id="result_Date"></div><br>
	
</div>
<br>
<br>
<button type="button" value="insert" id="insert">추가</button>
<button type="button" value="back" id="back">뒤로 가기</button>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//1. 아이디 체크
	let result_Id = $("#result_Id"); // 결과를 출력할 공간
    let project_Id = $("#project_Id"); // 아이디 입력창
    project_Id.on('blur', function() {
		let project_Id_Check = /^\d{8}$/;
	    //console.log("member_Tel : " + member_Tel.val());
	    // 아이디 유효성 체크(비어있는지)
	    if (project_Id.val().length == 0) {
	    	result_Id.css("color", "red").html("아이디가 비어있어요");
	        return;
	    } else {
	    	result_Id.css("color", "green").html("");
	     	// 아이디 유효성체크(적절한 조합인지)
	        if (!project_Id_Check.test(project_Id.val())) {
	        	result_Id.css("color", "red").html("적절한 형식이 아닙니다.");
	            return;
	        } else {
	        	result_Id.css("color", "green").html("");
	        	//result_Id.css("color", "green").html("");
	          	$.ajax({
	       			type : 'GET',
	       			url : '/project/projectInsert_ck',
	       			data : {
	       				"project_Id" : project_Id.val()
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
	let project_Name = $("#project_Name");	//입력받은 이름
	let result_Name = $("#result_Name");		//결과를 출력할 공간(div)
	   		
	project_Name.on('blur', function() { 		
		//let project_Name_Check1 = /([^가-힣\x20])/i;	//정규식1(자음 모음 불가능)
		let project_Name_Check1 = /^[가-힣A-Za-z ()]{0,30}$/;	//정규식1(자음 모음 불가능)
		//let project_Name_Check2 = /^[가-힣A-Za-z ()]{0,30}$/; //한글,영문,공백,특수문자()만 허용
		//let project_Name_Check2 = /^[가-힣]{1,15}$/;	//정규식2(1~15자 글자만 가능)
		//let member_Name_Check3 = /^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\x20]*$/gi;	//특수문자 및 이모티콘 불가능
			
		//console.log("member_Name : " + member_Name);
		//값이 null 인 경우도 있지만, undefined 인 경우도 있으니까 null만 체크하지말고 다른 것도 생각해야해.
		//1-1. 이름 유효성 세크(비어있는지)
		if(project_Name.val().length == 0){
			result_Name.css("color","red").html("이름칸이 비어있어요");
			return;
		
		}else if(project_Name.val().length != 0){
			//1-2. 이름 유효성 체크(자음 모음 불가능)
			if(project_Name_Check1.test(project_Name.val()) == true ){	//자음, 모음만으로 이루어지지 않았을 때
				result_Name.css("color", "green").html("");
			}else if(project_Name_Check1.test(project_Name.val()) != true){ //자음, 모음만으로 이루어졌을 때
				result_Name.css("color","red").html("적절한 형식이 아닙니다.");
				return;
			}
		}
	});			   
		   
	//3. 전화번호 체크	   
	/* let result_Tel = $("#result_Tel"); // 결과를 출력할 공간(div)
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
    }); //member_Tel.on('blur', function EndPoint */
	
    //4. 시작일 체크
    let project_startDate = $("#project_startDate");
	let result_Date = $("#result_Date");
	project_startDate.on('blur', function() {
		if(project_startDate.val() == 0){
			result_Date.css("color","red").html("날짜가 비어있어요");
			return;
		}else if(project_startDate.val() != 0){
			result_Date.css("color", "green").html("");
		}
    });
    		
	//2. 추가 버튼 클릭
	$("#insert").click(function() {
		if (result_Date.html().trim().length > 0 || result_Id.html().trim().length > 0 || result_Name.html().trim().length > 0) {
			alert("다시 한번 확인해주세요");
			return;
		}
		
		if(!result_Date.html().trim().length > 0 || !result_Id.html().trim().length > 0 || !result_Name.html().trim().length > 0){
			if(!project_Id.val().length == 0 || !project_startDate.val().length == 0 || !project_Name.val().length == 0){
				let insertDatas = {
					project_Id : $("#project_Id").val()	
					,project_Name : $("#project_Name").val()
					,custom_company_id : $("#custom_company_id").val()
					,project_Skill_Language : $("#project_Skill_Language").val()
					,project_Skill_DB : $("#project_Skill_DB").val()
					,project_startDate: $("#project_startDate").val()
				}
					
				$.ajax({
					type : 'POST',
					url : '/project/projectInsert',
					contentType : 'application/json; charset=utf-8',
					/* data : insertDatas, */
					data: JSON.stringify(insertDatas),
					success : function(result) { // 결과 성공 콜백함수        
						alert("등록 성공");
						location.href = "/project/projectList?pageNo=1";
					},
					error : function(request, status, error) { // 결과 에러 콜백함수        
						alert("등록 실패");
					}
				}); //ajax EndPoint
			}
			
			if(project_Id.val().length == 0 || project_startDate.val().length == 0 || project_Name.val().length == 0){
				alert("아직 입력하지 않은 부분이 있어요.");
				return;
			}
		}
	}); //#insert EndPoint
	
	$("#back").click(function() {
		location.href = "/project/projectList?pageNo=1";
	});
});
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>회원 등록</title>
<style>
body {
    /* font-family: 'Arial', sans-serif; */
    /* background-color: #f4f4f4; */
    margin: 0;
    padding: 20px;
}

/* 각 column에 대한 스타일 */
.column {
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    padding: 20px;
    margin-bottom: 20px;
}

/* 필수 입력과 선택 입력의 제목 스타일 */
.column p {
    color: #333;
    font-weight: bold;
    text-align: left;
    margin-top: 0;
}

/* 레이블 스타일 */
label {
    color: #333;
    display: block;
    margin-bottom: 5px;
}

/* 필수 입력 항목의 레이블에 대한 스타일 */
label[style="color: red"] {
    color: #d9534f;
}

/* input 및 select 박스 기본 스타일 */
input[type="text"],
input[type="date"],
select {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box; /* 박스 사이즈를 지정해서 패딩이 width에 포함되도록 함 */
}

/* 버튼 스타일 */
button {
    background-color: #4CAF50; /* 녹색 */
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
}

button:hover {
    background-color: #45a049;
}

/* 반응형 디자인: 화면 너비가 600px 미만일 때 column과 버튼 사이즈 조정 */
@media screen and (max-width: 600px) {
    .column,
    button {
        width: 100%;
    }
}

/* 결과 메시지 스타일 */
#result_Id,
#result_Pw,
#result_Name,
#result_Tel,
#result_Date {
    color: #d9534f;
    font-size: 0.9em;
}

/* 필수 입력 부분의 제목 색상 */
.column:first-child p {
    color: #5cb85c; /* 연한 녹색 */
}    
.container {
    width: 30%; /* or 원하는 폭에 맞게 조정 */
    margin: auto; /* 좌우 마진을 auto로 설정하여 가운데 정렬 */
    background-color: #fff; /* 배경색을 흰색으로 설정 */
    padding: 20px;
    border-radius: 8px; /* 모서리를 둥글게 */
    box-shadow: 0 2px 4px rgba(0,0,0,0.2); /* 상자 그림자를 추가하여 입체감을 줍니다 */
}

/* .column 스타일은 유지하되, 중앙 정렬이 필요없으므로 margin-bottom만 설정합니다. */
.column {
    padding: 20px;
    margin-bottom: 20px; /* 컬럼 사이의 간격 */
}

/* 섹션 제목을 중앙 정렬합니다. */
.column p {
    text-align: center;
}

/* 버튼 컨테이너를 추가하여 버튼을 가운데로 정렬합니다. */
.buttons {
    text-align: center; /* 버튼을 중앙에 정렬 */
    padding: 20px 0;
}

/* 버튼을 인라인 블록으로 변경하여 가운데 정렬되도록 합니다. */
button {
    width: auto; /* 버튼의 너비를 내용에 맞게 조정 */
    display: inline-block; /* 인라인 블록으로 설정 */
    margin: 0 10px; /* 좌우 마진을 줘서 버튼 사이에 간격을 추가 */
}

/* 반응형 디자인을 위한 미디어 쿼리 */
@media screen and (max-width: 768px) {
    .container {
        width: 95%;
    }
}

/* 추가로, 필요하다면 개별 입력 필드의 너비를 조정할 수 있습니다. */
input[type="text"],
input[type="date"],
select {
    width: calc(100% - 20px); /* 입력 필드의 좌우 패딩을 고려하여 조정 */
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%@include file="/WEB-INF/views/common/sideBar.jsp" %> 
<div class="total-div">
<div class="container">
<div class="column" style="text-align: left;">
	<p style="color: red; text-align: center;" >필수 입력</p>

	<label style="color: red">사번</label>
	<input type="text" id="memberId"/><br>
	<div id="result_Id"></div>
	
	<label style="color: red">비밀번호</label>
	<input type="text" id="memberPw" value="1234"/><br>
	<div id="result_Pw"></div>
	
	<label style="color: red">이름</label>
	<input type="text" id="memberName" value="안녕"/><br>
	<div id="result_Name"></div>
	
	<label style="color: red">전화번호<br>
	("-"포함)</label>
	<input type="text" id="memberTel"><br>
	<div id="result_Tel"></div><br>
	
	<label style="color: red">입사(예정)일</label>
	<input type="date" id="member_startDate" name="memberStDay" value="2024-03-10"/><br>
	<div id="result_Date"></div>
</div>
</div>
<div class="container">
<div class="column" style="text-align: left;">
	<p style="text-align: center;">선택 입력</p>

	<label>부서</label>
	<select id="memberDept">
		<option value="" selected="selected">선택</option>
		<option value="D01">경영지원부</option>
		<option value="D02">인사부</option>
		<option value="D03">IT부</option>
		<option value="D04">재무부</option>
		<option value="D05">회계부</option>
		<option value="D06">마케팅부</option>
	</select><br><br>
	
	<label>자격증</label>
	<select id="memberCerti">
		<option value="" selected="selected">선택</option>
	</select><br><br>
	
	<label>직급</label>
	<select id="memberPos">
		<option value="" selected="selected">선택</option>
		<option value="P01">회장</option>
		<option value="P02">부회장</option>
		<option value="P03">사장</option>
		<option value="P04">부사장</option>
		<option value="P05">전무</option>
		<option value="P06">상무</option>
		<option value="P07">본부장</option>
		<option value="P08">실장</option>
		<option value="P09">팀장</option>
		<option value="P10">부장</option>
		<option value="P11">차장</option>
		<option value="P12">과장</option>
		<option value="P13">대리</option>
		<option value="P14">주임</option>
		<option value="P15">사원</option>
		<option value="P16">인턴</option>
	</select><br><br>
	
	<label>성별</label>
	<select id="memberGn">
		<option value="" selected="selected">선택</option>
		<option value="G01" >남자</option>
		<option value="G02">여자</option>
	</select><br><br>
	
</div>
</div>	
	
	
	<!-- <label>언어</label>
	<select id="member_Skill_Language">
		<option value="" selected="selected">선택</option>
		<option value="S010">JAVA</option>
		<option value="S011">PYTHON</option>
		<option value="S012">C++</option>
		<option value="S013">RUBY</option>
	</select><br><br>
	
	<label>데이터베이스</label>
	<select id="member_Skill_DB">
		<option value="" selected="selected">선택</option>
		<option value="S020">ORACLE</option>
		<option value="S021">MSSQL</option>
		<option value="S022">MYSQL</option>
		<option value="S023">POSTGRESQL</option>
	</select><br><br> -->

<div class="buttons">
	<button type="button" value="insert" id="insert">추가</button>
	<button type="button" value="back" id="back">뒤로 가기</button>
</div>
</div>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 부서별 자격증 목록
    var certifications = {
    "D01": [
        {name: "MBA", value: "C01"},
        {name: "CPA", value: "C02"}
    ],
    "D02": [
        {name: "HRM", value: "C03"}
    ],
    "D03": [
        {name: "OCJP", value: "C04"},
        {name: "Microsoft Certified", value: "C05"}
    ],
    "D04": [
        {name: "CFA", value: "C06"}
    ],
    "D05": [
        {name: "전산회계2급", value: "C07"},
        {name: "전산회계1급", value: "C08"}
    ],
    "D06": [
        {name: "Google Adwords", value: "C09"},
        {name: "Facebook Marketing", value: "C10"}
    ]
};

    // 초기 셋업: 자격증 선택 비활성화
    $('#memberCerti').prop('disabled', true); // 초기 셋업: 자격증 선택 비활성화

    $('#memberDept').change(function() {
        var selectedDept = $(this).val();
        var $certiSelect = $('#memberCerti');

        if (selectedDept === "") {
            $certiSelect.empty().append($('<option>').val('').text('선택')).prop('disabled', true);
        } else {
            var certs = certifications[selectedDept];
            $certiSelect.empty().append($('<option>').val('').text('선택'));
            certs.forEach(function(cert) {
                $certiSelect.append($('<option>').val(cert.value).text(cert.name));
            });
            $certiSelect.prop('disabled', false); // 자격증 선택 활성화
        }
    });
	
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
	
	let memberId = $("#memberId");
	const randomNumber = Math.floor(Math.random() * 99999999) + 1;
    // 숫자를 8자리 문자열로 포맷, 필요한 경우 앞에 0을 추가
    const formattedNumber = randomNumber.toString().padStart(8, '0');
    memberId.val(formattedNumber);
    
    const randomNumber2 = "010" + Math.floor(Math.random() * 100000000).toString().padStart(8, '0');
    // replace 함수와 정규 표현식을 사용하여 형식 변환
    const formattedNumber2 = randomNumber2.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');

    $("#memberTel").val(formattedNumber2);
    
	//1. 아이디 체크
	let result_Id = $("#result_Id"); // 결과를 출력할 공간
    memberId = $("#memberId"); // 아이디 입력창
	memberId.on('blur', function() {
		let memberId_Check = /^\d{8}$/;
	    //console.log("member_Tel : " + member_Tel.val());
	    // 아이디 유효성 체크(비어있는지)
	    if (memberId.val().length == 0) {
	    	result_Id.css("color", "red").html("아이디가 비어있어요");
	        return;
	    } else {
	    	result_Id.css("color", "green").html("");
	     	// 아이디 유효성체크(적절한 조합인지)
	        if (!memberId_Check.test(memberId.val())) {
	        	result_Id.css("color", "red").html("적절한 형식이 아닙니다.");
	            return;
	        } else {
	        	result_Id.css("color", "green").html("");
	        	let modifyData = {
					memberId : $("#memberId").val()
				}
	        	var memberList = [modifyData];
	        	//let modifyDataArray = [modifyData];
				//let modifyList = JSON.stringify(modifyDataArray);
	          	$.ajax({
	       			type : 'POST',
	       			url : '/member/memberInsert',
	       			contentType : 'application/json; charset=utf-8',
	       			/* beforeSend: function(xhr) {
	            		xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        		}, */
	       			data : JSON.stringify(memberList),
	       			//data : modifyList,
	       			/* data : {
	       				"memberId" : memberId.val()
	       			}, */
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
	
	let result_Pw = $("#result_Pw");			
	let memberPw = $("#memberPw");		
			
	//2. 이름 체크
	let insert = document.getElementById("insert");
	let memberName = $("#memberName");	//입력받은 이름
	let result_Name = $("#result_Name");		//결과를 출력할 공간(div)
	   		
	memberName.on('blur', function() { 		
		let memberName_Check1 = /([^가-힣\x20])/i;	//정규식1(자음 모음 불가능)
		let memberName_Check2 = /^[가-힣]{2,4}$/;	//정규식2(2~4자 글자만 가능)
		//let member_Name_Check3 = /^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\x20]*$/gi;	//특수문자 및 이모티콘 불가능
			
		//console.log("member_Name : " + member_Name);
		//값이 null 인 경우도 있지만, undefined 인 경우도 있으니까 null만 체크하지말고 다른 것도 생각해야해.
		//1-1. 이름 유효성 세크(비어있는지)
		if(memberName.val().length == 0){
			result_Name.css("color","red").html("이름칸이 비어있어요");
			return;
		
		}else if(memberName.val().length != 0){
			//1-2. 이름 유효성 체크(자음 모음 불가능)
			if(memberName_Check1.test(memberName.val()) != true){	//자음, 모음만으로 이루어지지 않았을 때
				result_Name.css("color", "green").html("");
			}else if(memberName_Check1.test(memberName.val()) == true){ //자음, 모음만으로 이루어졌을 때
				result_Name.css("color","red").html("적절한 형식이 아닙니다.");
				return;
			}
		}
	});			   
		   
	//3. 전화번호 체크	   
	let result_Tel = $("#result_Tel"); // 결과를 출력할 공간(div)
    let memberTel = $("#memberTel"); // 입력한 전화번호 입력창
    
    //전화번호 유효성 체크
    memberTel.on('blur', function() {
    	//let member_Tel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
    	let memberTel_Check = /^01[016789]-\d{4}-\d{4}$/;
        //console.log("memberTel : " + memberTel.val());
        // 전화번호 유효성 체크(비어있는지)
        if (memberTel.val().length == 0) {
            result_Tel.css("color", "red").html("전화번호가 비어있어요.");
            return;
        } else {
            result_Tel.css("color", "green").html("");
         	// 전화번호 유효성체크(적절한 조합인지)
            if (!memberTel_Check.test(memberTel.val())) {
                result_Tel.css("color", "red").html("적절한 형식이 아닙니다.");
                return;
            } else {
                result_Tel.css("color", "green").html("");
                
                let modifyData = {
                	memberTel : $("#memberTel").val()
    			}
                var memberList = [modifyData];
                
                /* let modifyData = {
    					memberId : $("#memberId").val()
    			}
    	        let modifyList = [modifyData]; */
                
                
                //let modifyDataArray = [modifyData];
				//let modifyList = JSON.stringify(modifyDataArray);
				//ALERT("왔어요 요기에ㅐ");
                $.ajax({
        			type : 'POST',
        			url : '/member/memberInsert',
        			/* beforeSend: function(xhr) {
        	            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        	        }, */
        	        contentType : 'application/json; charset=utf-8',
        	        data : JSON.stringify(memberList),
        			success : 	
        				function(result) {			
        					if(result == false){0
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
    let memberStDay = $("#memberStDay");
	let result_Date = $("#result_Date");
	memberStDay.on('blur', function() {
		if(memberStDay.val() == 0){
			result_Date.css("color","red").html("날짜가 비어있어요.");
			return;
		}else if(memberStDay.val() != 0){
			result_Date.css("color", "green").html("");
		}
    });
    		
	//2. 추가 버튼 클릭
	$("#insert").click(function() {
		if (result_Date.html().trim().length > 0 || result_Id.html().trim().length > 0 || result_Tel.html().trim().length > 0 || result_Name.html().trim().length > 0) {
			alert("다시 한번 확인해주세요.");
			return;
		}
		
		if(!result_Date.html().trim().length > 0 || !result_Id.html().trim().length > 0 || !result_Tel.html().trim().length > 0 || !result_Name.html().trim().length > 0){
			
			if(!memberTel.val().length == 0 || !memberId.val().length == 0 || !memberStDay.val().length == 0 || !memberName.val().length == 0){
				let insertDatas = {
					memberId : $("#memberId").val()
					,memberPw : $("#memberPw").val()
					,memberName : $("#memberName").val()
					,memberPos : $("#memberPos").val()
					,memberDept : $("#memberDept").val()
					,memberGn : $("#memberGn").val()
					,memberTel : $("#memberTel").val()
					,memberStDay : $("#memberStDay").val()
					,memberAuth : "ROLE_MEMBER" 
				}
					
				$.ajax({
					type : 'POST',
					url : '/member/memberInsert',
					contentType : 'application/json; charset=utf-8',
					/* data : insertDatas, */
					/* beforeSend: function(xhr) {
	            		xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
	        		}, */
					data: JSON.stringify(insertDatas),
					success : function(result) { // 결과 성공 콜백함수        
						alert("등록을 성공했습니다");
						location.href = "/member/memberList";
					},
					error : function(request, status, error) { // 결과 에러 콜백함수        
						//alert("등록을 실패했습니다.");
					}
				}); //ajax EndPoint
			}
			
			if(member_Tel.val().length == 0 || member_Id.val().length == 0 || member_startDate.val().length == 0 || member_Name.val().length == 0){
				alert("아직 입력하지 않은 부분이 있어요.");
				return null;
			}
		}
	}); //#insert EndPoint
	
	$("#back").click(function() {
		location.href = "/member/memberList";
	});
});
</script>
</html>
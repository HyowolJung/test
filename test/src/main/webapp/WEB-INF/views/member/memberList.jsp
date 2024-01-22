<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 조회</title>
  <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 20px;
        }

        /* div {
            margin-bottom: 20px;
        } */

        input, select {
            margin-right: 10px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 10px;
            cursor: pointer;
        }

        #pagination {
            margin-top: 20px;
        }

        ul.pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li.page-item {
            margin-right: 10px;
        }

        a.page-link {
            text-decoration: none;
            padding: 8px 12px;
            border: 1px solid #ddd;
            color: #333;
            background-color: #fff;
            cursor: pointer;
        }

        a.page-link.active {
            background-color: #007bff;
            color: #fff;
        }

        .result-message {
            text-align: center;
            font-style: italic;
            color: #777;
        }
    </style>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
<%@include file="/WEB-INF/views/common/WellCome.jsp"%><br><br>
<div>
	<input type="text" id="member_Id_SE" value="${member_Id_SE}" type="hidden"><!-- type="hidden" -->
	<%-- <div>현재 ${pageDto.cri.pageNo } 페이지 입니다.</div><br> --%> <!-- id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" -->
	<input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" type="hidden">
	<select name="searchField" class="form-select" aria-label="Default select example" id="searchField">
	  <option value="name" <c:if test = "${pageDto.cri.searchField == 'name' }">selected</c:if>>이름</option>
	  <option value="tel" ${pageDto.cri.searchField == 'tel' ? 'selected' : ''}>전화번호</option>
	</select>
    <input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
    <label>입사일</label>
	<input type="date" name="searchDate" ${pageDto.cri.search_startDate == 'search_startDate' ? 'selected' : ''} id = "search_startDate" > <!-- ${pageDto.cri.searchField == 'date' ? 'selected' : ''} -->
	~
	<label>퇴사일</label>
	<input type="date" name="searchDate" ${pageDto.cri.search_endDate == 'search_endDate' ? 'selected' : ''} id = "search_endDate" > <!-- ${pageDto.cri.searchField == 'date' ? 'selected' : ''} -->
	<button id="searchButton">조회</button>
</div>
<br><br>
<table border="1" id="memberTable">
	<thead>
		<tr>
			<th>ㅁ</th>
			<!-- <th>번호</th> -->
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>직급</th>
			<th>부서</th>
			<th>전화번호</th>
			<th>언어</th>
			<th>데이터베이스</th>
			<th>입사일</th>
			<th>퇴사일</th>
			<!-- <th>상태</th> -->
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>

<button type="button" value="delete" id="deleteButton">삭제</button>
<button type="button" value="modify" id="modifyButton">수정</button>
<button id="insertButton" onclick="insertMember();">등록</button>
<button type="button" value="modify" id="mmodifyButton">수정</button>
<div id="pagination">
	<ul class="pagination" style= "list-style: none;">
	</ul>
</div>

<br><br><br><br><br><br><br>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$("#mmodifyButton").hide();
	let member_Id = $("#member_Id_SE").val()
	//let searchWord = $("#searchWord").val();
	//<input name="searchWord" type="text" class="form-control" id="searchWord" placeholder="검색어" value="${pageDto.cri.searchWord }">
	//이렇게 하면 검색어를 입력하지 않았어도 최초 브라우저가 로딩되면 당연히 공백같은 값들이 들어가지..
	//우리는 입력된 값을 원하는 거지 value 값을 원하는게 아니잖아?
	//그러니까 .value 혹은 .val() 를 하는게 아니라 innerText 같은걸 써야지...
	
	$("#memberTable tbody").empty();
	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
    
	$("#memberTable").on("click", ".member-id", function () {
		var member_Id = $(this).data("memberid");
		window.location.href = "/member/memberRead?member_Id=" + member_Id;
	});
    
	//1. 검색 폼
	$("#searchButton").click(function(){
		let search_startDate = $("#search_startDate").val();
		let search_endDate = $("#search_endDate").val();
		let searchField = document.getElementById("searchField").value; 
		let searchWord = $("#searchWord").val();
		let pageNo = document.getElementById("pageNo").value; 
		console.log("searchWord : " + searchWord);
		
		$.ajax({
			type : 'POST',
			url: '/member/memberList',
			data: {
			 	"searchField" :  searchField,
			 	"searchWord" : searchWord,
			 	"pageNo" : pageNo,
			 	"search_startDate" : search_startDate,
			 	"search_endDate" : search_endDate
			},
			success : function(resultMap) { // 결과 성공 콜백함수  
				var memberList = resultMap.memberList;
				var pageDto = resultMap.pageDto;
				$("#memberTable tbody").empty();
				
           		if (memberList && memberList.length > 0) {
					console.log("memberList가 있어요");               			
           			for (let i = 0; i < memberList.length; i++) {
                    	let newRow = $("<tr>");
                    	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	//newRow.append("<td><input type='radio' class='radio' name='radio' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	/* newRow.append("<td>" + memberList[i].member_No + "</td>"); */
                    	newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
                    	newRow.append("<td>" + memberList[i].member_Name + "</td>");
                    	//newRow.append("<td>" + (memberList[i].member_Sex === null ? '미정' : memberList[i].member_Sex) + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Sex + "</td>");
                    	//newRow.append("<td>" + (memberList[i].member_Position === null ? '미정' : memberList[i].member_Position) + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Position + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Department + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Tel + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_Language + "</td>");
                    	//newRow.append("<td>" + (memberList[i].member_Skill_Language === null ? '미정' : memberList[i].member_Skill_Language) + "</td>");
                    	newRow.append("<td>" + memberList[i].member_Skill_DB + "</td>");
                    	//newRow.append("<td>" + (memberList[i].member_Skill_DB === null ? '미정' : memberList[i].member_Skill_DB) + "</td>");
                    	newRow.append("<td>" + memberList[i].member_startDate + "</td>");
                    	//newRow.append("<td>" + memberList[i].member_endDate + "</td>");
                    	newRow.append("<td>" + (memberList[i].member_endDate === null ? '미정' : memberList[i].member_endDate) + "</td>");
                    	//newRow.append("<td>" + memberList[i].member_status + "</td>");
                    	//newRow.append("<td style='color: red;'>" + "미구현" + "</td>");
                    	
                    	$("#memberTable tbody").append(newRow);
           			}
           			
           			var pagination = $("#pagination ul");
           	        pagination.empty();

           	        if (pageDto.prev) {
           	            pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
           	        }

           	        for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
           	            pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
           	        }

           	        if (pageDto.next) {
           	        	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
           	        }
           			
           		}else{
           			console.log("memberList 가 NULL 이에요.")
           			$("#memberTable tbody").empty();
           		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
           		}
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("검색 실패");
			}
		}); //$.ajax EndPoint
	});//$("#searchButton").click EndPoint
	
	var checkList = [];
    $(document).on('click', '.checkbox', function() {
    	var checkList = []; // 배열을 여기에서 초기화
        $('.checkbox:checked').each(function() {
            checkList.push($(this).val());
        });
        console.log("선택된 값들 : " + checkList);    	
	});//$(document).on('click', '.checkbox', function() {
	
    $("#deleteButton").click(function() {
    	 var checkList = [];
    	 $('.checkbox:checked').each(function() {
			checkList.push($(this).val());
    	 });    	
    	alert("checkList : " + checkList);
		$.ajax({
			type : 'POST',
			url: '/member/memberDelete',
			contentType: 'application/json',
			data: JSON.stringify(checkList),
			success : function(result) { // 결과 성공 콜백함수        
				alert("삭제 성공");
				location.href = "/member/memberList?pageNo=1";
			}, 
			error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("삭제 실패");
			}
		}); //ajax EndPoint
	});	//#deleteButton EndPoint
	
	$("#modifyButton").click(function() {
		var checkList = [];
		$('.checkbox:checked').each(function() {
			checkList.push($(this).val());
			//checkList.push({ member_Id: $(this).val() });
		});
		//console.log("checkList에 담겨 있는 값은 : " + checkList);
		$.ajax({
			type : 'POST',
			url: '/member/memberListM',
			contentType: 'application/json',
			data: JSON.stringify(checkList),
			success : function(resultMap) { // 결과 성공 콜백함수
				alert("성공!");
				$("#deleteButton").hide();
				$("#modifyButton").hide();
				$("#insertButton").hide();
				$("#mmodifyButton").show();
				
				var memberList = resultMap.memberList;
				$("#memberTable tbody").empty();
				
           		if (memberList && memberList.length > 0) {
					console.log("memberList가 있어요");               			
           			for (let i = 0; i < memberList.length; i++) {
							
           				var select_member_Sex = "<select id='member_Sex'>";
           				select_member_Sex += "<option value='null'" + (memberList[i].member_Sex == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Sex += "<option value='D011'" + (memberList[i].member_Sex == '남자' ? 'selected' : '') + ">남자</option>";
        				select_member_Sex += "<option value='D012'" + (memberList[i].member_Sex == '여자' ? " selected" : "") + ">여자</option>";
        				select_member_Sex += "</select>";
        				
        				var select_member_Position = "<select id='member_Position'>";
        				select_member_Position += "<option value='null'" + (memberList[i].member_Position == '미정' ? " selected" : "") + ">선택</option>";
        				select_member_Position += "<option value='D028'" + (memberList[i].member_Position == '사원' ? " selected" : "") + ">사원</option>";
        				select_member_Position += "<option value='D027'" + (memberList[i].member_Position == '대리' ? " selected" : "") + ">대리</option>";
        				select_member_Position += "<option value='D026'" + (memberList[i].member_Position == '과장' ? " selected" : "") + ">과장</option>";
        				select_member_Position += "</select>";
        				
        				var select_member_Department = "<select id='member_Department'>";
        				select_member_Department += "<option value='null'" + (memberList[i].member_Department == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Department += "<option value='A020'" + (memberList[i].member_Department == '경영지원부' ? 'selected' : '') + ">경영지원부</option>";
        				select_member_Department += "<option value='A021'" + (memberList[i].member_Department == '인사부' ? 'selected' : '') + ">인사부</option>";
        				select_member_Department += "<option value='A022'" + (memberList[i].member_Department == 'IT부' ? 'selected' : '') + ">IT부</option>";
        				select_member_Department += "<option value='A023'" + (memberList[i].member_Department == '마케팅부' ? 'selected' : '') + ">마케팅부</option>";
        				select_member_Department += "</select>";
        				
        				var select_member_Skill_Language = "<select id='member_Skill_Language'>";
        				select_member_Skill_Language += "<option value='null'" + (memberList[i].member_Skill_Language == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Skill_Language += "<option value='S010'" + (memberList[i].member_Skill_Language == 'JAVA' ? 'selected' : '') + ">JAVA</option>";
        				select_member_Skill_Language += "<option value='S011'" + (memberList[i].member_Skill_Language == 'PYTHON' ? 'selected' : '') + ">PYTHON</option>";
        				select_member_Skill_Language += "<option value='S012'" + (memberList[i].member_Skill_Language == 'C++' ? 'selected' : '') + ">C++</option>";
        				select_member_Skill_Language += "<option value='S013'" + (memberList[i].member_Skill_Language == 'RUBY' ? 'selected' : '') + ">RUBY</option>";
        				select_member_Skill_Language += "</select>"; 
           				
        				var select_member_Skill_DB = "<select id='member_Skill_DB'>";
        				select_member_Skill_DB += "<option value='null'" + (memberList[i].member_Skill_DB == '미정' ? 'selected' : '') + ">선택</option>";
        				select_member_Skill_DB += "<option value='S020'" + (memberList[i].member_Skill_DB == 'ORACLE' ? 'selected' : '') + ">ORACLE</option>";
        				select_member_Skill_DB += "<option value='S021'" + (memberList[i].member_Skill_DB == 'MSSQL' ? 'selected' : '') + ">MSSQL</option>";
        				select_member_Skill_DB += "<option value='S022'" + (memberList[i].member_Skill_DB == 'MYSQL++' ? 'selected' : '') + ">MYSQL</option>";
        				select_member_Skill_DB += "<option value='S023'" + (memberList[i].member_Skill_DB == 'POSTGRESQL' ? 'selected' : '') + ">POSTGRESQL</option>";
        				select_member_Skill_DB += "</select>"; 
        				
           				let newRow = $("<tr>");
                    	newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].member_Id + "' data-id='" + memberList[i].member_Id + "'></td>");
                    	newRow.append("<td><a href='/member/memberRead?member_Id="+ memberList[i].member_Id + "&pageNo="+ pageNo +"'>" + memberList[i].member_Id + "</a></td>");
                    	newRow.append("<td><input type='text' style='width: 60px' value='" + memberList[i].member_Name + "'></td>");
                    	newRow.append("<td>" + select_member_Sex + "</td>");
                    	newRow.append("<td>" + select_member_Position + "</td>");
                    	newRow.append("<td>" + select_member_Department + "</td>");
                    	newRow.append("<td><input type='text' id='member_Tel' style='width: 90px' value='" + memberList[i].member_Tel + "'></td>");
                    	newRow.append("<td>" + select_member_Skill_Language + "</td>");
                    	newRow.append("<td>" + select_member_Skill_DB + "</td>");
                    	newRow.append("<td><input type='date' id='member_startDate' value='" + memberList[i].member_startDate + "'></td>");
                    	newRow.append("<td><input type='date' id='member_endDate' value='" + memberList[i].member_endDate + "'></td>");
                    	//newRow.append("<td>" + (memberList[i].member_endDate === null ? '미정' : memberList[i].member_endDate) + "</td>");
                    	
                    	$("#memberTable tbody").append(newRow);
           			}
           			         			
           		}else{
           			console.log("memberList 가 NULL 이에요.")
           			$("#memberTable tbody").empty();
           		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
           		}	
			},    
			error : function(request, status, error) { // 결과 에러 콜백함수        
				//console.log("전송 실패")
			}
		});	//ajax EndPoint */
	}); //#modifyButton EndPoint	
	
	$("#mmodifyButton").click(function() {
		let member_Tel = $("#member_Tel").val();//입력한 전화번호
		let member_Tel_Check = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
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
					var modifyDatas = [];
					$('.checkbox:checked').each(function() {
			    		// 현재 체크박스를 포함하는 행(tr)을 가져옵니다.
			    		let row = $(this).closest('tr');

			    		// 행에서 필요한 데이터를 추출합니다.
			    		let data = {
								member_Id: row.find('td:eq(1) a').text(), // 첫 번째 <td>의 <a> 태그 내용
				        		member_Name: row.find('td:eq(2) input').val(), // 두 번째 <td>의 <input> 값
				        		member_Sex: row.find('td:eq(3) select').val(), // 세 번째 <td>의 텍스트
				        		member_Position: row.find('td:eq(4) select').val(), // ...
				        		member_Department: row.find('td:eq(5) select').val(),
				        		member_Tel: row.find('td:eq(6) input').val(),
				        		member_Skill_Language: row.find('td:eq(7) select').val(),
				        		member_Skill_DB: row.find('td:eq(8) select').val(),
				        		member_startDate: row.find('td:eq(9) input').val(),
				        		member_endDate: row.find('td:eq(10) input').val()
			    		};
						//alert("data : " + data);
			    		// 추출한 데이터를 배열에 추가합니다.
			    		modifyDatas.push(data);
					});
					//console.log("modifyDatas : " + modifyDatas);
					
					$.ajax({
						type : 'POST',
						url: '/member/memberModifyM',
						contentType : 'application/json; charset=utf-8',
						data: JSON.stringify(modifyDatas),
						success : function(result) { // 결과 성공 콜백함수        
							if(result == true){
								alert("수정 성공");
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberList?pageNo=" + pageNo;
								//location.href = "/member/memberRead?member_Id=" + member_Id + "&pageNo=" + pageNo;
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
					var modifyDatas = [];
					$('.checkbox:checked').each(function() {
			    		// 현재 체크박스를 포함하는 행(tr)을 가져옵니다.
			    		let row = $(this).closest('tr');

			    		// 행에서 필요한 데이터를 추출합니다.
			    		let data = {
								member_Id: row.find('td:eq(1) a').text(), // 첫 번째 <td>의 <a> 태그 내용
				        		member_Name: row.find('td:eq(2) input').val(), // 두 번째 <td>의 <input> 값
				        		member_Sex: row.find('td:eq(3) select').val(), // 세 번째 <td>의 텍스트
				        		member_Position: row.find('td:eq(4) select').val(), // ...
				        		member_Department: row.find('td:eq(5) select').val(),
				        		member_Tel: row.find('td:eq(6) input').val(),
				        		member_Skill_Language: row.find('td:eq(7) select').val(),
				        		member_Skill_DB: row.find('td:eq(8) select').val(),
				        		member_startDate: row.find('td:eq(9) input').val(),
				        		member_endDate: row.find('td:eq(10) input').val()
			    		};
			    		//alert("data : " + data);
			    		// 추출한 데이터를 배열에 추가합니다.
			    		modifyDatas.push(data);
			    		
					});
					//console.log("modifyDatas : " + modifyDatas);
					$.ajax({
						type : 'POST',
						url: '/member/memberModifyM',
						contentType : 'application/json; charset=utf-8',
						data: JSON.stringify(modifyDatas),
						success : function(result) { // 결과 성공 콜백함수        
							if(result == true){
								alert("수정 성공");
								var pageNo = $("#pageNo").val();
								location.href = "/member/memberList?pageNo=" + pageNo;
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
	
});//document EndPoint

function go(pageNo){
	let searchField = document.getElementById("searchField").value; 
	let searchWord = document.getElementById("searchWord").value;
	//var pageNo = document.getElementById("pageNo").value; 
	$.ajax({
		type : 'POST',
		url: '/member/memberList',
		data: {
			 "pageNo" : pageNo,
			 "searchWord" : searchWord,
			 "searchField" : searchField,
		},
		success : function(resultMap) { // 결과 성공 콜백함수    
			if (searchWord.trim() !== "") {
			    //console.log("검색어가 있습니다.");
			    location.href = "/member/memberList?pageNo=" + pageNo + "&searchWord=" + searchWord;
			} else {
			    //console.log("검색어가 없습니다.");
			    location.href = "/member/memberList?pageNo=" + pageNo;
			}
			
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint

function insertMember(){
	location.href = "/member/memberInsert";
}

</script>
</html>